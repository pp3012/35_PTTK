package dao;

import model.Customer;
import model.Order;
import model.OrderDetail;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO extends DAO {
    public OrderDetailDAO() {
        super();
    }

    public List<OrderDetail> getItemTransaction(String productId, Date startDate, Date endDate) {
        List<OrderDetail> list = new ArrayList<>();
        if (con == null) return list;

        String[][] tableCombos = {
            {"tbl_order_detail", "tbl_order", "tbl_customer", "tbl_user"},
            {"tbl_orderdetail", "tbl_order", "tbl_customer", "tbl_user"},
            {"OrderDetail", "Order", "Customer", "User"}
        };

        for (String[] combo : tableCombos) {
            String odTable = combo[0];
            String oTable = combo[1];
            String cTable = combo[2];
            String uTable = combo[3];

            // Chỉ lấy các giao dịch từ đơn hàng có trạng thái "Hoàn thành" đã ghi nhận doanh thu
            String sql = "SELECT od.id AS od_id, od.soluong, od.dongia, od.thanhtien, "
                       + "o.id AS order_id, o.ngaytao AS order_date, o.tongtien AS order_total, o.trangthai AS order_status, "
                       + "u.id AS customer_id, u.name AS customer_name, u.sdt AS customer_phone, c.diachi AS customer_address "
                       + "FROM `" + odTable + "` od "
                       + "JOIN `" + oTable + "` o ON od.Orderid = o.id "
                       + "LEFT JOIN `" + cTable + "` c ON o.CustomerUserid = c.Userid "
                       + "LEFT JOIN `" + uTable + "` u ON c.Userid = u.id "
                       + "WHERE od.Productid = ? AND o.ngaytao >= ? AND o.ngaytao <= ? "
                       + "AND (o.trangthai = 'Hoàn thành' OR o.trangthai = 'Hoan thanh' OR o.trangthai = 'COMPLETED') "
                       + "ORDER BY o.ngaytao DESC";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, productId);
                ps.setDate(2, startDate);
                ps.setDate(3, endDate);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        OrderDetail od = new OrderDetail();
                        od.setId(rs.getString("od_id"));
                        od.setSoluong(rs.getInt("soluong"));
                        od.setDongia(rs.getDouble("dongia"));
                        od.setThanhtien(rs.getDouble("thanhtien"));

                        Order order = new Order();
                        order.setId(rs.getString("order_id"));
                        order.setNgaytao(rs.getDate("order_date"));
                        order.setTongtien(rs.getDouble("order_total"));
                        order.setTrangthai(rs.getString("order_status"));

                        Customer cust = new Customer();
                        cust.setId(rs.getString("customer_id"));
                        cust.setName(rs.getString("customer_name") != null ? rs.getString("customer_name") : "Khách hàng");
                        cust.setSdt(rs.getString("customer_phone"));
                        cust.setDiachi(rs.getString("customer_address"));

                        order.setCustomer(cust);
                        od.setOrder(order);

                        list.add(od);
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
