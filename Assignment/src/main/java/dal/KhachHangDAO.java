package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.KhachHangDTO;

public class KhachHangDAO extends DBContext {

    public List<KhachHangDTO> layDanhSachKhachHang() {
        List<KhachHangDTO> danhSach = new ArrayList<>();
        String sql = "SELECT MaKH, MaXe, SoDu FROM KhachHang";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                KhachHangDTO kh = new KhachHangDTO();
                kh.setStrMaKH(resultSet.getString("MaKH"));
                kh.setStrMaXe(resultSet.getString("MaXe"));
                kh.setLongSoDu(resultSet.getLong("SoDu"));
                danhSach.add(kh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return danhSach;
    }

    public boolean xoaKhachHang(String maKH) {
        String sql = "DELETE FROM KhachHang WHERE MaKH = ?";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setString(1, maKH);
            int result = preparedStatement.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public KhachHangDTO layKhachHangTheoMa(String maKH) {
        String sql = "SELECT MaKH, MaXe, SoDu FROM KhachHang WHERE MaKH = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setString(1, maKH);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                KhachHangDTO kh = new KhachHangDTO();
                kh.setStrMaKH(resultSet.getString("MaKH"));
                kh.setStrMaXe(resultSet.getString("MaXe"));
                kh.setLongSoDu(resultSet.getLong("SoDu"));
                return kh;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean napTien(String maKH, long soTien) {
        String sql = "UPDATE KhachHang SET SoDu = SoDu + ? WHERE MaKH = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, soTien);
            pstmt.setString(2, maKH);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
