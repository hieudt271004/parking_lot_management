package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import dto.NguoiDungDTO;

public class NguoiDungDAO extends DBContext{

    public NguoiDungDTO kiemTraDangNhap(String email, String matKhau) {
        String sql = "SELECT MaND, Email, MatKhau, HoTen, GioiTinh, NgSinh, DiaChi, QueQuan, SDT, VaiTro " +
                     "FROM NguoiDung WHERE Email = ? AND MatKhau = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, matKhau);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                NguoiDungDTO user = new NguoiDungDTO();
                user.setStrMaND(rs.getString("MaND"));
                user.setStrEmail(rs.getString("Email"));
                user.setStrMatKhau(rs.getString("MatKhau"));
                user.setStrHoTen(rs.getString("HoTen"));
                user.setStrGioiTinh(rs.getString("GioiTinh"));
                user.setStrDiaChi(rs.getString("DiaChi"));
                user.setStrQueQuan(rs.getString("QueQuan"));
                user.setStrSDT(rs.getString("SDT"));
                user.setStrVaiTro(rs.getString("VaiTro"));
                
                java.sql.Timestamp dateNgSinh = rs.getTimestamp("NgSinh");
                if (dateNgSinh != null) {
                   user.setDateNgSinh(new Date(dateNgSinh.getTime()));
                }
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean themNguoiDung(NguoiDungDTO user) {
        String sql = "INSERT INTO NguoiDung (MaND, Email, MatKhau, HoTen, GioiTinh, NgSinh, DiaChi, QueQuan, SDT, VaiTro) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getStrMaND());
            pstmt.setString(2, user.getStrEmail());
            pstmt.setString(3, user.getStrMatKhau());
            pstmt.setString(4, user.getStrHoTen());
            pstmt.setString(5, user.getStrGioiTinh());
            
            if (user.getDateNgSinh() != null) {
                pstmt.setTimestamp(6, new java.sql.Timestamp(user.getDateNgSinh().getTime()));
            } else {
                pstmt.setNull(6, java.sql.Types.TIMESTAMP);
            }
            
            pstmt.setString(7, user.getStrDiaChi());
            pstmt.setString(8, user.getStrQueQuan());
            pstmt.setString(9, user.getStrSDT());
            pstmt.setString(10, user.getStrVaiTro());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean capNhatMatKhau(String maND, String matKhauMoi) {
        String sql = "UPDATE NguoiDung SET MatKhau = ? WHERE MaND = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, matKhauMoi);
            pstmt.setString(2, maND);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean capNhatThongTin(NguoiDungDTO user) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, GioiTinh = ?, NgSinh = ?, DiaChi = ?, QueQuan = ?, SDT = ? " +
                     "WHERE MaND = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getStrHoTen());
            pstmt.setString(2, user.getStrGioiTinh());
            
            if (user.getDateNgSinh() != null) {
                pstmt.setTimestamp(3, new java.sql.Timestamp(user.getDateNgSinh().getTime()));
            } else {
                pstmt.setNull(3, java.sql.Types.TIMESTAMP);
            }
            
            pstmt.setString(4, user.getStrDiaChi());
            pstmt.setString(5, user.getStrQueQuan());
            pstmt.setString(6, user.getStrSDT());
            pstmt.setString(7, user.getStrMaND());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public NguoiDungDTO layThongTinTheoMa(String maND) {
         String sql = "SELECT MaND, Email, MatKhau, HoTen, GioiTinh, NgSinh, DiaChi, QueQuan, SDT, VaiTro " +
                     "FROM NguoiDung WHERE MaND = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, maND);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                NguoiDungDTO user = new NguoiDungDTO();
                user.setStrMaND(rs.getString("MaND"));
                user.setStrEmail(rs.getString("Email"));
                user.setStrMatKhau(rs.getString("MatKhau"));
                user.setStrHoTen(rs.getString("HoTen"));
                user.setStrGioiTinh(rs.getString("GioiTinh"));
                user.setStrDiaChi(rs.getString("DiaChi"));
                user.setStrQueQuan(rs.getString("QueQuan"));
                user.setStrSDT(rs.getString("SDT"));
                user.setStrVaiTro(rs.getString("VaiTro"));
                
                java.sql.Timestamp dateNgSinh = rs.getTimestamp("NgSinh");
                if (dateNgSinh != null) {
                   user.setDateNgSinh(new Date(dateNgSinh.getTime()));
                }
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
