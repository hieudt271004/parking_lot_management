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

    /**
     * Thêm mới khách hàng vào bảng KhachHang với SoDu = 0, MaXe = NULL.
     * Dùng khi người dùng đăng ký nhưng chưa có record trong KhachHang.
     *
     * @param maKH mã khách hàng (= MaND trong bảng NguoiDung)
     * @return true nếu INSERT thành công
     */
    public boolean themMoiKhachHang(String maKH) {
        String sql = "INSERT INTO KhachHang (MaKH, MaXe, SoDu) VALUES (?, NULL, 0)";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, maKH);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Nạp tiền (hoặc trừ tiền khi soTien âm) cho khách hàng.
     * Nếu khách hàng chưa tồn tại trong bảng KhachHang, tự động tạo mới
     * với SoDu ban đầu = soTien (chỉ áp dụng khi soTien > 0).
     *
     * @param maKH   mã khách hàng
     * @param soTien số tiền cần cộng (dương) hoặc trừ (âm)
     * @return true nếu thao tác thành công
     */
    public boolean napTien(String maKH, long soTien) {
        // Kiểm tra đã có trong KhachHang chưa
        KhachHangDTO existing = layKhachHangTheoMa(maKH);
        if (existing == null) {
            if (soTien <= 0) {
                // Không tạo mới khi trừ tiền mà chưa có tài khoản
                return false;
            }
            // Tạo mới với SoDu = soTien
            String insertSql = "INSERT INTO KhachHang (MaKH, MaXe, SoDu) VALUES (?, NULL, ?)";
            try (Connection conn = DBContext.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setString(1, maKH);
                pstmt.setLong(2, soTien);
                return pstmt.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return false;
        }

        // Đã tồn tại → UPDATE cộng / trừ SoDu
        String updateSql = "UPDATE KhachHang SET SoDu = SoDu + ? WHERE MaKH = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
            pstmt.setLong(1, soTien);
            pstmt.setString(2, maKH);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
