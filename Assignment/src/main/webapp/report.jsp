<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Báo Cáo Thống Kê</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="page-body">
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
