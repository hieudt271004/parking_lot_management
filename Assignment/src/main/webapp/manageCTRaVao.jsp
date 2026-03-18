<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dto.CTRaVaoDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Chi Tiết Ra Vào</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="page-body">
    <div class="container">
        <div class="header-links">
            <span>Welcome, <%= session.getAttribute("adminInfo") %></span> |
            <a href="manage-xe">Quản lý xe</a> |
            <a href="manage-nhanvien">Nhân viên</a> |
            <a href="manage-khachvanglai">Khách vãng lai</a> |
            <a href="report.jsp">Báo cáo</a> |
            <a href="logout">Đăng xuất</a>
        </div>

        <h1>Quản Lý Chi Tiết Ra Vào</h1>

        <%
            CTRaVaoDTO editingCTV = (CTRaVaoDTO) request.getAttribute("ctv");
            boolean isEdit = editingCTV != null;

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            String tVao = (isEdit && editingCTV.getDateThoiGianVao() != null) ? sdf.format(editingCTV.getDateThoiGianVao()) : "";
            String tRa  = (isEdit && editingCTV.getDateThoiGianRa()  != null) ? sdf.format(editingCTV.getDateThoiGianRa())  : "";
        %>

        <div class="form-container">
            <h3><%= isEdit ? "Cập nhật Lượt Ra Vào" : "Thêm Lượt Ra Vào Mới" %></h3>
            <form action="manage-ctravao" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
                <div class="form-group">
                    <label>Mã CT Ra Vào:</label>
                    <input type="text" name="maCTRaVao" value="<%= isEdit ? editingCTV.getStrMaCTRaVao() : "" %>" <%= isEdit ? "readonly" : "required" %>>
                </div>
                <div class="form-group">
                    <label>Giờ vào:</label>
                    <input type="datetime-local" name="thoiGianVao" value="<%= tVao %>">
                </div>
                <div class="form-group">
                    <label>Giờ ra:</label>
                    <input type="datetime-local" name="thoiGianRa" value="<%= tRa %>">
                </div>
                <div class="form-group">
                    <label>Mã Khách Hàng:</label>
                    <input type="text" name="maKH" value="<%= isEdit && editingCTV.getStrMaKH() != null ? editingCTV.getStrMaKH() : "" %>">
                </div>
                <div class="form-group">
                    <label>Mã Xe:</label>
                    <input type="text" name="maXe" value="<%= isEdit && editingCTV.getStrMaXe() != null ? editingCTV.getStrMaXe() : "" %>" required>
                </div>
                <div class="form-group">
                    <label>Mã Thẻ KVL:</label>
                    <input type="text" name="maTheKVL" value="<%= isEdit && editingCTV.getStrMaTheKVL() != null ? editingCTV.getStrMaTheKVL() : "" %>">
                </div>
                <button type="submit" class="btn <%= isEdit ? "btn-update" : "btn-add" %>">
                    <%= isEdit ? "Cập Nhật" : "Thêm Mới" %>
                </button>
                <% if(isEdit) { %>
                    <a href="manage-ctravao" class="btn" style="text-decoration:none; display:inline-block; margin-left:10px; background:#6c757d; color:white;">Hủy</a>
                <% } %>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã CT Ra Vào</th>
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
                    if(list != null && !list.isEmpty()) {
                        SimpleDateFormat displaySdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                        for(CTRaVaoDTO ctv : list) {
                %>
                <tr>
                    <td><%= ctv.getStrMaCTRaVao() %></td>
                    <td><%= ctv.getDateThoiGianVao() != null ? displaySdf.format(ctv.getDateThoiGianVao()) : "-" %></td>
                    <td><%= ctv.getDateThoiGianRa()  != null ? displaySdf.format(ctv.getDateThoiGianRa())  : "-" %></td>
                    <td><%= ctv.getStrMaKH() != null ? ctv.getStrMaKH() : "" %></td>
                    <td><%= ctv.getStrMaTheKVL() != null ? ctv.getStrMaTheKVL() : "" %></td>
                    <td><%= ctv.getStrMaXe() != null ? ctv.getStrMaXe() : "" %></td>
                    <td>
                        <a href="manage-ctravao?action=edit&id=<%= ctv.getStrMaCTRaVao() %>" class="btn btn-edit">Sửa</a>
                        <a href="manage-ctravao?action=delete&id=<%= ctv.getStrMaCTRaVao() %>" class="btn btn-delete" onclick="return confirm('Xóa lượt này?');">Xóa</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="7" style="text-align:center;">Không có dữ liệu chi tiết ra vào</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
