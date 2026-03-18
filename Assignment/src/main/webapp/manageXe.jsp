<%@page import="java.util.List"%>
<%@page import="model.Xe"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Xe</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="page-body">
    <div class="container">
        <div class="header-links">
            <span>Welcome, <%= session.getAttribute("adminInfo") %></span> |
            <a href="manage-nhanvien">Quản lý nhân viên</a> |
            <a href="report.jsp">Báo cáo</a> |
            <a href="admin-login">Đăng xuất</a>
        </div>
        
        <h1>Quản Lý Thông Tin Xe</h1>
        
        <%
            Xe editingXe = (Xe) request.getAttribute("xe");
            boolean isEdit = editingXe != null;
        %>
        
        <div class="form-container">
            <h3><%= isEdit ? "Cập nhật Xe" : "Thêm Xe Mới" %></h3>
            <form action="manage-xe" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
                <div class="form-group">
                    <label>Mã Xe:</label>
                    <input type="text" name="maXe" value="<%= isEdit ? editingXe.getMaXe() : "" %>" <%= isEdit ? "readonly" : "required" %>>
                </div>
                <div class="form-group">
                    <label>Biển Số:</label>
                    <input type="text" name="bienSo" value="<%= isEdit ? editingXe.getBienSo() : "" %>" required>
                </div>
                <div class="form-group">
                    <label>Loại Xe:</label>
                    <input type="text" name="loaiXe" value="<%= isEdit ? editingXe.getLoaiXe() : "" %>" required>
                </div>
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "Cập Nhật" : "Thêm Mới" %>
                </button>
                <% if(isEdit) { %>
                    <a href="manage-xe" class="btn btn-add" style="text-decoration: none; display:inline-block; margin-left:10px; background:#6c757d;">Hủy</a>
                <% } %>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã Xe</th>
                    <th>Biển Số</th>
                    <th>Loại Xe</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Xe> list = (List<Xe>) request.getAttribute("listX");
                    if(list != null && !list.isEmpty()) {
                        for(Xe x : list) {
                %>
                <tr>
                    <td><%= x.getMaXe() %></td>
                    <td><%= x.getBienSo() %></td>
                    <td><%= x.getLoaiXe() %></td>
                    <td>
                        <a href="manage-xe?action=edit&id=<%= x.getMaXe() %>" class="btn btn-edit">Sửa</a>
                        <a href="manage-xe?action=delete&id=<%= x.getMaXe() %>" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa xe này?');">Xóa</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="4" style="text-align:center;">Không có dữ liệu xe</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
