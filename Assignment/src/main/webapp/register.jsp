<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký – FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .reg-container {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 36px 44px;
            width: 520px;
            box-shadow: var(--shadow-lg), var(--shadow-glow);
            animation: fadeSlideUp .4s ease;
        }
        .reg-container h2 {
            text-align: center;
            font-size: 1.5rem; font-weight: 800; margin: 0 0 4px;
            background: linear-gradient(135deg, var(--primary-light), var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .reg-container p.subtitle { text-align:center; color:var(--text-muted); font-size:.85rem; margin:0 0 24px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0 16px; }
        .form-grid .form-group { margin-bottom: 14px; }
        .form-grid .full { grid-column: 1 / -1; }
    </style>
</head>
<body class="login-body" style="padding:30px 0;">
    <div class="reg-container">
        <div style="text-align:center; font-size:2.2rem; margin-bottom:4px;">🅿️</div>
        <h2>Đăng Ký Tài Khoản</h2>
        <p class="subtitle">Tạo tài khoản mới để sử dụng dịch vụ FPT Parking</p>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error">⚠ <%= error %></div>
        <% } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="register">

            <div class="form-grid">
                <div class="form-group full">
                    <label>Mã Khách Hàng <span style="color:var(--text-muted)">(tối đa 5 ký tự)</span></label>
                    <input type="text" name="id" maxlength="5" placeholder="VD: KH001" required>
                </div>
                <div class="form-group full">
                    <label>Họ và Tên</label>
                    <input type="text" name="fullName" placeholder="Nguyễn Văn A" required>
                </div>
                <div class="form-group full">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="your@email.com" required>
                </div>
                <div class="form-group full">
                    <label>Mật khẩu</label>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
                <div class="form-group">
                    <label>Giới tính</label>
                    <select name="gender">
                        <option value="Nam">Nam</option>
                        <option value="Nu">Nữ</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Ngày sinh</label>
                    <input type="date" name="birthDate">
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="phone" maxlength="10" placeholder="0901234567">
                </div>
                <div class="form-group">
                    <label>Quê quán</label>
                    <input type="text" name="hometown" placeholder="Hà Nội">
                </div>
                <div class="form-group full">
                    <label>Địa chỉ</label>
                    <input type="text" name="address" placeholder="123 Đường ABC, Quận 1">
                </div>
            </div>

            <input type="submit" value="Hoàn tất đăng ký →" style="width:100%; margin-top:6px;">
        </form>

        <div class="links">
            <p>Đã có tài khoản? <a href="UserController?action=login">Đăng nhập</a></p>
        </div>
    </div>
</body>
</html>
