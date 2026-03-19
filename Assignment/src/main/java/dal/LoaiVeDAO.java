package dal;

import dto.LoaiVeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LoaiVeDAO extends DBContext {

    public List<LoaiVeDTO> getAllLoaiVe() {
        List<LoaiVeDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM LoaiVe";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new LoaiVeDTO(
                        rs.getString("MaLoaiVe"),
                        rs.getString("TenLoaiVe"),
                        rs.getLong("GiaVe")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public LoaiVeDTO getLoaiVeById(String maLoaiVe) {
        String sql = "SELECT * FROM LoaiVe WHERE MaLoaiVe = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, maLoaiVe);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new LoaiVeDTO(
                        rs.getString("MaLoaiVe"),
                        rs.getString("TenLoaiVe"),
                        rs.getLong("GiaVe"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
