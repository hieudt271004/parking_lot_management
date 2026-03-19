package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO extends DBContexts {

    /**
     * Authenticate a user by Email and MatKhau.
     * Only allows users with VaiTro = 'Nhan vien' to log in as admin.
     * @return HoTen of the user if authenticated, null otherwise
     */
    public String authenticate(String email, String matKhau) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT HoTen FROM NguoiDung WHERE Email = ? AND MatKhau = ? AND VaiTro = 'Nhan vien'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email.trim());
            st.setString(2, matKhau.trim());
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("HoTen");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi đăng nhập: " + e.getMessage(), e);
        }
        return null;
    }
}
