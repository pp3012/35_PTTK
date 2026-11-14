package dao;

import model.Category;
import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductDAO extends DAO {
    public ProductDAO() {
        super();
    }

    public Product getProductInfo(String productId) {
        if (con == null) return null;

        String[][] tablePairs = {
            {"Product", "Category"},
            {"tbl_product", "tbl_category"}
        };

        for (String[] pair : tablePairs) {
            String pTable = pair[0];
            String cTable = pair[1];
            String sql = "SELECT p.*, c.name AS category_name "
                       + "FROM `" + pTable + "` p "
                       + "LEFT JOIN `" + cTable + "` c ON p.Categoryid = c.id "
                       + "WHERE p.id = ?";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, productId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Product p = new Product();
                        p.setId(rs.getString("id"));
                        p.setName(rs.getString("name"));
                        p.setMota(rs.getString("mota"));
                        p.setGiagoc(rs.getDouble("giagoc"));
                        p.setGiaban(rs.getDouble("giaban"));

                        String catId = rs.getString("Categoryid");
                        String catName = rs.getString("category_name");
                        if (catId != null || catName != null) {
                            p.setCategory(new Category(catId, catName != null ? catName : "Chung"));
                        }
                        return p;
                    }
                }
            } catch (Exception ignored) {
                // Try next variant
            }
        }
        return null;
    }
}
