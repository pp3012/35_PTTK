package dao;

import model.Category;
import model.RevenueStat;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RevenueStatDAO extends DAO {
    public RevenueStatDAO() {
        super();
    }

    public List<RevenueStat> getItemByRevenue(Date startDate, Date endDate) {
        List<RevenueStat> list = new ArrayList<>();
        if (con == null) return list;

        String[][] tableCombos = {
            {"tbl_product", "tbl_order_detail", "tbl_order", "tbl_category"},
            {"tbl_product", "tbl_orderdetail", "tbl_order", "tbl_category"},
            {"Product", "OrderDetail", "Order", "Category"}
        };

        for (String[] combo : tableCombos) {
            String pTable = combo[0];
            String odTable = combo[1];
            String oTable = combo[2];
            String cTable = combo[3];

            // Chỉ lọc các đơn hàng có trạng thái "Hoàn thành" / "COMPLETED" mới tính doanh thu
            String sql = "SELECT p.id, p.name, p.mota, p.giagoc, p.giaban, "
                       + "c.id AS category_id, c.name AS category_name, "
                       + "SUM(od.soluong) AS tongsoluong, "
                       + "SUM(od.thanhtien) AS tongdoanhthu "
                       + "FROM `" + pTable + "` p "
                       + "JOIN `" + odTable + "` od ON od.Productid = p.id "
                       + "JOIN `" + oTable + "` o ON od.Orderid = o.id "
                       + "LEFT JOIN `" + cTable + "` c ON p.Categoryid = c.id "
                       + "WHERE o.ngaytao >= ? AND o.ngaytao <= ? "
                       + "AND (o.trangthai = 'Hoàn thành' OR o.trangthai = 'Hoan thanh' OR o.trangthai = 'COMPLETED') "
                       + "GROUP BY p.id, p.name, p.mota, p.giagoc, p.giaban, c.id, c.name "
                       + "ORDER BY tongdoanhthu DESC";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        RevenueStat stat = new RevenueStat();
                        stat.setId(rs.getString("id"));
                        stat.setName(rs.getString("name"));
                        stat.setMota(rs.getString("mota"));
                        stat.setGiagoc(rs.getDouble("giagoc"));
                        stat.setGiaban(rs.getDouble("giaban"));

                        String catId = rs.getString("category_id");
                        String catName = rs.getString("category_name");
                        if (catId != null || catName != null) {
                            stat.setCategory(new Category(catId, catName != null ? catName : "Chung"));
                        }

                        stat.setTongsoluong(rs.getInt("tongsoluong"));
                        stat.setTongdoanhthu(rs.getDouble("tongdoanhthu"));

                        list.add(stat);
                    }
                    if (!list.isEmpty()) {
                        return list;
                    }
                }
            } catch (Exception ignored) {
                // Try next combo
            }
        }
        return list;
    }
}
