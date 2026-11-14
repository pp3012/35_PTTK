<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng bách hoá</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper" style="max-width: 650px; margin: 4rem auto; text-align: center;">
    <h1 class="page-title page-title-center" style="margin-bottom: 2.5rem;">Cửa hàng bách hoá</h1>

    <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
            <p style="margin-bottom: 2rem; color: var(--text-secondary); font-size: 1.1rem;">
                Xin chào, <strong>${sessionScope.currentUser.name}</strong> 
                <span class="badge badge-blue" style="margin-left: 0.5rem;">${sessionScope.currentUser.role}</span>
            </p>
            <div style="display: flex; gap: 1rem; justify-content: center;">
                <c:choose>
                    <c:when test="${sessionScope.currentUser.role == 'MANAGER' or sessionScope.currentUser.role == 'MANAGEMENT' or sessionScope.currentUser.role == 'STAFF'}">
                        <a href="${pageContext.request.contextPath}/management-home" class="btn btn-primary" style="min-width: 180px;">
                            Vào trang quản lý
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/customer-home" class="btn btn-primary" style="min-width: 180px;">
                            Vào trang mua sắm
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-secondary">
                    Đăng xuất
                </a>
            </div>
        </c:when>

		<c:otherwise>
			<div style="display: flex; flex-direction: column; align-items: center; gap: 0.75rem;">
				<a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="min-width: 240px;">
					Đăng nhập
				</a>

				<p style="margin: 0; font-size: 0.95rem;">
					Chưa có tài khoản?
					<a href="${pageContext.request.contextPath}/register" style="text-decoration: underline; font-weight: 500;">
						Đăng ký
					</a>
				</p>
			</div>
		</c:otherwise>
    </c:choose>
</div>

</body>
</html>
