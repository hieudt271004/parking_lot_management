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
    <title>Đổi Mật Khẩu</title>
     <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;}
        .container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 400px; margin: auto; margin-top: 50px;}
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="password"] { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[type="submit"] { width: 100%; background-color: #ffc107; color: black; font-weight: bold; padding: 10px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        input[type="submit"]:hover { background-color: #e0a800; }
        .error { color: red; text-align: center; margin-bottom: 10px;}
        .cancel-btn { display: block; text-align: center; margin-top: 15px; color: #666; text-decoration: none;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Đổi Mật Khẩu</h2>
        
        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { out.println("<div class='error'>" + error + "</div>"); } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="updatePassword">
            
            <div class="form-group">
                <label>Mật khẩu hiện tại:</label>
                <input type="password" name="oldPassword" required>
            </div>
            
            <div class="form-group">
                <label>Mật khẩu mới:</label>
                <input type="password" name="newPassword" required>
            </div>
            
             <div class="form-group">
                <label>Xác nhận mật khẩu mới:</label>
                <input type="password" name="confirmPassword" required>
            </div>
            
            <input type="submit" value="Đổi mật khẩu">
        </form>
        
        <a href="UserController?action=profile" class="cancel-btn">Hủy</a>
    </div>
</body>
</html>
