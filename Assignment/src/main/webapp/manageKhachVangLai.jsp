<%@page import="java.util.List"%>
<%@page import="dto.KhachVangLaiDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Khách Vãng Lai</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="page-body">
    <div class="container">
        <div class="header-links">
            <span>Welcome, <%= session.getAttribute("adminInfo") %></span> |
            <a href="manage-xe">Quản lý xe</a> |
            <a href="manage-nhanvien">Nhân viên</a> |
            <a href="manage-ctravao">Chi tiết ra vào</a> |
            <a href="report.jsp">Báo cáo</a> |
            <a href="logout">Đăng xuất</a>
        </div>

        <h1>Quản Lý Khách Vãng Lai</h1>

        <%
            KhachVangLaiDTO editingKVL = (KhachVangLaiDTO) request.getAttribute("kvl");
            boolean isEdit = editingKVL != null;
        %>

        <div class="form-container">
            <h3><%= isEdit ? "Cập nhật Khách Vãng Lai" : "Thêm Khách Vãng Lai Mới" %></h3>
            <form action="manage-khachvanglai" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
                <div class="form-group">
                    <label>Mã Thẻ KVL:</label>
                    <input type="text" name="maTheKVL" value="<%= isEdit ? editingKVL.getStrMaTheKVL() : "" %>" <%= isEdit ? "readonly" : "required" %>>
                </div>
                <div class="form-group">
                    <label>Mã Xe:</label>
                    <input type="text" name="maXe" value="<%= isEdit ? editingKVL.getStrMaXe() : "" %>" required>
                </div>
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "Cập Nhật" : "Thêm Mới" %>
                </button>
                <% if(isEdit) { %>
                    <a href="manage-khachvanglai" class="btn" style="text-decoration: none; display:inline-block; margin-left:10px; background:#6c757d; color:white;">Hủy</a>
                <% } %>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã Thẻ KVL</th>
                    <th>Mã Xe</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<KhachVangLaiDTO> list = (List<KhachVangLaiDTO>) request.getAttribute("listKVL");
                    if(list != null && !list.isEmpty()) {
                        for(KhachVangLaiDTO kvl : list) {
                %>
                <tr>
                    <td><%= kvl.getStrMaTheKVL() %></td>
                    <td><%= kvl.getStrMaXe() %></td>
                    <td>
                        <a href="manage-khachvanglai?action=edit&id=<%= kvl.getStrMaTheKVL() %>" class="btn btn-edit">Sửa</a>
                        <a href="manage-khachvanglai?action=delete&id=<%= kvl.getStrMaTheKVL() %>" class="btn btn-delete" onclick="return confirm('Xóa thẻ KVL này?');">Xóa</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="3" style="text-align:center;">Không có dữ liệu khách vãng lai</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
