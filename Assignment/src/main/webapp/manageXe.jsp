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
            <a href="manage-nhanvien">Nhân viên</a> |
            <a href="manage-khachvanglai">Khách vãng lai</a> |
            <a href="manage-ctravao">Chi tiết ra vào</a> |
            <a href="report.jsp">Báo cáo</a> |
            <a href="logout">Đăng xuất</a>
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
                    <label>Biển Số Xe:</label>
                    <input type="text" name="bienSo" value="<%= isEdit ? editingXe.getBienSo() : "" %>" required placeholder="VD: 59A-12345">
                </div>
                <div class="form-group">
                    <label>Loại Xe:</label>
                    <select name="loaiXe" required style="padding:8px; width:calc(100% - 120px); border:1px solid #ccc; border-radius:4px;">
                        <option value="">-- Chọn loại xe --</option>
                        <option value="Xe may" <%= (isEdit && "Xe may".equals(editingXe.getLoaiXe())) ? "selected" : "" %>>Xe may</option>
                        <option value="Xe dap" <%= (isEdit && "Xe dap".equals(editingXe.getLoaiXe())) ? "selected" : "" %>>Xe dap</option>
                    </select>
                </div>
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "Cập Nhật" : "Thêm Mới" %>
                </button>
                <% if(isEdit) { %>
                    <a href="manage-xe" class="btn" style="text-decoration: none; display:inline-block; margin-left:10px; background:#6c757d; color:white;">Hủy</a>
                <% } %>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã Xe</th>
                    <th>Biển Số Xe</th>
                    <th>Loại Xe (Xe may/Xe dap)</th>
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
                        <a href="manage-xe?action=delete&id=<%= x.getMaXe() %>" class="btn btn-delete" onclick="return confirm('Xóa xe <%= x.getMaXe() %>?');">Xóa</a>
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
