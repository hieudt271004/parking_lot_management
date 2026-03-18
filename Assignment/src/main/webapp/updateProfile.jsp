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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cập Nhật Thông Tin</title>
     <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;}
        .container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 500px; margin: auto; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="date"], select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[type="submit"] { width: 100%; background-color: #28a745; color: white; padding: 10px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        input[type="submit"]:hover { background-color: #218838; }
        .error { color: red; text-align: center; margin-bottom: 10px;}
        .cancel-btn { display: block; text-align: center; margin-top: 15px; color: #666; text-decoration: none;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Cập Nhật Hồ Sơ</h2>
        
        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { out.println("<div class='error'>" + error + "</div>"); } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="updateProfile">
            
            <div class="form-group">
                <label>Họ và Tên:</label>
                <input type="text" name="fullName" value="<%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %>" required>
            </div>
            
            <div class="form-group">
                <label>Giới tính:</label>
                <select name="gender">
                    <option value="Nam" <%= "Nam".equals(currentUser.getGender()) ? "selected" : "" %>>Nam</option>
                    <option value="Nu" <%= "Nu".equals(currentUser.getGender()) ? "selected" : "" %>>Nữ</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Ngày sinh:</label>
                <input type="date" name="birthDate" value="<%= dobStr %>">
            </div>
            
            <div class="form-group">
                <label>Số điện thoại:</label>
                <input type="text" name="phone" maxlength="10" value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>">
            </div>
            
            <div class="form-group">
                <label>Địa chỉ:</label>
                <input type="text" name="address" value="<%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %>">
            </div>
            
            <div class="form-group">
                <label>Quê quán:</label>
                <input type="text" name="hometown" value="<%= currentUser.getHometown() != null ? currentUser.getHometown() : "" %>">
            </div>
            
            <input type="submit" value="Lưu Thay Đổi">
        </form>
        
        <a href="UserController?action=profile" class="cancel-btn">Hủy</a>
    </div>
</body>
</html>
