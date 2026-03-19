package dal;

import dto.VeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class VeDAO extends DBContext {

    /**
     * Thêm mới một vé vào bảng c_Ve.
     */
    public boolean insertVe(VeDTO ve) {
        String sql = "INSERT INTO c_Ve (MaVe, MaLoaiVe, MaKH, NgayKichHoat, NgayHetHan, TrangThai) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ve.getStrMaVe());
            pstmt.setString(2, ve.getStrMaLoaiVe());
            pstmt.setString(3, ve.getStrMaKH());
            pstmt.setTimestamp(4, new Timestamp(ve.getDateNgayKichHoat().getTime()));
            pstmt.setTimestamp(5, new Timestamp(ve.getDateNgayHetHan().getTime()));
            pstmt.setString(6, ve.getStrTrangThai());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy danh sách vé theo mã khách hàng.
     */
    public List<VeDTO> getVeByMaKH(String maKH) {
        List<VeDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM c_Ve WHERE MaKH = ? ORDER BY NgayHetHan DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, maKH);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                VeDTO ve = new VeDTO();
                ve.setStrMaVe(rs.getString("MaVe"));
                ve.setStrMaLoaiVe(rs.getString("MaLoaiVe"));
                ve.setStrMaKH(rs.getString("MaKH"));
                ve.setDateNgayKichHoat(rs.getTimestamp("NgayKichHoat"));
                ve.setDateNgayHetHan(rs.getTimestamp("NgayHetHan"));
                ve.setStrTrangThai(rs.getString("TrangThai"));
                list.add(ve);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cập nhật trạng thái tất cả vé trong bảng c_Ve:
     * - NgayHetHan < GETDATE() → 'Da het han'
     * - NgayHetHan >= GETDATE() → 'Dang su dung'
     * Được gọi bởi VeStatusScheduler mỗi ngày.
     *
     * @return số dòng bị ảnh hưởng
     */
    public int capNhatTrangThaiVe() {
        String sql = "UPDATE c_Ve SET TrangThai = "
                   + "CASE WHEN NgayHetHan < GETDATE() THEN 'Da het han' "
                   + "     ELSE 'Dang su dung' END "
                   + "WHERE TrangThai <> 'Chua kich hoat'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int rows = pstmt.executeUpdate();
            System.out.println("[VeDAO] capNhatTrangThaiVe: updated " + rows + " rows.");
            return rows;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
