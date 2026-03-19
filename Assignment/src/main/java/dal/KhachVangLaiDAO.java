package dal;

import dto.KhachVangLaiDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class KhachVangLaiDAO extends DBContexts {

    public List<KhachVangLaiDTO> getAllKhachVangLai() {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        List<KhachVangLaiDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM KhachVangLai";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new KhachVangLaiDTO(
                        rs.getString(1),
                        rs.getString(2)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting all KhachVangLai: " + e.getMessage(), e);
        }
        return list;
    }

    public KhachVangLaiDTO getKhachVangLaiById(String maTheKVL) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT * FROM KhachVangLai WHERE maTheKVL = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maTheKVL);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new KhachVangLaiDTO(
                        rs.getString(1),
                        rs.getString(2)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting KhachVangLai by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public void addKhachVangLai(String maTheKVL, String maXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "INSERT INTO KhachVangLai(maTheKVL, maXe) VALUES(?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maTheKVL.trim());
            st.setString(2, maXe.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding KhachVangLai: " + e.getMessage(), e);
        }
    }

    public void updateKhachVangLai(String maTheKVL, String maXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE KhachVangLai SET maXe=? WHERE maTheKVL=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe.trim());
            st.setString(2, maTheKVL.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("No rows updated in DB! Verify if maTheKVL '" + maTheKVL + "' exists.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating KhachVangLai: " + e.getMessage(), e);
        }
    }

    public void deleteKhachVangLai(String maTheKVL) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "DELETE FROM KhachVangLai WHERE maTheKVL=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maTheKVL.trim());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting KhachVangLai: " + e.getMessage(), e);
        }
    }
}
