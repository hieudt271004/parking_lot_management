package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageNhanVienServlet", urlPatterns = {"/manage-nhanvien"})
public class ManageNhanVienServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(request.getSession().getAttribute("adminInfo") == null){
            response.sendRedirect("admin-login");
            return;
        }
        
        // This is a placeholder for NhanVien Management Logic.
        // It operates similarly to ManageXeServlet.
        response.getWriter().println("<h1>Manage Nhan Vien Page Placeholder</h1>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
