<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng ký Khách Hàng</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;}
        .container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 500px; margin: auto; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="email"], input[type="password"], input[type="date"], select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[type="submit"] { width: 100%; background-color: #007bff; color: white; padding: 10px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        input[type="submit"]:hover { background-color: #0056b3; }
        .error { color: red; text-align: center; margin-bottom: 10px;}
        .links { text-align: center; margin-top: 15px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng Ký Tài Khoản</h2>
        
        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { out.println("<div class='error'>" + error + "</div>"); } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="register">
            
            <div class="form-group">
                <label>Mã Khách Hàng (Tối đa 5 ký tự):</label>
                <input type="text" name="id" maxlength="5" required>
            </div>
            <div class="form-group">
                <label>Họ và Tên:</label>
                <input type="text" name="fullName" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu:</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>Giới tính:</label>
                <select name="gender">
                    <option value="Nam">Nam</option>
                    <option value="Nu">Nữ</option>
                </select>
            </div>
            <div class="form-group">
                <label>Ngày sinh:</label>
                <input type="date" name="birthDate">
            </div>
            <div class="form-group">
                <label>Số điện thoại:</label>
                <input type="text" name="phone" maxlength="10">
            </div>
            <div class="form-group">
                <label>Địa chỉ:</label>
                <input type="text" name="address">
            </div>
            <div class="form-group">
                <label>Quê quán:</label>
                <input type="text" name="hometown">
            </div>
            
            <input type="submit" value="Hoàn tất đăng ký">
        </form>
        
        <div class="links">
            <p>Đã có tài khoản? <a href="UserController?action=login">Đăng nhập</a></p>
        </div>
    </div>
</body>
</html>
