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
    <title>FPT Parking - Mua Vé</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .sidebar ul li { cursor: pointer; list-style: none; padding: 10px; margin: 5px 0; border-radius: 5px; transition: background 0.3s;}
        .sidebar ul li:hover { background-color: rgba(255,255,255,0.1); }
        .main { padding: 40px; }
        .page-title { font-size: 1.8rem; font-weight: 700; margin-bottom: 8px; }
        .balance-bar { background: linear-gradient(135deg, #4F46E5, #10B981); color: white; padding: 16px 24px;
                       border-radius: 12px; margin-bottom: 30px; font-size: 1.1rem; font-weight: 600; }
        .ticket-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 20px; }
        .ticket-card { background: white; border-radius: 16px; padding: 28px; box-shadow: 0 4px 20px rgba(0,0,0,0.07);
                       border-top: 5px solid #4F46E5; transition: transform 0.2s; }
        .ticket-card:hover { transform: translateY(-5px); }
        .ticket-card .type-label { font-size: 0.85rem; color: #6B7280; text-transform: uppercase; letter-spacing: 1px; }
        .ticket-card .type-name { font-size: 1.4rem; font-weight: 700; color: #111827; margin: 8px 0; }
        .ticket-card .type-price { font-size: 1.6rem; font-weight: 800; color: #4F46E5; }
        .ticket-card .type-duration { font-size: 0.9rem; color: #6B7280; margin-top: 6px; margin-bottom: 20px; }
        .btn-buy { width: 100%; padding: 12px; background: #4F46E5; color: white; font-size: 1rem;
                   font-weight: 700; border: none; border-radius: 10px; cursor: pointer; transition: background 0.2s; }
        .btn-buy:hover { background: #4338CA; }
        .btn-buy.insufficient { background: #D1D5DB; color: #9CA3AF; cursor: not-allowed; }
        .alert-success { background: #D1FAE5; color: #065F46; padding: 14px 18px; border-radius: 10px; margin-bottom: 20px; font-weight: 600; }
        .alert-error { background: #FEE2E2; color: #991B1B; padding: 14px 18px; border-radius: 10px; margin-bottom: 20px; font-weight: 600; }
        .no-ticket { text-align: center; color: #6B7280; padding: 60px 20px; font-size: 1.1rem; }
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
            <li onclick="window.location.href='thongtinve.jsp'">🎫 Thông tin vé</li>
            <li onclick="window.location.href='muave.jsp'" style="background:rgba(255,255,255,0.15)">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Account</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">Logout</button>
        </div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="page-title">🛒 Mua Vé</div>

        <div class="balance-bar">
            💳 Số dư hiện tại: <strong><%= String.format("%,d", soDu).replace(',', '.') %>đ</strong>
            &nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="naptien.jsp" style="color:white; font-weight:normal;">Nạp thêm →</a>
        </div>

        <% if (msg != null) { %><div class="alert-success">✅ <%= msg %></div><% } %>
        <% if (err != null) { %><div class="alert-error">❌ <%= err %></div><% } %>

        <div class="ticket-grid">
            <% if (danhSachLoaiVe == null || danhSachLoaiVe.isEmpty()) { %>
                <div class="no-ticket">Không có loại vé nào. Vui lòng liên hệ quản lý.</div>
            <% } else {
                for (LoaiVeDTO lv : danhSachLoaiVe) {
                    String tenLoai = lv.getStrTenLoaiVe() != null ? lv.getStrTenLoaiVe() : "";
                    long gia = lv.getLongGiaVe();
                    boolean duTien = soDu >= gia;

                    String duration = "";
                    String colorTop = "#4F46E5";
                    if (tenLoai.toLowerCase().contains("lượt") || tenLoai.toLowerCase().contains("luot")) {
                        duration = "Sử dụng trong ngày";
                        colorTop = "#10B981";
                    } else if (tenLoai.toLowerCase().contains("tuần") || tenLoai.toLowerCase().contains("tuan")) {
                        duration = "7 ngày kể từ ngày mua";
                        colorTop = "#F59E0B";
                    } else if (tenLoai.toLowerCase().contains("tháng") || tenLoai.toLowerCase().contains("thang")) {
                        duration = "30 ngày kể từ ngày mua";
                        colorTop = "#EF4444";
                    } else {
                        duration = "Theo quy định";
                    }
            %>
                <div class="ticket-card" style="border-top-color: <%= colorTop %>;">
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
