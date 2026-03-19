<%@page import="model.User"%>
<%@page import="dto.KhachHangDTO"%>
<%@page import="dto.VeDTO"%>
<%@page import="dto.LoaiVeDTO"%>
<%@page import="dal.KhachHangDAO"%>
<%@page import="dal.VeDAO"%>
<%@page import="dal.LoaiVeDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("UserController?action=login");
        return;
    }
    KhachHangDAO khDAO = new KhachHangDAO();
    KhachHangDTO kh = khDAO.layKhachHangTheoMa(currentUser.getId());
    long soDu = (kh != null) ? kh.getLongSoDu() : 0;

    VeDAO veDAO = new VeDAO();
    List<VeDTO> danhSachVe = veDAO.getVeByMaKH(currentUser.getId());

    LoaiVeDAO loaiVeDAO = new LoaiVeDAO();
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    Date now = new Date();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>FPT Parking - Thông Tin Vé</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .sidebar ul li { cursor: pointer; list-style: none; padding: 10px; margin: 5px 0; border-radius: 5px; transition: background 0.3s;}
        .sidebar ul li:hover { background-color: rgba(255,255,255,0.1); }
        .main { padding: 40px; }
        .page-title { font-size: 1.8rem; font-weight: 700; margin-bottom: 24px; }
        .ve-table-wrap { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.07); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #4F46E5; color: white; padding: 14px 18px; text-align: left; font-weight: 600; }
        td { padding: 14px 18px; border-bottom: 1px solid #F3F4F6; color: #374151; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #F9FAFB; }
        .badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 700; }
        .badge-active { background: #D1FAE5; color: #065F46; }
        .badge-expired { background: #FEE2E2; color: #991B1B; }
        .empty-state { text-align: center; padding: 80px 20px; color: #9CA3AF; }
        .empty-state a { color: #4F46E5; font-weight: 600; }
        .balance-bar { background: linear-gradient(135deg, #4F46E5, #10B981); color: white; padding: 16px 24px;
                       border-radius: 12px; margin-bottom: 24px; font-size: 1.1rem; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <h1>FPT PARKING</h1>
        <img src="icon/user.png" class="avatar" alt="Avatar">
        <h3><%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty() ? currentUser.getFullName() : currentUser.getEmail() %></h3>
        <ul>
            <li onclick="window.location.href='homepage.jsp'">🏠 Dashboard</li>
            <li onclick="window.location.href='thongtinve.jsp'" style="background:rgba(255,255,255,0.15)">🎫 Thông tin vé</li>
            <li onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Account</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">Logout</button>
        </div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="page-title">🎫 Thông Tin Vé</div>

        <div class="balance-bar">
            💳 Số dư: <strong><%= String.format("%,d", soDu).replace(',', '.') %>đ</strong>
            &nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="muave.jsp" style="color:white;">Mua vé mới →</a>
        </div>

        <div class="ve-table-wrap">
            <% if (danhSachVe == null || danhSachVe.isEmpty()) { %>
                <div class="empty-state">
                    <p style="font-size:3rem;">🎫</p>
                    <p style="font-size:1.1rem; margin-bottom:12px;">Bạn chưa có vé nào.</p>
                    <a href="muave.jsp">Mua vé ngay →</a>
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Mã Vé</th>
                            <th>Loại Vé</th>
                            <th>Ngày Kích Hoạt</th>
                            <th>Ngày Hết Hạn</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% int stt = 1; for (VeDTO ve : danhSachVe) {
                        boolean conHan = ve.getDateNgayHetHan() != null && ve.getDateNgayHetHan().after(now);
                        String loaiVeName = ve.getStrMaLoaiVe();
                        LoaiVeDTO lv = loaiVeDAO.getLoaiVeById(ve.getStrMaLoaiVe());
                        if (lv != null) loaiVeName = lv.getStrTenLoaiVe();
                    %>
                        <tr>
                            <td><%= stt++ %></td>
                            <td><code><%= ve.getStrMaVe() %></code></td>
                            <td><strong><%= loaiVeName %></strong></td>
                            <td><%= ve.getDateNgayKichHoat() != null ? sdf.format(ve.getDateNgayKichHoat()) : "-" %></td>
                            <td><%= ve.getDateNgayHetHan() != null ? sdf.format(ve.getDateNgayHetHan()) : "-" %></td>
                            <td>
                                <% if (conHan) { %>
                                    <span class="badge badge-active">Còn hạn</span>
                                <% } else { %>
                                    <span class="badge badge-expired">Hết hạn</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
