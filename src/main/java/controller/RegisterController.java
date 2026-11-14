package controller;

import dao.CustomerDAO;
import model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String sdt = request.getParameter("sdt");
        String email = request.getParameter("email");
        String diachi = request.getParameter("diachi");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Keep form values in request attributes for user convenience
        request.setAttribute("formName", name);
        request.setAttribute("formSdt", sdt);
        request.setAttribute("formEmail", email);
        request.setAttribute("formDiachi", diachi);

        // 1. Check required fields (email is optional)
        if (name == null || name.trim().isEmpty() ||
            sdt == null || sdt.trim().isEmpty() ||
            diachi == null || diachi.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường thông tin bắt buộc (*)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        sdt = sdt.trim();
        // 2. Validate phone number format (9 to 11 digits)
        if (!sdt.matches("^[0-9]{9,11}$")) {
            request.setAttribute("error", "Số điện thoại không đúng định dạng (phải chứa từ 9 đến 11 chữ số)!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 3. Validate email format (only if user provided email)
        if (email != null && !email.trim().isEmpty()) {
            email = email.trim();
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                request.setAttribute("error", "Địa chỉ email không đúng định dạng!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }
        } else {
            email = null;
        }

        // 4. Validate password length (>= 6 characters)
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có độ dài tối thiểu 6 ký tự!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 5. Validate confirm password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp với mật khẩu đã nhập!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 6. Check duplicate in database
        CustomerDAO dao = new CustomerDAO();
        if (dao.checkUserExists(email, sdt)) {
            request.setAttribute("error", "Số điện thoại hoặc Email này đã được đăng ký trước đó!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 7. Save customer
        Customer cust = new Customer();
        cust.setName(name.trim());
        cust.setSdt(sdt);
        cust.setEmail(email);
        cust.setDiachi(diachi.trim());
        cust.setPassword(password);

        boolean success = dao.addNewCustomer(cust);
        if (!success && dao.isConnected()) {
            request.setAttribute("error", "Đăng ký không thành công. Vui lòng kiểm tra lại thông tin!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("currentUser", cust);
        session.setAttribute("successMsg", "Đăng ký tài khoản thành viên thành công!");

        response.sendRedirect(request.getContextPath() + "/customer-home");
    }
}
