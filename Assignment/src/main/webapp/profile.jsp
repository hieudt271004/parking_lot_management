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
    <title>Thông Tin Cá Nhân – FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .profile-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 32px;
            max-width: 640px;
        }
        .profile-header {
            display: flex; align-items: center; gap: 20px;
            padding-bottom: 24px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 24px;
        }
        .profile-avatar {
            width: 72px; height: 72px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem;
            flex-shrink: 0;
        }
        .profile-header-info h2 { margin: 0 0 4px; font-size: 1.3rem; font-weight: 800; }
        .profile-header-info span {
            background: rgba(99,102,241,.15); color: var(--primary-light);
            border: 1px solid rgba(99,102,241,.3);
            padding: 3px 12px; border-radius: 99px; font-size: .78rem; font-weight: 700;
        }
        .info-row {
            display: flex; align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid var(--border);
            gap: 12px;
        }
        .info-row:last-of-type { border-bottom: none; }
        .info-icon { font-size: 1.1rem; width: 28px; text-align: center; flex-shrink: 0; }
        .info-label { font-size: .8rem; color: var(--text-muted); text-transform: uppercase;
            letter-spacing: .5px; font-weight: 600; min-width: 140px; }
        .info-value { font-size: .92rem; color: var(--text-primary); flex: 1; }
        .actions-row { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 24px; }
        .back-link { display: inline-flex; align-items: center; gap: 6px;
            padding: 8px 16px; border-radius: 99px;
            background: rgba(99,102,241,.1); color: var(--primary-light);
            font-size: .85rem; font-weight: 600; margin-bottom: 20px;
            text-decoration: none; border: 1px solid rgba(99,102,241,.2); }
        .back-link:hover { background: rgba(99,102,241,.2); }
    </style>
</head>
<body style="padding: 36px 40px; min-height: 100vh; background: var(--bg-page);">
    <a href="homepage.jsp" class="back-link">← Dashboard</a>

    <% String msg = (String) request.getAttribute("message");
       if (msg != null) { %>
        <div class="msg" style="max-width:640px; margin-bottom:16px;">✅ <%= msg %></div>
    <% } %>

    <div class="profile-card">
        <div class="profile-header">
            <div class="profile-avatar">👤</div>
            <div class="profile-header-info">
                <h2><%= currentUser.getFullName() != null ? currentUser.getFullName() : currentUser.getEmail() %></h2>
                <span><%= currentUser.getRole() != null ? currentUser.getRole() : "Khách hàng" %></span>
            </div>
        </div>

        <div class="info-row">
            <span class="info-icon">🆔</span>
            <span class="info-label">Mã Người Dùng</span>
            <span class="info-value"><code><%= currentUser.getId() %></code></span>
        </div>
        <div class="info-row">
            <span class="info-icon">✉️</span>
            <span class="info-label">Email</span>
            <span class="info-value"><%= currentUser.getEmail() %></span>
        </div>
        <div class="info-row">
            <span class="info-icon">⚧</span>
            <span class="info-label">Giới tính</span>
            <span class="info-value"><%= currentUser.getGender() != null ? currentUser.getGender() : "—" %></span>
        </div>
        <div class="info-row">
            <span class="info-icon">🎂</span>
            <span class="info-label">Ngày sinh</span>
            <span class="info-value"><%= currentUser.getBirthDate() != null
                ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(currentUser.getBirthDate()) : "—" %></span>
        </div>
        <div class="info-row">
            <span class="info-icon">📱</span>
            <span class="info-label">Số điện thoại</span>
            <span class="info-value"><%= currentUser.getPhone() != null ? currentUser.getPhone() : "—" %></span>
        </div>
        <div class="info-row">
            <span class="info-icon">🏠</span>
            <span class="info-label">Địa chỉ</span>
            <span class="info-value"><%= currentUser.getAddress() != null ? currentUser.getAddress() : "—" %></span>
        </div>
        <div class="info-row">
            <span class="info-icon">🌿</span>
            <span class="info-label">Quê quán</span>
            <span class="info-value"><%= currentUser.getHometown() != null ? currentUser.getHometown() : "—" %></span>
        </div>

        <div class="actions-row">
            <a href="UserController?action=editProfile" class="btn btn-add">✏️ Cập nhật</a>
            <a href="UserController?action=changePassword" class="btn btn-update">🔑 Đổi mật khẩu</a>
            <% if ("Nhan vien".equals(currentUser.getRole()) || "Quan ly".equals(currentUser.getRole())) { %>
                <a href="UserController?action=customerList" class="btn btn-edit">👥 Quản lý KH</a>
            <% } %>
            <a href="UserController?action=logout" class="btn btn-delete">🚪 Đăng xuất</a>
        </div>
    </div>
</body>
</html>
