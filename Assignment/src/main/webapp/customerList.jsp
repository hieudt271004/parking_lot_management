<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || (!"Nhan vien".equals(currentUser.getRole()) && !"Quan ly".equals(currentUser.getRole()))) {
        response.sendRedirect("UserController?action=profile");
        return;
    }
    List<User> customers = (List<User>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Khách Hàng – FPT Parking</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { background: var(--bg-page); }
        .page-body { padding: 36px 40px; min-height: 100vh; }
    </style>
</head>
<body class="page-body">
    <div style="max-width: 1100px; margin: 0 auto;">
        <a href="UserController?action=profile" style="display:inline-flex; align-items:center; gap:6px;
            padding:8px 16px; border-radius:99px; background:rgba(99,102,241,.1); color:var(--primary-light);
            font-size:.85rem; font-weight:600; margin-bottom:20px; text-decoration:none;
            border:1px solid rgba(99,102,241,.2);">← Hồ sơ</a>

        <h1 style="font-size:1.7rem; font-weight:800; margin:0 0 24px;">👥 Danh Sách Khách Hàng</h1>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
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
                       int stt = 1;
                       for (User c : customers) { %>
                    <tr>
                        <td style="color:var(--text-muted)"><%= stt++ %></td>
                        <td><code><%= c.getId() %></code></td>
                        <td><strong><%= c.getFullName() != null ? c.getFullName() : "" %></strong></td>
                        <td><%= c.getEmail() %></td>
                        <td><%= c.getPhone() != null ? c.getPhone() : "—" %></td>
                        <td><%= c.getGender() != null ? c.getGender() : "—" %></td>
                        <td><%= c.getBirthDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(c.getBirthDate()) : "—" %></td>
                        <td><%= c.getAddress() != null ? c.getAddress() : "—" %></td>
                    </tr>
                <%  }
                   } else { %>
                    <tr>
                        <td colspan="8" style="text-align:center; color:var(--text-muted); padding:40px;">
                            👥 Chưa có khách hàng nào
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
