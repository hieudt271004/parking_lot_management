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
        // NhanVien table: MaNV (FK -> NguoiDung), ViTriNhanVien
        String sql = "SELECT MaNV, ViTriNhanVien FROM NhanVien";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new NhanVienDTO(
                        rs.getString("MaNV"),
                        rs.getString("ViTriNhanVien")
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
        String sql = "SELECT MaNV, ViTriNhanVien FROM NhanVien WHERE MaNV = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maNV.trim());
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new NhanVienDTO(
                        rs.getString("MaNV"),
                        rs.getString("ViTriNhanVien")
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
        // NOTE: NhanVien.MaNV is a FK to NguoiDung.MaND - the NguoiDung record must exist first!
        String sql = "INSERT INTO NhanVien(MaNV, ViTriNhanVien) VALUES(?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maNV.trim());
            st.setString(2, viTri.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi thêm nhân viên (Mã NV phải tồn tại trong NguoiDung, và Vị trí chỉ được là 'Quan ly' hoặc 'Bao ve'): " + e.getMessage(), e);
        }
    }

    public void updateNhanVien(String maNV, String viTri) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE NhanVien SET ViTriNhanVien=? WHERE MaNV=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, viTri.trim());
            st.setString(2, maNV.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("Không tìm thấy MaNV '" + maNV + "' trong database!");
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
        String sql = "DELETE FROM NhanVien WHERE MaNV=?";
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
