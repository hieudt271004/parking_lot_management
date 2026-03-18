package controller;

import dal.KhachVangLaiDAO;
import dto.KhachVangLaiDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageKhachVangLaiServlet", urlPatterns = {"/manage-khachvanglai"})
public class ManageKhachVangLaiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(request.getSession().getAttribute("adminInfo") == null){
            response.sendRedirect("admin-login");
            return;
        }
        
        KhachVangLaiDAO dao = new KhachVangLaiDAO();
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete":
                String idDelete = request.getParameter("id");
                dao.deleteKhachVangLai(idDelete);
                response.sendRedirect("manage-khachvanglai");
                break;
            case "edit":
                String idEdit = request.getParameter("id");
                KhachVangLaiDTO kvlEdit = dao.getKhachVangLaiById(idEdit);
                request.setAttribute("kvl", kvlEdit);
                request.getRequestDispatcher("manageKhachVangLai.jsp").forward(request, response);
                break;
            default:
                List<KhachVangLaiDTO> list = dao.getAllKhachVangLai();
                request.setAttribute("listKVL", list);
                request.getRequestDispatcher("manageKhachVangLai.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        KhachVangLaiDAO dao = new KhachVangLaiDAO();

        if ("add".equals(action)) {
            String maTheKVL = request.getParameter("maTheKVL");
            String maXe = request.getParameter("maXe");
            dao.addKhachVangLai(maTheKVL, maXe);
        } else if ("update".equals(action)) {
            String maTheKVL = request.getParameter("maTheKVL");
            String maXe = request.getParameter("maXe");
            dao.updateKhachVangLai(maTheKVL, maXe);
        }
        response.sendRedirect("manage-khachvanglai");
    }
}
