package dao;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO extends DAO {
    public UserDAO() {
        super();
    }

    public User checkLogin(String username, String password) {
        if (con == null) return null;
        String[] tableVariants = {"User", "tbl_user"};

        for (String tbl : tableVariants) {
            String sql = "SELECT * FROM `" + tbl + "` WHERE (email = ? OR sdt = ?) AND password = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, username);
                ps.setString(3, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        User u = new User();
                        u.setId(rs.getString("id"));
                        u.setName(rs.getString("name"));
                        u.setSdt(rs.getString("sdt"));
                        u.setEmail(rs.getString("email"));
                        u.setPassword(rs.getString("password"));
                        u.setRole(rs.getString("role"));
                        u.setNgaytao(rs.getDate("ngaytao"));
                        return u;
                    }
                }
            } catch (Exception ignored) {
            }
        }
        return null;
    }
}
