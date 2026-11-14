package controller;

import dao.OrderDetailDAO;
import dao.ProductDAO;
import model.OrderDetail;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/detail-stat")
public class DetailStatController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String startStr = request.getParameter("startDate");
        String endStr = request.getParameter("endDate");

        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/item-revenue-stat");
            return;
        }

        request.setAttribute("productId", productId);
        request.setAttribute("startDate", startStr);
        request.setAttribute("endDate", endStr);

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductInfo(productId);

        Date sqlStart = null;
        Date sqlEnd = null;
        try {
            if (startStr != null && !startStr.isEmpty()) sqlStart = Date.valueOf(startStr);
            if (endStr != null && !endStr.isEmpty()) sqlEnd = Date.valueOf(endStr);
        } catch (Exception ignored) {}

        if (sqlStart == null) sqlStart = Date.valueOf(LocalDate.of(2026, 8, 1));
        if (sqlEnd == null) sqlEnd = Date.valueOf(LocalDate.of(2026, 8, 31));

        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        List<OrderDetail> transactionList = orderDetailDAO.getItemTransaction(productId, sqlStart, sqlEnd);
        if (transactionList == null) {
            transactionList = new ArrayList<>();
        }

        double totalAmount = 0;
        int totalQty = 0;
        for (OrderDetail od : transactionList) {
            totalAmount += od.getThanhtien();
            totalQty += od.getSoluong();
        }

        request.setAttribute("product", product);
        request.setAttribute("transactionList", transactionList);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("totalQty", totalQty);

        request.getRequestDispatcher("/detail_stat.jsp").forward(request, response);
    }
}
