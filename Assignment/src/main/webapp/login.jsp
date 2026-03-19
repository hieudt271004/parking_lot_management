<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập – FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .login-logo { font-size: 2.8rem; text-align:center; margin-bottom: 4px; }
        .login-logo-text { text-align:center; font-size:.78rem; text-transform:uppercase;
            letter-spacing:3px; color:var(--text-muted); margin-bottom:28px; }
        .login-container h2 { font-size:1.5rem; }
        .divider-or { display:flex; align-items:center; gap:10px; color:var(--text-muted);
            font-size:.8rem; margin: 6px 0 18px; }
        .divider-or::before, .divider-or::after { content:''; flex:1;
            height:1px; background:var(--border); }
    </style>
</head>
<body class="login-body">
    <div class="login-container" style="animation:fadeSlideUp .4s ease;">
        <div class="login-logo">🅿️</div>
        <div class="login-logo-text">FPT Parking System</div>
        <h2>Chào mừng trở lại</h2>
        <p class="subtitle">Đăng nhập để quản lý tài khoản của bạn</p>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error">⚠ <%= error %></div>
        <% } %>

        <% String msg = (String) request.getAttribute("message");
           if (msg != null) { %>
            <div class="msg">✅ <%= msg %></div>
        <% } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="your@email.com" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn-login">Đăng nhập →</button>
        </form>

        <div class="links">
            <p>Chưa có tài khoản? <a href="UserController?action=register">Đăng ký ngay</a></p>
        </div>
    </div>
</body>
</html>
