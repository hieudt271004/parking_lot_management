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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FPT Parking – Thông Tin Vé</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <h1>FPT Parking</h1>
        <img src="icon/user.png" class="avatar" alt="Avatar">
        <h3><%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty()
                ? currentUser.getFullName() : currentUser.getEmail() %></h3>
        <ul>
            <li onclick="window.location.href='homepage.jsp'">🏠 Dashboard</li>
            <li style="background:rgba(99,102,241,.25); color:var(--primary-light);" onclick="window.location.href='thongtinve.jsp'">🎫 Thông tin vé</li>
            <li onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Tài khoản</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">🚪 Đăng xuất</button>
        </div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="page-title">🎫 Thông Tin Vé</div>

        <div class="balance-bar">
            💳 Số dư: <strong><%= String.format("%,d", soDu).replace(',', '.') %>đ</strong>
            &nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="muave.jsp">Mua vé mới →</a>
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
                            <td style="color:var(--text-muted)"><%= stt++ %></td>
                            <td><code><%= ve.getStrMaVe() %></code></td>
                            <td><strong><%= loaiVeName %></strong></td>
                            <td><%= ve.getDateNgayKichHoat() != null ? sdf.format(ve.getDateNgayKichHoat()) : "—" %></td>
                            <td><%= ve.getDateNgayHetHan() != null ? sdf.format(ve.getDateNgayHetHan()) : "—" %></td>
                            <td>
                                <% if (conHan) { %>
                                    <span class="badge badge-active">✓ Còn hạn</span>
                                <% } else { %>
                                    <span class="badge badge-expired">✕ Hết hạn</span>
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
