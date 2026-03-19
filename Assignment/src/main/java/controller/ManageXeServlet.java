package controller;

import dal.AdminDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Xe;

@WebServlet(name = "ManageXeServlet", urlPatterns = {"/manage-xe"})
public class ManageXeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check login session
        if(request.getSession().getAttribute("adminInfo") == null){
            response.sendRedirect("admin-login");
            return;
        }

        AdminDAO dao = new AdminDAO();
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete":
                String idDelete = request.getParameter("id");
                dao.deleteXe(idDelete);
                response.sendRedirect("manage-xe");
                break;
            case "edit":
                String idEdit = request.getParameter("id");
                Xe xeEdit = dao.getXeById(idEdit);
                request.setAttribute("xe", xeEdit);
                request.getRequestDispatcher("manageXe.jsp").forward(request, response);
                break;
            default:
                List<Xe> list = dao.getAllXe();
                request.setAttribute("listX", list);
                request.getRequestDispatcher("manageXe.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        AdminDAO dao = new AdminDAO();

        if ("add".equals(action)) {
            String maXe = request.getParameter("maXe");
            String bienSo = request.getParameter("bienSo");
            String loaiXe = request.getParameter("loaiXe");
            dao.addXe(maXe, bienSo, loaiXe);
        } else if ("update".equals(action)) {
            String maXe = request.getParameter("maXe");
            String bienSo = request.getParameter("bienSo");
            String loaiXe = request.getParameter("loaiXe");
            dao.updateXe(maXe, bienSo, loaiXe);
        }
        response.sendRedirect("manage-xe");
    }
}
