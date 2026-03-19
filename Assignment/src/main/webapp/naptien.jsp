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
    <title>FPT Parking - Nạp Tiền</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .sidebar ul li { cursor: pointer; list-style: none; padding: 10px; margin: 5px 0; border-radius: 5px; transition: background 0.3s;}
        .sidebar ul li:hover { background-color: rgba(255,255,255,0.1); }
        .main-content { padding: 40px; max-width: 500px; }
        .main-content h2 { font-size: 1.8rem; margin-bottom: 8px; }
        .current-balance { font-size: 2rem; font-weight: 700; color: #4F46E5; margin-bottom: 30px; }
        .form-card { background: white; border-radius: 16px; padding: 32px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .form-card h3 { font-size: 1.2rem; margin-bottom: 24px; color: #374151; }
        .preset-amounts { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px; }
        .preset-btn { padding: 10px 20px; border: 2px solid #4F46E5; border-radius: 8px; background: white;
                      color: #4F46E5; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .preset-btn:hover { background: #4F46E5; color: white; }
        .input-group { margin-bottom: 20px; }
        .input-group label { display: block; font-weight: 600; margin-bottom: 8px; color: #374151; }
        .input-group input { width: 100%; padding: 14px; border: 2px solid #E5E7EB; border-radius: 10px;
                             font-size: 1.1rem; outline: none; transition: border 0.2s; }
        .input-group input:focus { border-color: #4F46E5; }
        .btn-submit { width: 100%; padding: 14px; background: #4F46E5; color: white; font-size: 1.1rem;
                      font-weight: 700; border: none; border-radius: 10px; cursor: pointer; transition: background 0.2s; }
        .btn-submit:hover { background: #4338CA; }
        .btn-back { display: block; margin-top: 16px; text-align: center; color: #6B7280; text-decoration: none; }
        .alert-success { background: #D1FAE5; color: #065F46; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px; font-weight: 600; }
        .alert-error { background: #FEE2E2; color: #991B1B; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px; font-weight: 600; }
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
            <li onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'" style="background:rgba(255,255,255,0.15)">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Account</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">Logout</button>
        </div>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="main-content">
            <h2>Nạp Tiền</h2>
            <div class="current-balance">Số dư: <%= String.format("%,d", soDu).replace(',', '.') %>đ</div>

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
                        <input type="number" id="amount" name="amount" min="10000" placeholder="Ví dụ: 100000" required>
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
