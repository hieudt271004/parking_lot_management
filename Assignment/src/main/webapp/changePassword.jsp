<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("UserController?action=login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu – FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-page-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 32px;
            box-shadow: var(--shadow-md);
            max-width: 440px;
        }
        .form-page-card h2 { margin: 0 0 24px; font-size: 1.35rem; font-weight: 800; }
        .security-icon {
            text-align: center; font-size: 3rem; margin-bottom: 12px;
        }
        .cancel-btn {
            display: block; text-align: center; margin-top: 14px;
            color: var(--text-muted); font-size: .88rem; text-decoration: none;
        }
    </style>
</head>
<body style="padding: 36px 40px; min-height: 100vh; background: var(--bg-page);">
    <a href="UserController?action=profile" style="display:inline-flex; align-items:center; gap:6px;
        padding:8px 16px; border-radius:99px; background:rgba(99,102,241,.1); color:var(--primary-light);
        font-size:.85rem; font-weight:600; margin-bottom:20px; text-decoration:none;
        border:1px solid rgba(99,102,241,.2);">← Hồ sơ</a>

    <div class="form-page-card">
        <div class="security-icon">🔑</div>
        <h2 style="text-align:center;">Đổi Mật Khẩu</h2>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error">⚠ <%= error %></div>
        <% } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="updatePassword">

            <div class="form-group">
                <label>Mật khẩu hiện tại</label>
                <input type="password" name="oldPassword" placeholder="••••••••" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu mới</label>
                <input type="password" name="newPassword" placeholder="Ít nhất 6 ký tự" required>
            </div>
            <div class="form-group">
                <label>Xác nhận mật khẩu mới</label>
                <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
            </div>

            <input type="submit" value="🔒 Đổi Mật Khẩu" style="width:100%; margin-top:4px;
                background: linear-gradient(135deg, #f59e0b, #d97706);
                box-shadow: 0 4px 20px rgba(245,158,11,.35);">
        </form>
        <a href="UserController?action=profile" class="cancel-btn">← Hủy</a>
    </div>
</body>
</html>
