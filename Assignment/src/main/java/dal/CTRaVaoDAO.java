package dal;

import dto.CTRaVaoDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CTRaVaoDAO extends DBContext {

    // Actual table name in DB: ChiTietRaVao (not CTRaVao)
    // Columns: MaCTRaVao, ThoiGianVao, ThoiGianRa, MaKH, MaXe, MaTheKVL

    public List<CTRaVaoDTO> getAllCTRaVao() {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        List<CTRaVaoDTO> list = new ArrayList<>();
        String sql = "SELECT MaCTRaVao, ThoiGianVao, ThoiGianRa, MaKH, MaXe, MaTheKVL FROM ChiTietRaVao";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CTRaVaoDTO(
                        rs.getString("MaCTRaVao"),
                        rs.getTimestamp("ThoiGianVao"),
                        rs.getTimestamp("ThoiGianRa"),
                        "",
                        rs.getString("MaKH"),
                        rs.getString("MaXe"),
                        rs.getString("MaTheKVL")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting all ChiTietRaVao: " + e.getMessage(), e);
        }
        return list;
    }

    public CTRaVaoDTO getCTRaVaoById(String maCTRaVao) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT MaCTRaVao, ThoiGianVao, ThoiGianRa, MaKH, MaXe, MaTheKVL FROM ChiTietRaVao WHERE MaCTRaVao = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maCTRaVao.trim());
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new CTRaVaoDTO(
                        rs.getString("MaCTRaVao"),
                        rs.getTimestamp("ThoiGianVao"),
                        rs.getTimestamp("ThoiGianRa"),
                        "",
                        rs.getString("MaKH"),
                        rs.getString("MaXe"),
                        rs.getString("MaTheKVL")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting ChiTietRaVao by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public void addCTRaVao(String maCTRaVao, Date thoiGianVao, Date thoiGianRa, String maKH, String maXe, String maTheKVL) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "INSERT INTO ChiTietRaVao(MaCTRaVao, ThoiGianVao, ThoiGianRa, MaKH, MaXe, MaTheKVL) VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maCTRaVao.trim());
            st.setTimestamp(2, thoiGianVao != null ? new Timestamp(thoiGianVao.getTime()) : null);
            st.setTimestamp(3, thoiGianRa  != null ? new Timestamp(thoiGianRa.getTime())  : null);
            st.setString(4, (maKH     != null && !maKH.trim().isEmpty())     ? maKH.trim()     : null);
            st.setString(5, (maXe     != null && !maXe.trim().isEmpty())     ? maXe.trim()     : null);
            st.setString(6, (maTheKVL != null && !maTheKVL.trim().isEmpty()) ? maTheKVL.trim() : null);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding ChiTietRaVao: " + e.getMessage(), e);
        }
    }

    public void updateCTRaVao(String maCTRaVao, Date thoiGianVao, Date thoiGianRa, String maKH, String maXe, String maTheKVL) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE ChiTietRaVao SET ThoiGianVao=?, ThoiGianRa=?, MaKH=?, MaXe=?, MaTheKVL=? WHERE MaCTRaVao=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setTimestamp(1, thoiGianVao != null ? new Timestamp(thoiGianVao.getTime()) : null);
            st.setTimestamp(2, thoiGianRa  != null ? new Timestamp(thoiGianRa.getTime())  : null);
            st.setString(3, (maKH     != null && !maKH.trim().isEmpty())     ? maKH.trim()     : null);
            st.setString(4, (maXe     != null && !maXe.trim().isEmpty())     ? maXe.trim()     : null);
            st.setString(5, (maTheKVL != null && !maTheKVL.trim().isEmpty()) ? maTheKVL.trim() : null);
            st.setString(6, maCTRaVao.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("Không tìm thấy MaCTRaVao '" + maCTRaVao + "' trong database!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating ChiTietRaVao: " + e.getMessage(), e);
        }
    }

    public void deleteCTRaVao(String maCTRaVao) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "DELETE FROM ChiTietRaVao WHERE MaCTRaVao=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maCTRaVao.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting ChiTietRaVao: " + e.getMessage(), e);
        }
    }
}
