package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/admin-login"})
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the admin login page
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Here you would check against the DB in real app
        // For demonstration, dummy validation
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        if("admin".equals(user) && "admin123".equals(pass)){
            request.getSession().setAttribute("adminInfo", user);
            response.sendRedirect("manage-xe"); // redirect to vehicle management after login
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }
}
