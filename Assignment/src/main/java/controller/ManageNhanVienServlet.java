package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dal.NhanVienDAO;
import dto.NhanVienDTO;
import java.util.List;

@WebServlet(name = "ManageNhanVienServlet", urlPatterns = {"/manage-nhanvien"})
public class ManageNhanVienServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(request.getSession().getAttribute("adminInfo") == null){
            response.sendRedirect("admin-login");
            return;
        }
        
        NhanVienDAO dao = new NhanVienDAO();
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete":
                String idDelete = request.getParameter("id");
                dao.deleteNhanVien(idDelete);
                response.sendRedirect("manage-nhanvien");
                break;
            case "edit":
                String idEdit = request.getParameter("id");
                NhanVienDTO nvEdit = dao.getNhanVienById(idEdit);
                request.setAttribute("nv", nvEdit);
                request.getRequestDispatcher("manageNhanVien.jsp").forward(request, response);
                break;
            default:
                List<NhanVienDTO> list = dao.getAllNhanVien();
                request.setAttribute("listNV", list);
                request.getRequestDispatcher("manageNhanVien.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        NhanVienDAO dao = new NhanVienDAO();

        if ("add".equals(action)) {
            String maNV = request.getParameter("maNV");
            String viTri = request.getParameter("viTri");
            dao.addNhanVien(maNV, viTri);
        } else if ("update".equals(action)) {
            String maNV = request.getParameter("maNV");
            String viTri = request.getParameter("viTri");
            dao.updateNhanVien(maNV, viTri);
        }
        response.sendRedirect("manage-nhanvien");
    }
}
