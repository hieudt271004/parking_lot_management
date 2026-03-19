<%@page import="java.util.List"%>
<%@page import="dto.NhanVienDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nhân Viên – FPT Parking Admin</title>
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

    <h1>👷 Quản Lý Nhân Viên</h1>

    <%
        NhanVienDTO editingNV = (NhanVienDTO) request.getAttribute("nv");
        boolean isEdit = editingNV != null;
    %>

    <div class="form-container">
        <h3><%= isEdit ? "✏️ Cập nhật Nhân Viên" : "➕ Thêm Nhân Viên Mới" %></h3>
        <p style="color:var(--text-muted); font-size:.82rem; margin:-10px 0 16px;">
            ⚠ Mã NV phải là Mã NguoiDung (MaND) đã tồn tại trong bảng NguoiDung
        </p>
        <form action="manage-nhanvien" method="post">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
            <div class="form-group">
                <label>Mã Nhân Viên</label>
                <input type="text" name="maNV"
                       value="<%= isEdit ? editingNV.getStrMaNV() : "" %>"
                       <%= isEdit ? "readonly" : "required" %>
                       placeholder="VD: ND001">
            </div>
            <div class="form-group">
                <label>Vị trí</label>
                <select name="viTri" required>
                    <option value="">-- Chọn vị trí --</option>
                    <option value="Quan ly" <%= (isEdit && "Quan ly".equals(editingNV.getStrViTriNhanVien())) ? "selected" : "" %>>🏢 Quản lý</option>
                    <option value="Bao ve"  <%= (isEdit && "Bao ve".equals(editingNV.getStrViTriNhanVien()))  ? "selected" : "" %>>🛡 Bảo vệ</option>
                </select>
            </div>
            <div style="display:flex; gap:10px; margin-top:8px;">
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "💾 Cập Nhật" : "➕ Thêm Mới" %>
                </button>
                <% if (isEdit) { %>
                    <a href="manage-nhanvien" class="btn btn-secondary">✕ Hủy</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Mã Nhân Viên</th>
                    <th>Vị Trí</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<NhanVienDTO> list = (List<NhanVienDTO>) request.getAttribute("listNV");
                if (list != null && !list.isEmpty()) {
                    int stt = 1;
                    for (NhanVienDTO nv : list) {
            %>
                <tr>
                    <td style="color:var(--text-muted)"><%= stt++ %></td>
                    <td><code><%= nv.getStrMaNV() %></code></td>
                    <td>
                        <% String viTri = nv.getStrViTriNhanVien(); %>
                        <span class="badge" style="background:<%="Quan ly".equals(viTri) ? "rgba(245,158,11,.15)" : "rgba(99,102,241,.15)"%>;
                              color:<%="Quan ly".equals(viTri) ? "#fcd34d" : "var(--primary-light)"%>;
                              border:1px solid <%="Quan ly".equals(viTri) ? "rgba(245,158,11,.3)" : "rgba(99,102,241,.3)"%>;">
                            <%= "Quan ly".equals(viTri) ? "🏢 Quản lý" : "🛡 Bảo vệ" %>
                        </span>
                    </td>
                    <td>
                        <a href="manage-nhanvien?action=edit&id=<%= nv.getStrMaNV() %>" class="btn btn-edit">✏️ Sửa</a>
                        <a href="manage-nhanvien?action=delete&id=<%= nv.getStrMaNV() %>" class="btn btn-delete"
                           onclick="return confirm('Xóa nhân viên <%= nv.getStrMaNV() %>?');">🗑 Xóa</a>
                    </td>
                </tr>
            <%  }
                } else { %>
                <tr>
                    <td colspan="4" style="text-align:center; color:var(--text-muted); padding:40px;">
                        👷 Chưa có dữ liệu nhân viên
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
