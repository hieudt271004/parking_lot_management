<%@page import="java.util.List"%>
<%@page import="dto.KhachVangLaiDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Vãng Lai – FPT Parking Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <style> body { background: var(--bg-page); } .page-body { padding: 30px; min-height: 100vh; } </style>
</head>
<body class="page-body">
<div class="admin-wrap">

    <div class="header-links">
        <span>👋 Xin chào, <strong><%= session.getAttribute("adminInfo") %></strong></span>
        <a href="manage-xe">🚗 Xe</a>
        <a href="manage-nhanvien">👷 Nhân viên</a>
        <a href="manage-khachvanglai">🪪 Khách vãng lai</a>
        <a href="manage-ctravao">📋 Chi tiết ra vào</a>
        <a href="report.jsp">📊 Báo cáo</a>
        <a href="logout" style="background:rgba(239,68,68,.12); color:#fca5a5; border-color:rgba(239,68,68,.3);">🚪 Đăng xuất</a>
    </div>

    <h1>🪪 Quản Lý Khách Vãng Lai</h1>

    <%
        KhachVangLaiDTO editingKVL = (KhachVangLaiDTO) request.getAttribute("kvl");
        boolean isEdit = editingKVL != null;
    %>

    <div class="form-container">
        <h3><%= isEdit ? "✏️ Cập nhật Khách Vãng Lai" : "➕ Thêm Khách Vãng Lai Mới" %></h3>
        <form action="manage-khachvanglai" method="post">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
            <div class="form-group">
                <label>Mã Thẻ KVL</label>
                <input type="text" name="maTheKVL"
                       value="<%= isEdit ? editingKVL.getStrMaTheKVL() : "" %>"
                       <%= isEdit ? "readonly" : "required" %>
                       placeholder="VD: KVL001">
            </div>
            <div class="form-group">
                <label>Mã Xe</label>
                <input type="text" name="maXe"
                       value="<%= isEdit ? editingKVL.getStrMaXe() : "" %>"
                       required placeholder="VD: XE001">
            </div>
            <div style="display:flex; gap:10px; margin-top:8px;">
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "💾 Cập Nhật" : "➕ Thêm Mới" %>
                </button>
                <% if (isEdit) { %>
                    <a href="manage-khachvanglai" class="btn btn-secondary">✕ Hủy</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Mã Thẻ KVL</th>
                    <th>Mã Xe</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<KhachVangLaiDTO> list = (List<KhachVangLaiDTO>) request.getAttribute("listKVL");
                if (list != null && !list.isEmpty()) {
                    int stt = 1;
                    for (KhachVangLaiDTO kvl : list) {
            %>
                <tr>
                    <td style="color:var(--text-muted)"><%= stt++ %></td>
                    <td><code><%= kvl.getStrMaTheKVL() %></code></td>
                    <td><%= kvl.getStrMaXe() %></td>
                    <td>
                        <a href="manage-khachvanglai?action=edit&id=<%= kvl.getStrMaTheKVL() %>" class="btn btn-edit">✏️ Sửa</a>
                        <a href="manage-khachvanglai?action=delete&id=<%= kvl.getStrMaTheKVL() %>" class="btn btn-delete"
                           onclick="return confirm('Xóa thẻ KVL này?');">🗑 Xóa</a>
                    </td>
                </tr>
            <%  }
                } else { %>
                <tr>
                    <td colspan="4" style="text-align:center; color:var(--text-muted); padding:40px;">
                        🪪 Chưa có dữ liệu khách vãng lai
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
