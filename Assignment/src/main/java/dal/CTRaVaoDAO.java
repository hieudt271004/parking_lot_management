package dal;

import dto.CTRaVaoDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CTRaVaoDAO extends DBContext {

    public List<CTRaVaoDTO> getAllCTRaVao() {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        List<CTRaVaoDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM CTRaVao";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CTRaVaoDTO(
                        rs.getString(1),
                        rs.getTimestamp(2),
                        rs.getTimestamp(3),
                        "", // strMaNV is ignored in DTO model but required in constructor
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting all CTRaVao: " + e.getMessage(), e);
        }
        return list;
    }

    public CTRaVaoDTO getCTRaVaoById(String maCTRaVao) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT * FROM CTRaVao WHERE maCTRaVao = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maCTRaVao);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new CTRaVaoDTO(
                        rs.getString(1),
                        rs.getTimestamp(2),
                        rs.getTimestamp(3),
                        "",
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting CTRaVao by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public void addCTRaVao(String maCTRaVao, Date thoiGianVao, Date thoiGianRa, String maKH, String maXe, String maTheKVL) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "INSERT INTO CTRaVao(maCTRaVao, thoiGianVao, thoiGianRa, maKH, maXe, maTheKVL) VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maCTRaVao.trim());
            st.setTimestamp(2, thoiGianVao != null ? new Timestamp(thoiGianVao.getTime()) : null);
            st.setTimestamp(3, thoiGianRa != null ? new Timestamp(thoiGianRa.getTime()) : null);
            st.setString(4, maKH.trim());
            st.setString(5, maXe.trim());
            st.setString(6, maTheKVL.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding CTRaVao: " + e.getMessage(), e);
        }
    }

    public void updateCTRaVao(String maCTRaVao, Date thoiGianVao, Date thoiGianRa, String maKH, String maXe, String maTheKVL) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE CTRaVao SET thoiGianVao=?, thoiGianRa=?, maKH=?, maXe=?, maTheKVL=? WHERE maCTRaVao=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setTimestamp(1, thoiGianVao != null ? new Timestamp(thoiGianVao.getTime()) : null);
            st.setTimestamp(2, thoiGianRa != null ? new Timestamp(thoiGianRa.getTime()) : null);
            st.setString(3, maKH.trim());
            st.setString(4, maXe.trim());
            st.setString(5, maTheKVL.trim());
            st.setString(6, maCTRaVao.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("No rows updated in DB! Verify if maCTRaVao '" + maCTRaVao + "' exists.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating CTRaVao: " + e.getMessage(), e);
        }
    }

    public void deleteCTRaVao(String maCTRaVao) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "DELETE FROM CTRaVao WHERE maCTRaVao=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maCTRaVao.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting CTRaVao: " + e.getMessage(), e);
        }
    }
}
