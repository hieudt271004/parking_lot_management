package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import model.UserDAO;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "register":
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            case "login":
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            case "profile":
                showProfile(request, response);
                break;
            case "editProfile":
                showEditProfileForm(request, response);
                break;
            case "changePassword":
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                break;
            case "customerList":
                listCustomers(request, response);
                break;
            default:
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Support Vietnamese characters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        switch (action) {
            case "register":
                registerUser(request, response);
                break;
            case "login":
                loginUser(request, response);
                break;
            case "updateProfile":
                updateProfile(request, response);
                break;
            case "updatePassword":
                updatePassword(request, response);
                break;
            default:
                response.sendRedirect("UserController?action=login");
                break;
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("birthDate");
        String address = request.getParameter("address");
        String hometown = request.getParameter("hometown");
        String phone = request.getParameter("phone");

        Date birthDate = null;
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                birthDate = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        User newUser = new User(id, email, password, fullName, gender, birthDate, address, hometown, phone, "Khach hang");

        if (userDAO.register(newUser)) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại. Mã người dùng có thể đã tồn tại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("UserController?action=profile");
        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect("UserController?action=login");
            return;
        }
        
        // Refresh data from DB
        User updatedUser = userDAO.getUserById(currentUser.getId());
        session.setAttribute("currentUser", updatedUser);
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void showEditProfileForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("UserController?action=login");
            return;
        }
        request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("UserController?action=login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("birthDate");
        String address = request.getParameter("address");
        String hometown = request.getParameter("hometown");
        String phone = request.getParameter("phone");

        Date birthDate = null;
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                birthDate = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Create user object for updating
        User userToUpdate = new User();
        userToUpdate.setId(currentUser.getId());
        userToUpdate.setFullName(fullName);
        userToUpdate.setGender(gender);
        userToUpdate.setBirthDate(birthDate);
        userToUpdate.setAddress(address);
        userToUpdate.setHometown(hometown);
        userToUpdate.setPhone(phone);

        if (userDAO.updateProfile(userToUpdate)) {
            // Update session
            User updatedUser = userDAO.getUserById(currentUser.getId());
            session.setAttribute("currentUser", updatedUser);
            
            request.setAttribute("message", "Cập nhật thông tin thành công!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Cập nhật thông tin thất bại!");
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
        }
    }

    private void updatePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("UserController?action=login");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!currentUser.getPassword().equals(oldPassword)) {
            request.setAttribute("error", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        if (userDAO.updatePassword(currentUser.getId(), newPassword)) {
            // Update the object in session too
            currentUser.setPassword(newPassword);
            session.setAttribute("currentUser", currentUser);
            
            request.setAttribute("message", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> customers = userDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("customerList.jsp").forward(request, response);
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().invalidate();
        response.sendRedirect("UserController?action=login");
    }
}
