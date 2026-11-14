package controller;

import dao.RevenueStatDAO;
import model.RevenueStat;
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

@WebServlet("/item-revenue-stat")
public class ItemRevenueStatController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String startStr = request.getParameter("startDate");
        String endStr = request.getParameter("endDate");

        LocalDate defaultStart = LocalDate.of(2026, 8, 1);
        LocalDate defaultEnd = LocalDate.of(2026, 8, 31);

        LocalDate startLocalDate = defaultStart;
        LocalDate endLocalDate = defaultEnd;

        if (startStr != null && !startStr.trim().isEmpty()) {
            try {
                startLocalDate = LocalDate.parse(startStr.trim());
            } catch (Exception ignored) {}
        }
        if (endStr != null && !endStr.trim().isEmpty()) {
            try {
                endLocalDate = LocalDate.parse(endStr.trim());
            } catch (Exception ignored) {}
        }

        request.setAttribute("startDate", startLocalDate.toString());
        request.setAttribute("endDate", endLocalDate.toString());

        // Validate: startDate <= endDate
        if (startLocalDate.isAfter(endLocalDate)) {
            request.setAttribute("error", "Bộ lọc thời gian không hợp lệ: Ngày bắt đầu (" 
                    + startLocalDate + ") không được lớn hơn Ngày kết thúc (" + endLocalDate + ")!");
            request.setAttribute("statList", new ArrayList<RevenueStat>());
            request.setAttribute("totalRevenue", 0.0);
            request.setAttribute("totalQuantity", 0);
            request.getRequestDispatcher("/item_revenue_stat.jsp").forward(request, response);
            return;
        }

        Date sqlStartDate = Date.valueOf(startLocalDate);
        Date sqlEndDate = Date.valueOf(endLocalDate);

        RevenueStatDAO dao = new RevenueStatDAO();
        List<RevenueStat> list = dao.getItemByRevenue(sqlStartDate, sqlEndDate);
        if (list == null) {
            list = new ArrayList<>();
        }

        double totalRevenue = 0;
        int totalQuantity = 0;
        for (RevenueStat item : list) {
            totalRevenue += item.getTongdoanhthu();
            totalQuantity += item.getTongsoluong();
        }

        request.setAttribute("statList", list);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalQuantity", totalQuantity);

        request.getRequestDispatcher("/item_revenue_stat.jsp").forward(request, response);
    }
}
