<%@page import="java.util.List"%>
<%@page import="model.Xe"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Xe – FPT Parking Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { background: var(--bg-page); }
        .page-body { padding: 30px; min-height: 100vh; }
    </style>
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

    <h1>🚗 Quản Lý Thông Tin Xe</h1>

    <%
        Xe editingXe = (Xe) request.getAttribute("xe");
        boolean isEdit = editingXe != null;
    %>

    <div class="form-container">
        <h3><%= isEdit ? "✏️ Cập nhật thông tin Xe" : "➕ Thêm Xe Mới" %></h3>
        <form action="manage-xe" method="post">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">

            <div class="form-group">
                <label>Mã Xe</label>
                <input type="text" name="maXe"
                       value="<%= isEdit ? editingXe.getMaXe() : "" %>"
                       <%= isEdit ? "readonly" : "required" %>
                       placeholder="VD: XE001">
            </div>
            <div class="form-group">
                <label>Biển Số Xe</label>
                <input type="text" name="bienSo"
                       value="<%= isEdit ? editingXe.getBienSo() : "" %>"
                       required placeholder="VD: 59A-12345">
            </div>
            <div class="form-group">
                <label>Loại Xe</label>
                <select name="loaiXe" required>
                    <option value="">-- Chọn loại xe --</option>
                    <option value="Xe may" <%= (isEdit && "Xe may".equals(editingXe.getLoaiXe())) ? "selected" : "" %>>🏍 Xe máy</option>
                    <option value="Xe dap" <%= (isEdit && "Xe dap".equals(editingXe.getLoaiXe())) ? "selected" : "" %>>🚲 Xe đạp</option>
                </select>
            </div>
            <div style="display:flex; gap:10px; margin-top:8px;">
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "💾 Cập Nhật" : "➕ Thêm Mới" %>
                </button>
                <% if (isEdit) { %>
                    <a href="manage-xe" class="btn btn-secondary">✕ Hủy</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Mã Xe</th>
                    <th>Biển Số Xe</th>
                    <th>Loại Xe</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Xe> list = (List<Xe>) request.getAttribute("listX");
                if (list != null && !list.isEmpty()) {
                    int stt = 1;
                    for (Xe x : list) {
            %>
                <tr>
                    <td style="color:var(--text-muted)"><%= stt++ %></td>
                    <td><code><%= x.getMaXe() %></code></td>
                    <td><strong><%= x.getBienSo() %></strong></td>
                    <td><span class="badge" style="background:rgba(99,102,241,.15);color:var(--primary-light);border:1px solid rgba(99,102,241,.3);">
                        <%= x.getLoaiXe() %>
                    </span></td>
                    <td>
                        <a href="manage-xe?action=edit&id=<%= x.getMaXe() %>" class="btn btn-edit">✏️ Sửa</a>
                        <a href="manage-xe?action=delete&id=<%= x.getMaXe() %>" class="btn btn-delete"
                           onclick="return confirm('Xóa xe <%= x.getMaXe() %>?');">🗑 Xóa</a>
                    </td>
                </tr>
            <%  }
                } else { %>
                <tr>
                    <td colspan="5" style="text-align:center; color:var(--text-muted); padding:40px;">
                        🚗 Chưa có dữ liệu xe
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
