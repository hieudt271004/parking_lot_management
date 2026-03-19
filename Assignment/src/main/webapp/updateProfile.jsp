<%@page import="model.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("UserController?action=login");
        return;
    }
    String dobStr = "";
    if (currentUser.getBirthDate() != null) {
        dobStr = new SimpleDateFormat("yyyy-MM-dd").format(currentUser.getBirthDate());
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Thông Tin – FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-page-wrap {
            max-width: 520px;
            margin: 0 auto;
        }
        .form-page-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 32px;
            box-shadow: var(--shadow-md);
        }
        .form-page-card h2 {
            margin: 0 0 24px;
            font-size: 1.35rem;
            font-weight: 800;
            color: var(--text-primary);
        }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0 16px; }
        .form-grid .form-group { margin-bottom: 16px; }
        .form-grid .full { grid-column: 1 / -1; }
        .cancel-btn {
            display: block; text-align: center; margin-top: 14px;
            color: var(--text-muted); font-size: .88rem; text-decoration: none;
        }
        .cancel-btn:hover { color: var(--text-secondary); }
    </style>
</head>
<body style="padding: 36px 40px; min-height: 100vh; background: var(--bg-page);">
    <a href="UserController?action=profile" style="display:inline-flex; align-items:center; gap:6px;
        padding:8px 16px; border-radius:99px; background:rgba(99,102,241,.1); color:var(--primary-light);
        font-size:.85rem; font-weight:600; margin-bottom:20px; text-decoration:none;
        border:1px solid rgba(99,102,241,.2);">← Hồ sơ</a>

    <div class="form-page-wrap">
        <div class="form-page-card">
            <h2>✏️ Cập Nhật Hồ Sơ</h2>

            <% String error = (String) request.getAttribute("error");
               if (error != null) { %>
                <div class="error">⚠ <%= error %></div>
            <% } %>

            <form action="UserController" method="post">
                <input type="hidden" name="action" value="updateProfile">

                <div class="form-grid">
                    <div class="form-group full">
                        <label>Họ và Tên</label>
                        <input type="text" name="fullName"
                               value="<%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label>Giới tính</label>
                        <select name="gender">
                            <option value="Nam" <%= "Nam".equals(currentUser.getGender()) ? "selected" : "" %>>Nam</option>
                            <option value="Nu"  <%= "Nu".equals(currentUser.getGender())  ? "selected" : "" %>>Nữ</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Ngày sinh</label>
                        <input type="date" name="birthDate" value="<%= dobStr %>">
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" maxlength="10"
                               value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Quê quán</label>
                        <input type="text" name="hometown"
                               value="<%= currentUser.getHometown() != null ? currentUser.getHometown() : "" %>">
                    </div>
                    <div class="form-group full">
                        <label>Địa chỉ</label>
                        <input type="text" name="address"
                               value="<%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %>">
                    </div>
                </div>

                <input type="submit" value="💾 Lưu Thay Đổi" style="width:100%; margin-top:4px;">
            </form>
            <a href="UserController?action=profile" class="cancel-btn">← Hủy và quay lại</a>
        </div>
    </div>
</body>
</html>
