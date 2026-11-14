<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper" style="max-width: 600px; margin: 3rem auto;">
    <h1 class="page-title page-title-center">Đăng nhập</h1>

    <c:if test="${param.msg == 'logged_out'}">
        <div class="alert alert-success">
            Đã đăng xuất thành công.
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group" style="margin-bottom: 1.5rem;">
            <label class="form-label" for="username">
                Tên đăng nhập (Số điện thoại hoặc Email): <span class="req">*</span>
            </label>
            <input type="text" id="username" name="username" class="form-control" 
                   value="${username}" placeholder="Nhập số điện thoại hoặc email đăng ký" required autofocus>
        </div>

        <div class="form-group" style="margin-bottom: 2rem;">
            <label class="form-label" for="password">
                Mật khẩu: <span class="req">*</span>
            </label>
            <input type="password" id="password" name="password" class="form-control" 
                   placeholder="Nhập mật khẩu" required>
        </div>

		<div style="display: flex; flex-direction: column; align-items: center; gap: 0.75rem;">
			<button type="submit" class="btn btn-primary" style="min-width: 150px;">
				Đăng nhập
			</button>

			<p style="margin: 0; font-size: 0.95rem;">
				Chưa có tài khoản?
				<a href="${pageContext.request.contextPath}/register" style="text-decoration: underline; font-weight: 500;">
					Đăng ký
				</a>
			</p>
		</div>
    </form>
</div>

</body>
</html>
