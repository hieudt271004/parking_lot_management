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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Hồ sơ cá nhân</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;}
        .container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        h2 { text-align: center; color: #333; border-bottom: 2px solid #007bff; padding-bottom: 10px;}
        .profile-info { margin-top: 20px; }
        .profile-info p { border-bottom: 1px solid #eee; padding: 10px 0; margin: 0; }
        .profile-info strong { display: inline-block; width: 150px; color: #555;}
        .actions { margin-top: 20px; display: flex; flex-wrap: wrap; gap: 10px; justify-content: center;}
        .btn { padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; text-align: center;}
        .btn-danger { background-color: #dc3545; }
        .btn-warning { background-color: #ffc107; color: black;}
        .btn:hover { opacity: 0.9; }
        .msg { color: green; text-align: center; margin-bottom: 10px; padding: 10px; background-color: #d4edda; border-radius: 4px;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Thông Tin Cá Nhân</h2>
        
        <% String msg = (String) request.getAttribute("message"); 
           if (msg != null) { out.println("<div class='msg'>" + msg + "</div>"); } %>

        <div class="profile-info">
            <p><strong>Mã Người Dùng:</strong> <%= currentUser.getId() %></p>
            <p><strong>Họ và Tên:</strong> <%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %></p>
            <p><strong>Email:</strong> <%= currentUser.getEmail() %></p>
            <p><strong>Giới tính:</strong> <%= currentUser.getGender() != null ? currentUser.getGender() : "" %></p>
            <p><strong>Ngày sinh:</strong> <%= currentUser.getBirthDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(currentUser.getBirthDate()) : "" %></p>
            <p><strong>Số điện thoại:</strong> <%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %></p>
            <p><strong>Địa chỉ:</strong> <%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %></p>
            <p><strong>Quê quán:</strong> <%= currentUser.getHometown() != null ? currentUser.getHometown() : "" %></p>
            <p><strong>Vai trò:</strong> <%= currentUser.getRole() %></p>
        </div>

        <div class="actions">
            <a href="UserController?action=editProfile" class="btn">Cập nhật thông tin</a>
            <a href="UserController?action=changePassword" class="btn btn-warning">Đổi mật khẩu</a>
            
            <%-- Simple check for role to show manager link --%>
            <% if ("Nhan vien".equals(currentUser.getRole()) || "Quan ly".equals(currentUser.getRole())) { %>
                <a href="UserController?action=customerList" class="btn" style="background-color: #17a2b8;">Quản lý khách hàng</a>
            <% } %>
            
            <a href="UserController?action=logout" class="btn btn-danger">Đăng xuất</a>
        </div>
    </div>
</body>
</html>
