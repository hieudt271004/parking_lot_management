package dal;

import dto.NhanVienDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NhanVienDAO extends DBContext {

    public List<NhanVienDTO> getAllNhanVien() {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        List<NhanVienDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM NhanVien";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new NhanVienDTO(
                        rs.getString(1),
                        rs.getString(2)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting all NhanVien: " + e.getMessage(), e);
        }
        return list;
    }

    public NhanVienDTO getNhanVienById(String maNV) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT * FROM NhanVien WHERE maNV = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maNV);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new NhanVienDTO(
                        rs.getString(1),
                        rs.getString(2)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting NhanVien by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public void addNhanVien(String maNV, String viTri) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "INSERT INTO NhanVien(maNV, viTriNhanVien) VALUES(?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maNV.trim());
            st.setString(2, viTri.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding NhanVien: " + e.getMessage(), e);
        }
    }

    public void updateNhanVien(String maNV, String viTri) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE NhanVien SET viTriNhanVien=? WHERE maNV=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, viTri.trim());
            st.setString(2, maNV.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("No rows updated in DB! Verify if maNV '" + maNV + "' exists.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating NhanVien: " + e.getMessage(), e);
        }
    }

    public void deleteNhanVien(String maNV) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "DELETE FROM NhanVien WHERE maNV=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maNV.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting NhanVien: " + e.getMessage(), e);
        }
    }
}
