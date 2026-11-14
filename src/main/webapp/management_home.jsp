<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ quản lý</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper" style="max-width: 650px; margin: 4rem auto; text-align: center;">
    <h1 class="page-title page-title-center" style="margin-bottom: 2.5rem;">Trang chủ quản lý</h1>

	<div style="display: flex; flex-direction: column; gap: 1rem; align-items: center;">
		<a href="${pageContext.request.contextPath}/select-stat" class="btn btn-primary" style="min-width: 200px;">
			Xem thống kê
		</a>
		<a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-secondary" style="min-width: 140px; color: var(--danger);">
			Đăng xuất
		</a>
	</div>

</div>

</body>
</html>
