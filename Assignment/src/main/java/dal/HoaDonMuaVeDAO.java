package dal;

import dto.CTHDMuaVeDTO;
import dto.HDMuaVeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * DAO cho HoaDonMuaVe và ChiTietHoaDonMuaVe
 */
public class HoaDonMuaVeDAO extends DBContext {

    /**
     * Tạo hóa đơn mua vé mới.
     *
     * @param hd đối tượng HoaDonMuaVeDTO chứa thông tin hóa đơn
     * @return true nếu INSERT thành công
     */
    public boolean insertHoaDon(HDMuaVeDTO hd) {
        String sql = "INSERT INTO HoaDonMuaVe (MaHD, MaKH, NgayHD, TongTriGia) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, hd.getStrMaHD());
            pstmt.setString(2, hd.getStrMaKH());
            pstmt.setTimestamp(3, new Timestamp(hd.getDateNgayHD().getTime()));
            pstmt.setLong(4, hd.getLongTongTriGia());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm chi tiết hóa đơn: nếu (MaHD, MaLoaiVe) chưa tồn tại thì INSERT
     * với SoLuongVe = 1, nếu đã có thì UPDATE SoLuongVe + 1.
     *
     * @param ct đối tượng CTHDMuaVeDTO
     * @return true nếu thành công
     */
    public boolean insertOrIncrementChiTiet(CTHDMuaVeDTO ct) {
        // Kiểm tra đã tồn tại chưa
        String checkSql = "SELECT SoLuongVe FROM ChiTietHoaDonMuaVe WHERE MaHD = ? AND MaLoaiVe = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setString(1, ct.getStrMaHD());
            checkStmt.setString(2, ct.getStrMaLoaiVe());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Đã tồn tại → UPDATE +1
                String updateSql = "UPDATE ChiTietHoaDonMuaVe SET SoLuongVe = SoLuongVe + 1 "
                        + "WHERE MaHD = ? AND MaLoaiVe = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, ct.getStrMaHD());
                    updateStmt.setString(2, ct.getStrMaLoaiVe());
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                // Chưa tồn tại → INSERT mới với SoLuongVe = 1
                String insertSql = "INSERT INTO ChiTietHoaDonMuaVe (MaHD, MaLoaiVe, SoLuongVe) VALUES (?, ?, 1)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, ct.getStrMaHD());
                    insertStmt.setString(2, ct.getStrMaLoaiVe());
                    return insertStmt.executeUpdate() > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
