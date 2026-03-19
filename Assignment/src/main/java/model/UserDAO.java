package model;


import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext{

    public User login(String email, String password) {
        String sql = "SELECT * FROM NguoiDung WHERE Email = ? AND MatKhau = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO NguoiDung (MaND, Email, MatKhau, HoTen, GioiTinh, NgSinh, DiaChi, QueQuan, SDT, VaiTro) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getFullName());
            pstmt.setString(5, user.getGender());
            
            if (user.getBirthDate() != null) {
                pstmt.setDate(6, new java.sql.Date(user.getBirthDate().getTime()));
            } else {
                pstmt.setNull(6, Types.DATE);
            }
            pstmt.setString(7, user.getAddress());
            pstmt.setString(8, user.getHometown());
            pstmt.setString(9, user.getPhone());
            pstmt.setString(10, user.getRole() != null ? user.getRole() : "Khach hang");

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String id, String newPassword) {
        String sql = "UPDATE NguoiDung SET MatKhau = ? WHERE MaND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newPassword);
            pstmt.setString(2, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProfile(User user) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, GioiTinh = ?, NgSinh = ?, DiaChi = ?, QueQuan = ?, SDT = ? WHERE MaND = ?";
        try (Connection conn =  DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getGender());
            if (user.getBirthDate() != null) {
                pstmt.setDate(3, new java.sql.Date(user.getBirthDate().getTime()));
            } else {
                pstmt.setNull(3, Types.DATE);
            }
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getHometown());
            pstmt.setString(6, user.getPhone());
            pstmt.setString(7, user.getId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(String id) {
        String sql = "SELECT * FROM NguoiDung WHERE MaND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAllCustomers() {
        List<User> list = new ArrayList<>();
        // Lấy những người có vai trò Khách hàng
        String sql = "SELECT * FROM NguoiDung WHERE VaiTro = 'Khach hang'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getString("MaND"));
        user.setEmail(rs.getString("Email"));
        user.setPassword(rs.getString("MatKhau"));
        user.setFullName(rs.getString("HoTen"));
        user.setGender(rs.getString("GioiTinh"));
        user.setBirthDate(rs.getDate("NgSinh"));
        user.setAddress(rs.getString("DiaChi"));
        user.setHometown(rs.getString("QueQuan"));
        user.setPhone(rs.getString("SDT"));
        user.setRole(rs.getString("VaiTro"));
        return user;
    }
}
