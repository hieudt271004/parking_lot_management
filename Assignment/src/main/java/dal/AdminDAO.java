
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Xe;

public class AdminDAO extends DBContext{

    public void addXe(String maXe, String bienSo, String loaiXe) {
        String sql = "INSERT INTO Xe VALUES(?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe);
            st.setString(2, bienSo);
            st.setString(3, loaiXe);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Xe> getAllXe() {
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
        }
        return list;
    }

    public Xe getXeById(String id) {
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
        }
        return null;
    }

    public void updateXe(String maXe, String bienSo, String loaiXe) {
        String sql = "UPDATE Xe SET bienSo=?, loaiXe=? WHERE maXe=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, bienSo);
            st.setString(2, loaiXe);
            st.setString(3, maXe);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteXe(String maXe) {
        String sql = "DELETE FROM Xe WHERE maXe=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, maXe);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
