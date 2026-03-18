
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Xe;

public class AdminDAO extends DBContext{

    public void addXe(String maXe, String bienSo, String loaiXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null! Have you rebuilt the project and restarted the server after the previous fix?");
        }
        // Use explicit columns to avoid issues if the table has extra columns
        String sql = "INSERT INTO Xe(maXe, bienSo, loaiXe) VALUES(?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe);
            st.setString(2, bienSo);
            st.setString(3, loaiXe);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding vehicle (maybe duplicate maXe?): " + e.getMessage(), e);
        }
    }

    public List<Xe> getAllXe() {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        List<Xe> list = new ArrayList<>();
        String sql = "SELECT * FROM Xe";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Xe(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting all vehicles: " + e.getMessage(), e);
        }
        return list;
    }

    public Xe getXeById(String id) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "SELECT * FROM Xe WHERE maXe = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Xe(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting vehicle by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public void updateXe(String maXe, String bienSo, String loaiXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "UPDATE Xe SET BienSoXe=?, TenLoaiXe=? WHERE MaXe=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, bienSo.trim());
            st.setString(2, loaiXe.trim());
            st.setString(3, maXe.trim());
            int rows = st.executeUpdate();
            if (rows == 0) {
                throw new RuntimeException("No rows updated in DB! Verify if maXe '" + maXe + "' exists.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating vehicle: " + e.getMessage(), e);
        }
    }

    public void deleteXe(String maXe) {
        if (connection == null) {
            throw new RuntimeException("Database connection is null!");
        }
        String sql = "DELETE FROM Xe WHERE maXe=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting vehicle: " + e.getMessage(), e);
        }
    }
}
