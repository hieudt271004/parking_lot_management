<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    // Simple authorization check
    if (currentUser == null || (!"Nhan vien".equals(currentUser.getRole()) && !"Quan ly".equals(currentUser.getRole()))) {
        response.sendRedirect("UserController?action=profile");
        return;
    }
    List<User> customers = (List<User>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh Sách Khách Hàng</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;}
        .container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 1000px; margin: auto; }
        h2 { text-align: center; color: #333; margin-bottom: 20px;}
        table { width: 100%; border-collapse: collapse; margin-top: 10px;}
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #e9ecef; }
        .back-btn { display: inline-block; margin-bottom: 20px; padding: 10px 15px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; }
        .back-btn:hover { background-color: #5a6268; }
    </style>
</head>
<body>
    <div class="container">
        <a href="UserController?action=profile" class="back-btn">&larr; Quay lại Hồ sơ</a>
        <h2>Quản Lý Khách Hàng</h2>
        
        <table>
            <thead>
                <tr>
                    <th>Mã KH</th>
                    <th>Họ Tên</th>
                    <th>Email</th>
                    <th>SĐT</th>
                    <th>Giới tính</th>
                    <th>Ngày sinh</th>
                    <th>Địa chỉ</th>
                </tr>
            </thead>
            <tbody>
                <% if (customers != null && !customers.isEmpty()) { 
                    for (User c : customers) {
                %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getFullName() != null ? c.getFullName() : "" %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getPhone() != null ? c.getPhone() : "" %></td>
                    <td><%= c.getGender() != null ? c.getGender() : "" %></td>
                    <td><%= c.getBirthDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(c.getBirthDate()) : "" %></td>
                    <td><%= c.getAddress() != null ? c.getAddress() : "" %></td>
                </tr>
                <%  } 
                   } else { %>
                <tr>
                    <td colspan="7" style="text-align: center;">Chưa có khách hàng nào.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
