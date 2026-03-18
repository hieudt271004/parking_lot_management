<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - Quản Lý Bãi Giữ Xe</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="login-body">
    <div class="login-container">
        <h2>🅿️ Quản Lý Bãi Giữ Xe</h2>
        <p style="text-align:center; color:#666; margin-bottom:20px; font-size:14px;">Đăng nhập bằng Email nhân viên</p>
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="admin-login" method="post">
            <div class="form-group">
                <label for="username">Email</label>
                <input type="email" id="username" name="username" placeholder="admin@parking.com" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn-login">Đăng Nhập</button>
        </form>
        <p style="text-align:center; margin-top:15px; font-size:12px; color:#999;">
            Chỉ nhân viên mới có quyền đăng nhập
        </p>
    </div>
</body>
</html>
