<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Admin – Quản Lý Bãi Giữ Xe</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .admin-badge {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(245,158,11,.12); border: 1px solid rgba(245,158,11,.3);
            color: #fcd34d; border-radius: var(--radius-full);
            padding: 4px 14px; font-size: .78rem; font-weight: 700;
            text-transform: uppercase; letter-spacing: 1px;
            margin-bottom: 20px;
        }
        .admin-login-wrap {
            display: flex; flex-direction: column; align-items: center;
        }
    </style>
</head>
<body class="login-body">
    <div class="login-container admin-login-wrap" style="animation:fadeSlideUp .4s ease;">
        <div class="admin-logo">🏢</div>
        <span class="admin-badge">⚡ Admin Panel</span>
        <h2 style="text-align:center; font-size:1.45rem; font-weight:800;
            background:linear-gradient(135deg,#fcd34d,#f59e0b);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent; margin:0 0 4px;">
            Quản Lý Bãi Giữ Xe
        </h2>
        <p class="subtitle">Đăng nhập bằng email nhân viên</p>

        <% if(request.getAttribute("error") != null) { %>
            <div class="error">⚠ <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="admin-login" method="post" style="width:100%;">
            <div class="form-group">
                <label for="username">Email</label>
                <input type="email" id="username" name="username"
                       placeholder="admin@parking.com" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password"
                       placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn-login" style="
                background: linear-gradient(135deg,#f59e0b,#d97706);
                box-shadow: 0 4px 20px rgba(245,158,11,.4);">
                Đăng Nhập →
            </button>
        </form>

        <p style="text-align:center; margin-top:18px; font-size:.78rem; color:var(--text-muted);">
            🔒 Chỉ nhân viên được phép đăng nhập
        </p>
    </div>
</body>
</html>
