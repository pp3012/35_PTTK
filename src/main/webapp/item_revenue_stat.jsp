<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê mặt hàng theo doanh thu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper">
    <h1 class="page-title page-title-center">Thống kê mặt hàng theo doanh thu</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>

    <!-- Bộ lọc thời gian: Đánh dấu sao đỏ cho trường bắt buộc -->
	<form action="${pageContext.request.contextPath}/item-revenue-stat" method="get" class="filter-bar"
		  style="background: transparent; border: none; box-shadow: none; padding: 0; display: flex; flex-direction: row; flex-wrap: nowrap; justify-content: center; align-items: center; gap: 1rem;">

		<div class="filter-item" style="display: flex; flex-direction: row; align-items: center; gap: 0.4rem;">
			<label class="form-label" for="startDate" style="margin: 0; white-space: nowrap;">
				Ngày bắt đầu: <span class="req">*</span>
			</label>
			<input type="date" id="startDate" name="startDate" class="form-control" style="width: 150px;" value="${startDate}" required>
		</div>

		<div class="filter-item" style="display: flex; flex-direction: row; align-items: center; gap: 0.4rem;">
			<label class="form-label" for="endDate" style="margin: 0; white-space: nowrap;">
				Ngày kết thúc: <span class="req">*</span>
			</label>
			<input type="date" id="endDate" name="endDate" class="form-control" style="width: 150px;" value="${endDate}" required>
		</div>

		<button type="submit" class="btn btn-primary" style="min-width: 90px; white-space: nowrap;">
			Xem
		</button>
	</form>

    <!-- Bảng dữ liệu Full Screen rộng rãi -->
	<div class="table-wrap" style="max-width: 1050px; margin: 1.5rem auto; overflow-x: auto;">
		<table class="table" style="width: 100%; min-width: 850px; border-collapse: collapse;">
			<thead>
			<tr>
				<th style="width: 70px; text-align: center;">TT</th>
				<th style="width: 160px; text-align: center;">Mã mặt hàng</th>
				<th style="min-width: 200px; text-align: left;">Tên mặt hàng</th>
				<th style="width: 150px; text-align: center;">Số lượng bán</th>
				<th style="width: 190px; text-align: center;">Tổng doanh thu</th>
				<th style="width: 150px; text-align: center;">Thao tác</th>
			</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${not empty statList}">
					<c:forEach var="item" items="${statList}" varStatus="status">
						<tr>
							<td style="text-align: center; color: var(--text-muted); font-weight: 600;">
									${status.index + 1}
							</td>
							<td style="text-align: center;">
								<strong>${item.id}</strong>
							</td>
							<td style="text-align: left;">
								<span style="font-weight: 500;">${item.name}</span>
							</td>
							<td style="text-align: center; font-weight: 600;">
									${item.tongsoluong}
							</td>
							<td style="text-align: center; font-weight: 700; color: #15803d;">
								<fmt:formatNumber value="${item.tongdoanhthu}" pattern="#,##0" /> đ
							</td>
							<td style="text-align: center;">
								<a href="${pageContext.request.contextPath}/detail-stat?productId=${item.id}&startDate=${startDate}&endDate=${endDate}"
								   class="btn btn-secondary btn-sm" style="font-weight: 600; white-space: nowrap;">
									Xem chi tiết
								</a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6" style="text-align: center; padding: 3rem 1rem; color: var(--text-muted); font-size: 1.05rem;">
							Không có dữ liệu phát sinh doanh thu trong khoảng thời gian đã chọn.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>

	<div style="width: 100%; max-width: 1050px; margin: 1.5rem auto; text-align: left;">
		<a href="${pageContext.request.contextPath}/select-stat" class="btn btn-secondary" style="min-width: 140px;">
			Quay lại
		</a>
	</div>
</div>

</body>
</html>
