<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dto.CTRaVaoDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Chi Tiết Ra Vào – FPT Parking Admin</title>
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

    <h1>📋 Quản Lý Chi Tiết Ra Vào</h1>

    <%
        CTRaVaoDTO editingCTV = (CTRaVaoDTO) request.getAttribute("ctv");
        boolean isEdit = editingCTV != null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        String tVao = (isEdit && editingCTV.getDateThoiGianVao() != null) ? sdf.format(editingCTV.getDateThoiGianVao()) : "";
        String tRa  = (isEdit && editingCTV.getDateThoiGianRa()  != null) ? sdf.format(editingCTV.getDateThoiGianRa())  : "";
    %>

    <div class="form-container">
        <h3><%= isEdit ? "✏️ Cập nhật Lượt Ra Vào" : "➕ Thêm Lượt Ra Vào Mới" %></h3>
        <form action="manage-ctravao" method="post">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">

            <div class="form-group">
                <label>Mã CT Ra Vào</label>
                <input type="text" name="maCTRaVao"
                       value="<%= isEdit ? editingCTV.getStrMaCTRaVao() : "" %>"
                       <%= isEdit ? "readonly" : "required" %>
                       placeholder="VD: CT001">
            </div>
            <div class="form-group">
                <label>Giờ vào</label>
                <input type="datetime-local" name="thoiGianVao" value="<%= tVao %>">
            </div>
            <div class="form-group">
                <label>Giờ ra</label>
                <input type="datetime-local" name="thoiGianRa" value="<%= tRa %>">
            </div>
            <div class="form-group">
                <label>Mã Khách Hàng</label>
                <input type="text" name="maKH"
                       value="<%= isEdit && editingCTV.getStrMaKH() != null ? editingCTV.getStrMaKH() : "" %>"
                       placeholder="VD: KH001">
            </div>
            <div class="form-group">
                <label>Mã Xe</label>
                <input type="text" name="maXe"
                       value="<%= isEdit && editingCTV.getStrMaXe() != null ? editingCTV.getStrMaXe() : "" %>"
                       required placeholder="VD: XE001">
            </div>
            <div class="form-group">
                <label>Mã Thẻ KVL</label>
                <input type="text" name="maTheKVL"
                       value="<%= isEdit && editingCTV.getStrMaTheKVL() != null ? editingCTV.getStrMaTheKVL() : "" %>"
                       placeholder="VD: KVL001 (nếu là khách vãng lai)">
            </div>
            <div style="display:flex; gap:10px; margin-top:8px;">
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "💾 Cập Nhật" : "➕ Thêm Mới" %>
                </button>
                <% if (isEdit) { %>
                    <a href="manage-ctravao" class="btn btn-secondary">✕ Hủy</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Mã CT</th>
                    <th>Giờ Vào</th>
                    <th>Giờ Ra</th>
                    <th>Mã KH</th>
                    <th>Mã Thẻ KVL</th>
                    <th>Mã Xe</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<CTRaVaoDTO> list = (List<CTRaVaoDTO>) request.getAttribute("listCTV");
                if (list != null && !list.isEmpty()) {
                    SimpleDateFormat displaySdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    int stt = 1;
                    for (CTRaVaoDTO ctv : list) {
            %>
                <tr>
                    <td style="color:var(--text-muted)"><%= stt++ %></td>
                    <td><code><%= ctv.getStrMaCTRaVao() %></code></td>
                    <td><%= ctv.getDateThoiGianVao() != null ? displaySdf.format(ctv.getDateThoiGianVao()) : "—" %></td>
                    <td>
                        <% if (ctv.getDateThoiGianRa() != null) { %>
                            <%= displaySdf.format(ctv.getDateThoiGianRa()) %>
                        <% } else { %>
                            <span style="color:var(--accent); font-weight:600; font-size:.82rem;">⏳ Đang gửi</span>
                        <% } %>
                    </td>
                    <td><%= ctv.getStrMaKH() != null ? ctv.getStrMaKH() : "—" %></td>
                    <td><%= ctv.getStrMaTheKVL() != null ? ctv.getStrMaTheKVL() : "—" %></td>
                    <td><%= ctv.getStrMaXe() != null ? ctv.getStrMaXe() : "—" %></td>
                    <td>
                        <a href="manage-ctravao?action=edit&id=<%= ctv.getStrMaCTRaVao() %>" class="btn btn-edit">✏️ Sửa</a>
                        <a href="manage-ctravao?action=delete&id=<%= ctv.getStrMaCTRaVao() %>" class="btn btn-delete"
                           onclick="return confirm('Xóa lượt này?');">🗑 Xóa</a>
                    </td>
                </tr>
            <%  }
                } else { %>
                <tr>
                    <td colspan="8" style="text-align:center; color:var(--text-muted); padding:40px;">
                        📋 Chưa có dữ liệu chi tiết ra vào
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
