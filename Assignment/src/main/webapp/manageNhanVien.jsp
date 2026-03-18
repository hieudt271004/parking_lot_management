<%@page import="java.util.List"%>
<%@page import="dto.NhanVienDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Nhân Viên</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="page-body">
    <div class="container">
        <div class="header-links">
            <span>Welcome, <%= session.getAttribute("adminInfo") %></span> |
            <a href="manage-xe">Quản lý xe</a> |
            <a href="report.jsp">Báo cáo</a> |
            <a href="admin-login">Đăng xuất</a>
        </div>
        
        <h1>Quản Lý Thông Tin Nhân Viên</h1>
        
        <%
            NhanVienDTO editingNV = (NhanVienDTO) request.getAttribute("nv");
            boolean isEdit = editingNV != null;
        %>
        
        <div class="form-container">
            <h3><%= isEdit ? "Cập nhật Nhân Viên" : "Thêm Nhân Viên Mới" %></h3>
            <form action="manage-nhanvien" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
                <div class="form-group">
                    <label>Mã Nhân Viên:</label>
                    <input type="text" name="maNV" value="<%= isEdit ? editingNV.getStrMaNV() : "" %>" <%= isEdit ? "readonly" : "required" %>>
                </div>
                <div class="form-group">
                    <label>Vị Trí Nhân Viên:</label>
                    <input type="text" name="viTri" value="<%= isEdit ? editingNV.getStrViTriNhanVien() : "" %>" required>
                </div>
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "Cập Nhật" : "Thêm Mới" %>
                </button>
                <% if(isEdit) { %>
                    <a href="manage-nhanvien" class="btn btn-add" style="text-decoration: none; display:inline-block; margin-left:10px; background:#6c757d;">Hủy</a>
                <% } %>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã Nhân Viên</th>
                    <th>Vị Trí Nhân Viên</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<NhanVienDTO> list = (List<NhanVienDTO>) request.getAttribute("listNV");
                    if(list != null && !list.isEmpty()) {
                        for(NhanVienDTO nv : list) {
                %>
                <tr>
                    <td><%= nv.getStrMaNV() %></td>
                    <td><%= nv.getStrViTriNhanVien() %></td>
                    <td>
                        <a href="manage-nhanvien?action=edit&id=<%= nv.getStrMaNV() %>" class="btn btn-edit">Sửa</a>
                        <a href="manage-nhanvien?action=delete&id=<%= nv.getStrMaNV() %>" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa nhân viên này?');">Xóa</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="3" style="text-align:center;">Không có dữ liệu nhân viên</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
