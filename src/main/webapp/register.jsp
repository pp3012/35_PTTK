<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper" style="max-width: 600px; margin: 1rem auto;">
    <h1 class="page-title" style="text-align: center;">Đăng ký tài khoản</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" autocomplete="off">
        <div class="form-grid" style="display: flex; flex-direction: column; gap: 1rem;">
            <!-- Họ và tên: bắt buộc (*) -->
            <div class="form-group">
                <label class="form-label" for="name">
                    Họ và tên: <span class="req">*</span>
                </label>
                <input type="text" id="name" name="name" class="form-control" 
                       value="${formName}" placeholder="Nhập họ và tên" required autofocus>
            </div>

            <!-- Số điện thoại: bắt buộc (*) -->
            <div class="form-group">
                <label class="form-label" for="sdt">
                    Số điện thoại: <span class="req">*</span>
                </label>
                <input type="tel" id="sdt" name="sdt" class="form-control" 
                       value="${formSdt}" placeholder="Nhập số điện thoại (tối đa 10 số)" required>
            </div>

            <!-- Địa chỉ: bắt buộc (*) -->
            <div class="form-group">
                <label class="form-label" for="diachi">
                    Địa chỉ: <span class="req">*</span>
                </label>
                <input type="text" id="diachi" name="diachi" class="form-control" 
                       value="${formDiachi}" placeholder="Nhập địa chỉ nhận hàng" required>
            </div>

            <!-- Email: OPTIONAL (Không bắt buộc, không có dấu sao đỏ) -->
            <div class="form-group">
                <label class="form-label" for="email">
                    Email: <span style="font-weight: normal; color: var(--text-muted); font-size: 0.85rem;"></span>
                </label>
                <input type="email" id="email" name="email" class="form-control" 
                       value="${formEmail}" placeholder="Nhập email nếu có (ví dụ: user@example.com)">
            </div>

            <!-- Mật khẩu: bắt buộc (*) -->
            <div class="form-group">
                <label class="form-label" for="password">
                    Mật khẩu: <span class="req">*</span>
                </label>
                <input type="password" id="password" name="password" class="form-control" 
                       placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)" minlength="6" required>
            </div>

            <!-- Xác nhận mật khẩu: bắt buộc (*) -->
            <div class="form-group">
                <label class="form-label" for="confirmPassword">
                    Xác nhận mật khẩu: <span class="req">*</span>
                </label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                       placeholder="Nhập lại mật khẩu" minlength="6" required>
            </div>
        </div>

        <div style="display: flex;flex-direction: column; gap: 0.75rem; align-items: center; margin-top: 1rem;">
            <button type="submit" class="btn btn-primary" style="min-width: 160px;">
                Đăng ký
            </button>

			<p style="margin: 0; font-size: 0.95rem;">
				Đã có tài khoản?
				<a href="${pageContext.request.contextPath}/login" style="text-decoration: underline; font-weight: 500;">
                Đăng nhập
				</a>
			</p>
        </div>
    </form>
</div>

</body>
</html>
