<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background-color: white; padding: 20px 40px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 300px; }
        h2 { text-align: center; color: #333; }
        input[type="email"], input[type="password"] { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;}
        input[type="submit"] { width: 100%; background-color: #28a745; color: white; padding: 10px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        input[type="submit"]:hover { background-color: #218838; }
        .error { color: red; text-align: center; margin-bottom: 10px;}
        .msg { color: green; text-align: center; margin-bottom: 10px;}
        .links { text-align: center; margin-top: 15px; }
        .links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng nhập Hệ Thống</h2>

        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { out.println("<div class='error'>" + error + "</div>"); } %>
           
        <% String msg = (String) request.getAttribute("message"); 
           if (msg != null) { out.println("<div class='msg'>" + msg + "</div>"); } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="login">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>
            
            <input type="submit" value="Đăng nhập">
        </form>
        
        <div class="links">
            <p>Chưa có tài khoản? <a href="UserController?action=register">Đăng ký ngay</a></p>
        </div>
    </div>
</body>
</html>
