<%@page import="model.User"%>
<%@page import="dto.KhachHangDTO"%>
<%@page import="dal.KhachHangDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("UserController?action=login");
        return;
    }
    KhachHangDAO khDAO = new KhachHangDAO();
    KhachHangDTO kh = khDAO.layKhachHangTheoMa(currentUser.getId());
    long soDu = (kh != null) ? kh.getLongSoDu() : 0;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FPT Parking – Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .welcome-section { margin-bottom: 28px; }
        .welcome-section h2 {
            font-size: 1.9rem; font-weight: 800; margin: 0 0 4px;
            background: linear-gradient(135deg, var(--primary-light), var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .welcome-section p { color: var(--text-muted); margin: 0; font-size: .9rem; }

        .balance-card {
            background: linear-gradient(135deg, var(--primary-dark), var(--accent-dark));
            border-radius: var(--radius-md);
            padding: 24px 28px;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 8px 32px rgba(79,70,229,.35);
            animation: pulse-glow 3s ease-in-out infinite;
        }
        .balance-card .left { }
        .balance-card .label { font-size: .78rem; text-transform: uppercase;
            letter-spacing: 1.5px; color: rgba(255,255,255,.6); margin-bottom: 6px; }
        .balance-card .amount { font-size: 2.4rem; font-weight: 900; color: white; }
        .balance-card .icon { font-size: 3rem; opacity: .3; }

        .action-cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .action-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 28px 20px;
            text-align: center;
            cursor: pointer;
            transition: all var(--transition);
            position: relative;
            overflow: hidden;
        }
        .action-card::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform var(--transition);
        }
        .action-card:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-md), 0 0 22px rgba(99,102,241,.18);
        }
        .action-card:hover::after { transform: scaleX(1); }
        .action-card .emoji { font-size: 2.8rem; margin-bottom: 12px; display: block; }
        .action-card img { width: 80px; height: 80px; object-fit: contain; margin-bottom: 14px; }
        .action-card .card-title { font-size: 1rem; font-weight: 700; color: var(--text-primary); }
        .action-card .card-desc { font-size: .8rem; color: var(--text-muted); margin-top: 4px; }

        .quick-actions { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 28px; }
        .quick-btn {
            display: flex; align-items: center; gap: 12px;
            padding: 14px 18px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            cursor: pointer;
            transition: all var(--transition);
            text-decoration: none;
        }
        .quick-btn:hover { border-color: var(--primary); background: var(--bg-card2); }
        .quick-btn .qicon { font-size: 1.4rem; }
        .quick-btn .qtxt { font-size: .88rem; font-weight: 600; color: var(--text-primary); }
        .quick-btn .qsub { font-size: .77rem; color: var(--text-muted); }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <h1>FPT Parking</h1>
        <img src="icon/user.png" class="avatar" alt="Avatar">
        <h3><%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty()
                ? currentUser.getFullName() : currentUser.getEmail() %></h3>
        <ul>
            <li style="background:rgba(99,102,241,.25); color:var(--primary-light);" onclick="window.location.href='homepage.jsp'">🏠 Dashboard</li>
            <li onclick="window.location.href='thongtinve.jsp'">🎫 Thông tin vé</li>
            <li onclick="window.location.href='muave.jsp'">🛒 Mua vé</li>
            <li onclick="window.location.href='naptien.jsp'">💰 Nạp tiền</li>
            <li onclick="window.location.href='UserController?action=profile'">👤 Tài khoản</li>
        </ul>
        <div class="bottom">
            <button onclick="window.location.href='UserController?action=logout'">🚪 Đăng xuất</button>
        </div>
    </div>

    <!-- Main content -->
    <div class="main">
        <div class="welcome-section">
            <h2>Xin chào, <%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty()
                ? currentUser.getFullName().split(" ")[currentUser.getFullName().split(" ").length-1]
                : "Bạn" %>! 👋</h2>
            <p>Chào mừng đến với FPT Parking – Hệ thống quản lý bãi xe thông minh</p>
        </div>

        <!-- Balance Card -->
        <div class="balance-card">
            <div class="left">
                <div class="label">💳 Số dư tài khoản</div>
                <div class="amount"><%= String.format("%,d", soDu).replace(',', '.') %>đ</div>
            </div>
            <div class="icon">💰</div>
        </div>

        <!-- Action Cards -->
        <div class="action-cards">
            <div class="action-card" onclick="window.location.href='thongtinve.jsp'">
                <img src="icon/ticket.png" alt="Ticket">
                <div class="card-title">🎫 Thông tin vé</div>
                <div class="card-desc">Xem vé đã mua</div>
            </div>
            <div class="action-card" onclick="window.location.href='muave.jsp'">
                <img src="icon/buy.png" alt="Buy">
                <div class="card-title">🛒 Mua vé</div>
                <div class="card-desc">Mua vé gửi xe</div>
            </div>
            <div class="action-card" onclick="window.location.href='naptien.jsp'">
                <img src="icon/money.png" alt="Money">
                <div class="card-title">💰 Nạp tiền</div>
                <div class="card-desc">Nạp thêm vào ví</div>
            </div>
        </div>

        <!-- Quick actions -->
        <div class="quick-actions">
            <a href="UserController?action=profile" class="quick-btn">
                <span class="qicon">👤</span>
                <div>
                    <div class="qtxt">Tài khoản của tôi</div>
                    <div class="qsub">Xem và cập nhật thông tin</div>
                </div>
            </a>
            <a href="UserController?action=changePassword" class="quick-btn">
                <span class="qicon">🔑</span>
                <div>
                    <div class="qtxt">Đổi mật khẩu</div>
                    <div class="qsub">Cập nhật bảo mật</div>
                </div>
            </a>
        </div>
    </div>
</div>
</body>
</html>