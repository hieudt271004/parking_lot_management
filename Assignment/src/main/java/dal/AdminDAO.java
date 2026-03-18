
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Xe;

public class AdminDAO extends DBContext {

    public void addXe(String maXe, String bienSo, String loaiXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        // Actual column names in DB: MaXe, BienSoXe, TenLoaiXe
        String sql = "INSERT INTO Xe(MaXe, BienSoXe, TenLoaiXe) VALUES(?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe.trim());
            st.setString(2, bienSo.trim());
            st.setString(3, loaiXe.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi thêm xe (Mã xe trùng hoặc Loại xe không hợp lệ - chỉ chấp nhận 'Xe dap' hoặc 'Xe may'): " + e.getMessage(), e);
        }
    }

    public List<Xe> getAllXe() {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        List<Xe> list = new ArrayList<>();
        String sql = "SELECT MaXe, BienSoXe, TenLoaiXe FROM Xe";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Xe(
                        rs.getString("MaXe"),
                        rs.getString("BienSoXe"),
                        rs.getString("TenLoaiXe")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting all vehicles: " + e.getMessage(), e);
        }
        return list;
    }

    public Xe getXeById(String id) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT MaXe, BienSoXe, TenLoaiXe FROM Xe WHERE MaXe = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id.trim());
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Xe(
                        rs.getString("MaXe"),
                        rs.getString("BienSoXe"),
                        rs.getString("TenLoaiXe")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting vehicle by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public void updateXe(String maXe, String bienSo, String loaiXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE Xe SET BienSoXe=?, TenLoaiXe=? WHERE MaXe=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, bienSo.trim());
            st.setString(2, loaiXe.trim());
            st.setString(3, maXe.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("Không tìm thấy MaXe '" + maXe + "' trong database!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating vehicle: " + e.getMessage(), e);
        }
    }

    public void deleteXe(String maXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "DELETE FROM Xe WHERE MaXe=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting vehicle: " + e.getMessage(), e);
        }
    }
}
