<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo Cáo Thống Kê – FPT Parking Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { background: var(--bg-page); }
        .page-body { padding: 30px; min-height: 100vh; }
        .coming-soon {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 60px 40px;
            text-align: center;
            max-width: 600px;
        }
        .coming-soon .icon { font-size: 4rem; margin-bottom: 16px; }
        .coming-soon h2 { font-size: 1.5rem; font-weight: 800; margin: 0 0 8px; }
        .coming-soon p { color: var(--text-muted); font-size: .92rem; line-height: 1.6; }
        .stat-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px,1fr)); gap: 18px; margin-bottom: 28px; }
        .stat-card {
            background: var(--bg-card); border: 1px solid var(--border);
            border-radius: var(--radius-md); padding: 22px 24px;
        }
        .stat-card .stat-label { font-size: .78rem; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted); }
        .stat-card .stat-value { font-size: 2rem; font-weight: 900; margin-top: 8px; }
    </style>
</head>
<body class="page-body">
<%
    if(request.getSession().getAttribute("adminInfo") == null){
        response.sendRedirect("admin-login");
        return;
    }
%>
<div class="admin-wrap">
    <div class="header-links">
        <span>👋 Xin chào, <strong><%= request.getSession().getAttribute("adminInfo") %></strong></span>
        <a href="manage-xe">🚗 Xe</a>
        <a href="manage-nhanvien">👷 Nhân viên</a>
        <a href="manage-khachvanglai">🪪 Khách vãng lai</a>
        <a href="manage-ctravao">📋 Chi tiết ra vào</a>
        <a href="report.jsp">📊 Báo cáo</a>
        <a href="logout" style="background:rgba(239,68,68,.12); color:#fca5a5; border-color:rgba(239,68,68,.3);">🚪 Đăng xuất</a>
    </div>

    <h1>📊 Báo Cáo Thống Kê</h1>

    <!-- Placeholder stats -->
    <div class="stat-grid">
        <div class="stat-card">
            <div class="stat-label">🚗 Tổng xe đăng ký</div>
            <div class="stat-value" style="color:var(--primary-light);">—</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">🎫 Vé đang hiệu lực</div>
            <div class="stat-value" style="color:var(--accent);">—</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">💰 Doanh thu tháng</div>
            <div class="stat-value" style="color:#fcd34d;">—</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">👥 Khách vãng lai</div>
            <div class="stat-value" style="color:#f87171;">—</div>
        </div>
    </div>

    <div style="display:flex; justify-content:center;">
        <div class="coming-soon">
            <div class="icon">🚧</div>
            <h2>Đang phát triển</h2>
            <p>Tính năng báo cáo doanh thu và thống kê lưu lượng xe<br>đang được phát triển. Vui lòng quay lại sau!</p>
        </div>
    </div>
</div>
</body>
</html>
