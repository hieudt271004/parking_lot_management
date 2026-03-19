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
    String msg = (String) request.getAttribute("message");
    String err = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FPT Parking – Nạp Tiền</title>
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
            <li onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li style="background:rgba(99,102,241,.25); color:var(--primary-light);" onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Tài khoản</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">🚪 Đăng xuất</button>
        </div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="main-content">
            <h2>💰 Nạp Tiền</h2>
            <div class="current-balance">
                <%= String.format("%,d", soDu).replace(',', '.') %>đ
            </div>

            <div class="form-card">
                <h3>💳 Chọn mệnh giá hoặc nhập số tiền</h3>

                <% if (msg != null) { %><div class="alert-success">✅ <%= msg %></div><% } %>
                <% if (err != null) { %><div class="alert-error">❌ <%= err %></div><% } %>

                <div class="preset-amounts">
                    <button class="preset-btn" onclick="setAmount(50000)">50.000đ</button>
                    <button class="preset-btn" onclick="setAmount(100000)">100.000đ</button>
                    <button class="preset-btn" onclick="setAmount(200000)">200.000đ</button>
                    <button class="preset-btn" onclick="setAmount(500000)">500.000đ</button>
                    <button class="preset-btn" onclick="setAmount(1000000)">1.000.000đ</button>
                </div>

                <form action="UserController" method="get" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="topup">
                    <div class="input-group">
                        <label for="amount">Số tiền (VND)</label>
                        <input type="number" id="amount" name="amount"
                               min="10000" placeholder="Ví dụ: 100000" required>
                    </div>
                    <button type="submit" class="btn-submit">Nạp Tiền Ngay</button>
                </form>
                <a href="homepage.jsp" class="btn-back">← Quay lại Dashboard</a>
            </div>
        </div>
    </div>
</div>

<script>
function setAmount(val) {
    document.getElementById('amount').value = val;
}
function validateForm() {
    const a = parseInt(document.getElementById('amount').value);
    if (isNaN(a) || a < 10000) {
        alert('Số tiền tối thiểu là 10.000đ!');
        return false;
    }
    return true;
}
</script>
</body>
</html>
