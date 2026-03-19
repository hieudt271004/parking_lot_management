<%@page import="model.User"%>
<%@page import="dto.KhachHangDTO"%>
<%@page import="dto.LoaiVeDTO"%>
<%@page import="dal.KhachHangDAO"%>
<%@page import="dal.LoaiVeDAO"%>
<%@page import="java.util.List"%>
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

    LoaiVeDAO loaiVeDAO = new LoaiVeDAO();
    List<LoaiVeDTO> danhSachLoaiVe = loaiVeDAO.getAllLoaiVe();

    String msg = (String) request.getAttribute("message");
    String err = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FPT Parking – Mua Vé</title>
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
            <li onclick="window.location.href='thongtinve.jsp'">🎫 Thông tin vé</li>
            <li style="background:rgba(99,102,241,.25); color:var(--primary-light);" onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Tài khoản</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">🚪 Đăng xuất</button>
        </div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="page-title">🛒 Mua Vé</div>

        <div class="balance-bar">
            💳 Số dư hiện tại: <strong><%= String.format("%,d", soDu).replace(',', '.') %>đ</strong>
            &nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="naptien.jsp">Nạp thêm →</a>
        </div>

        <% if (msg != null) { %><div class="alert-success">✅ <%= msg %></div><% } %>
        <% if (err != null) { %><div class="alert-error">❌ <%= err %></div><% } %>

        <div class="ticket-grid">
            <% if (danhSachLoaiVe == null || danhSachLoaiVe.isEmpty()) { %>
                <div class="no-ticket" style="color:var(--text-muted); padding:60px 20px; font-size:1.1rem;">
                    😔 Không có loại vé nào. Vui lòng liên hệ quản lý.
                </div>
            <% } else {
                for (LoaiVeDTO lv : danhSachLoaiVe) {
                    String tenLoai = lv.getStrTenLoaiVe() != null ? lv.getStrTenLoaiVe() : "";
                    long gia = lv.getLongGiaVe();
                    boolean duTien = soDu >= gia;

                    String duration = "Theo quy định";
                    String colorTop = "linear-gradient(90deg, var(--primary), var(--accent))";
                    if (tenLoai.toLowerCase().contains("lượt") || tenLoai.toLowerCase().contains("luot")) {
                        duration = "Sử dụng trong ngày";
                        colorTop = "linear-gradient(90deg, #10b981, #059669)";
                    } else if (tenLoai.toLowerCase().contains("tuần") || tenLoai.toLowerCase().contains("tuan")) {
                        duration = "7 ngày kể từ ngày mua";
                        colorTop = "linear-gradient(90deg, #f59e0b, #d97706)";
                    } else if (tenLoai.toLowerCase().contains("tháng") || tenLoai.toLowerCase().contains("thang")) {
                        duration = "30 ngày kể từ ngày mua";
                        colorTop = "linear-gradient(90deg, #ef4444, #dc2626)";
                    }
            %>
                <div class="ticket-card" style="--card-top: <%= colorTop %>">
                    <div class="type-label">Loại vé</div>
                    <div class="type-name"><%= tenLoai %></div>
                    <div class="type-price"><%= String.format("%,d", gia).replace(',', '.') %>đ</div>
                    <div class="type-duration">⏱ <%= duration %></div>
                    <% if (duTien) { %>
                        <form action="UserController" method="get">
                            <input type="hidden" name="action" value="buyTicket">
                            <input type="hidden" name="maLoaiVe" value="<%= lv.getStrMaLoaiVe() %>">
                            <button type="submit" class="btn-buy">Mua ngay</button>
                        </form>
                    <% } else { %>
                        <button class="btn-buy insufficient" disabled title="Số dư không đủ">Không đủ tiền</button>
                    <% } %>
                </div>
            <% } } %>
        </div>
    </div>
</div>
</body>
</html>
