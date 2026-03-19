package controller;

import dal.LoginDAO;
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

        // If already logged in, redirect directly to manage-xe
        if (request.getSession().getAttribute("adminInfo") != null) {
            response.sendRedirect("manage-xe");
            return;
        }
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String email   = request.getParameter("username");  // reuse "username" field as email
        String matKhau = request.getParameter("password");

        try {
            LoginDAO loginDAO = new LoginDAO();
            String hoTen = loginDAO.authenticate(email, matKhau);

            if (hoTen != null) {
                request.getSession().setAttribute("adminInfo", hoTen);
                response.sendRedirect("manage-xe");
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không đúng, hoặc bạn không có quyền truy cập!");
                request.getRequestDispatcher("admin.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Lỗi kết nối database: " + ex.getMessage());
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }
}
