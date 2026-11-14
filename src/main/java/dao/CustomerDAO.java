package dao;

import model.Customer;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.UUID;

public class CustomerDAO extends DAO {
    public CustomerDAO() {
        super();
    }

    public boolean checkUserExists(String email, String sdt) {
        if (con == null) return false;
        String[] tableVariants = {"tbl_user", "User"};
        for (String tbl : tableVariants) {
            boolean hasEmail = (email != null && !email.trim().isEmpty());
            String sql = hasEmail 
                    ? "SELECT id FROM `" + tbl + "` WHERE sdt = ? OR email = ?" 
                    : "SELECT id FROM `" + tbl + "` WHERE sdt = ?";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, sdt);
                if (hasEmail) {
                    ps.setString(2, email.trim());
                }
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            } catch (Exception ignored) {
                // Try next table variant
            }
        }
        return false;
    }

    public boolean addNewCustomer(Customer customer) {
        if (con == null) return false;
        String userId = "U_" + UUID.randomUUID().toString().substring(0, 8);

        String[][] tablePairs = {
            {"tbl_user", "tbl_customer", "Userid"},
            {"User", "Customer", "Userid"}
        };

        for (String[] pair : tablePairs) {
            String userTable = pair[0];
            String custTable = pair[1];
            String fkCol = pair[2];

            String sqlUser = "INSERT INTO `" + userTable + "` (id, name, sdt, email, password, role, ngaytao) VALUES (?, ?, ?, ?, ?, 'CUSTOMER', ?)";
            String sqlCust = "INSERT INTO `" + custTable + "` (" + fkCol + ", diachi) VALUES (?, ?)";

            try {
                con.setAutoCommit(false);
                try (PreparedStatement psUser = con.prepareStatement(sqlUser);
                     PreparedStatement psCust = con.prepareStatement(sqlCust)) {

                    psUser.setString(1, userId);
                    psUser.setString(2, customer.getName());
                    psUser.setString(3, customer.getSdt());

                    if (customer.getEmail() != null && !customer.getEmail().trim().isEmpty()) {
                        psUser.setString(4, customer.getEmail().trim());
                    } else {
                        psUser.setNull(4, Types.VARCHAR);
                    }

                    psUser.setString(5, customer.getPassword());
                    psUser.setDate(6, new Date(System.currentTimeMillis()));
                    psUser.executeUpdate();

                    psCust.setString(1, userId);
                    psCust.setString(2, customer.getDiachi());
                    psCust.executeUpdate();

                    con.commit();
                    con.setAutoCommit(true);
                    return true;
                } catch (Exception ex) {
                    con.rollback();
                    con.setAutoCommit(true);
                }
            } catch (Exception e) {
                try { con.setAutoCommit(true); } catch (Exception ignored) {}
            }
        }
        return false;
    }
}
