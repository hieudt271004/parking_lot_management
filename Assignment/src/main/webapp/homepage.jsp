<%@page import="model.User"%>
<%@page import="dto.KhachHangDTO"%>
<%@page import="dal.KhachHangDAO"%>
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
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .sidebar ul li { cursor: pointer; list-style: none; padding: 10px; margin: 5px 0; border-radius: 5px; transition: background 0.3s;}
        .sidebar ul li:hover { background-color: rgba(255,255,255,0.1); }
        .sidebar ul li a { text-decoration: none; color: inherit; display: block; }
    </style>
</head>
<body>

<div class="container">

    <!-- Sidebar -->
    <div class="sidebar">
        <h1>FPT PARKING</h1>
        <img src="icon/user.png" class="avatar" alt="Avatar">

        <h3 id="name"><%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty() ? currentUser.getFullName() : currentUser.getEmail() %></h3>

        <ul>
            <li onclick="window.location.href='homepage.jsp'" style="background:rgba(255,255,255,0.15)">🏠 Dashboard</li>
            <li onclick="window.location.href='thongtinve.jsp'">🎫 Thông tin vé</li>
            <li onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Account</li>
        </ul>

        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">Logout</button>
        </div>
    </div>

    <!-- Main content -->
    <div class="main">
        <h2>SỐ DƯ</h2>
        <div class="balance"><%= String.format("%,d", soDu).replace(',', '.') %>đ</div>

        <div class="cards">
            <div class="card" onclick="window.location.href='thongtinve.jsp'" style="cursor:pointer">
                <img src="icon/ticket.png" alt="Ticket">
                <button>Thông tin vé</button>
            </div>

            <div class="card" onclick="window.location.href='muave.jsp'" style="cursor:pointer">
                <img src="icon/buy.png" alt="Buy">
                <button>Mua vé</button>
            </div>

            <div class="card" onclick="window.location.href='naptien.jsp'" style="cursor:pointer">
                <img src="icon/money.png" alt="Money">
                <button>Nạp tiền</button>
            </div>

            <div class="card">
                <img src="icon/cart.png" alt="Cart">
                <button>Giỏ hàng</button>
            </div>
        </div>
    </div>

</div>

<script>
function napTien() {
    let amount = prompt("Nhập số tiền muốn nạp (VND):");
    if (amount != null && amount.trim() !== '') {
        amount = amount.replace(/,/g, '').replace(/\./g, '');
        if (!isNaN(amount) && parseInt(amount) > 0) {
            window.location.href = "UserController?action=topup&amount=" + parseInt(amount);
        } else {
            alert("Số tiền không hợp lệ!");
        }
    }
}
</script>

</body>
</html>