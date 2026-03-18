package controller;

import dal.CTRaVaoDAO;
import dto.CTRaVaoDTO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageCTRaVaoServlet", urlPatterns = {"/manage-ctravao"})
public class ManageCTRaVaoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("adminInfo") == null) {
            response.sendRedirect("admin-login");
            return;
        }

        CTRaVaoDAO dao = new CTRaVaoDAO();
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                dao.deleteCTRaVao(request.getParameter("id"));
                response.sendRedirect("manage-ctravao");
                break;
            case "edit":
                CTRaVaoDTO ctv = dao.getCTRaVaoById(request.getParameter("id"));
                request.setAttribute("ctv", ctv);
                request.getRequestDispatcher("manageCTRaVao.jsp").forward(request, response);
                break;
            default:
                List<CTRaVaoDTO> list = dao.getAllCTRaVao();
                request.setAttribute("listCTV", list);
                request.getRequestDispatcher("manageCTRaVao.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        CTRaVaoDAO dao = new CTRaVaoDAO();

        try {
            String maCTRaVao = request.getParameter("maCTRaVao");
            String strVao = request.getParameter("thoiGianVao");
            String strRa  = request.getParameter("thoiGianRa");
            String maKH   = request.getParameter("maKH");
            String maXe   = request.getParameter("maXe");
            String maTheKVL = request.getParameter("maTheKVL");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date tVao = (strVao != null && !strVao.trim().isEmpty()) ? sdf.parse(strVao) : null;
            Date tRa  = (strRa  != null && !strRa.trim().isEmpty())  ? sdf.parse(strRa)  : null;

            if ("add".equals(action)) {
                dao.addCTRaVao(maCTRaVao, tVao, tRa, maKH, maXe, maTheKVL);
            } else if ("update".equals(action)) {
                dao.updateCTRaVao(maCTRaVao, tVao, tRa, maKH, maXe, maTheKVL);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi xử lý CTRaVao: " + e.getMessage(), e);
        }
        response.sendRedirect("manage-ctravao");
    }
}
