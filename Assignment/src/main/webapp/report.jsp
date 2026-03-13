<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Báo Cáo Thống Kê</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f9f9f9;}
        .container { max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); text-align: center; }
        .back-link { display: block; text-align: left; margin-bottom: 20px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <%
        if(request.getSession().getAttribute("adminInfo") == null){
            response.sendRedirect("admin-login");
            return;
        }
    %>
    <div class="container">
        <a href="manage-xe" class="back-link">&larr; Quay lại quản lý xe</a>
        <h1>Báo Cáo Thống Kê</h1>
        <p>Tính năng báo cáo doanh thu / lưu lượng xe đang được phát triển...</p>
        <img src="https://via.placeholder.com/600x300.png?text=Chart+Placeholder" alt="Chart" style="max-width: 100%; height: auto; margin-top: 20px; border-radius: 4px;">
    </div>
</body>
</html>
