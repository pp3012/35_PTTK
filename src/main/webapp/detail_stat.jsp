<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê chi tiết mặt hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper">
	<h1 class="page-title page-title-center">Thống kê chi tiết mặt hàng</h1>

    <!-- Thông tin mặt hàng theo đúng thiết kế Image X82 (Full-width grid) -->
	<div class="info-grid" style="width: 100%; max-width: 1000px; margin: 1.5rem auto; background: transparent; border: none; box-shadow: none; padding: 0; display: grid; grid-template-columns: repeat(2, auto); justify-content: start; column-gap: 9rem; row-gap: 0.6rem; text-align: left; font-size: 1rem; color: #000000;">
		<!-- Hàng 1 - Cột 1 -->
		<div class="info-item" style="background: transparent; border: none; padding: 0;">
			<span class="info-label" style="color: #000000; font-weight: 600; text-transform: none; font-size: inherit;">Mã mặt hàng: ${product.id}</span>
		</div>

		<!-- Hàng 1 - Cột 2 -->
		<div class="info-item" style="background: transparent; border: none; padding: 0;">
			<span class="info-label" style="color: #000000; font-weight: 600; text-transform: none; font-size: inherit;">Tên mặt hàng: ${product.name}</span>
		</div>

		<!-- Hàng 2 - Cột 1 -->
		<div class="info-item" style="background: transparent; border: none; padding: 0;">
        <span class="info-label" style="color: #000000; font-weight: 600; text-transform: none; font-size: inherit;">
            Giá gốc: <span style="color: #15803d; font-weight: 700;"><fmt:formatNumber value="${product.giagoc}" pattern="#,##0" /> đ</span>
        </span>
		</div>

		<!-- Hàng 2 - Cột 2 -->
		<div class="info-item" style="background: transparent; border: none; padding: 0;">
        <span class="info-label" style="color: #000000; font-weight: 600; text-transform: none; font-size: inherit;">
            Giá bán hiện tại: <span style="color: #15803d; font-weight: 700;"><fmt:formatNumber value="${product.giaban}" pattern="#,##0" /> đ</span>
        </span>
		</div>

	</div>

    <!-- Bảng danh sách đơn hàng Full Screen rộng rãi -->
	<div class="table-wrap" style="max-width: 1050px; margin: 1.5rem auto; overflow-x: auto;">
		<table class="table" style="width: 100%; min-width: 850px; border-collapse: collapse;">
			<thead>
			<tr>
				<th style="width: 60px; text-align: center;">TT</th>
				<th style="width: 160px; text-align: center;">Mã đơn hàng</th>
				<th style="width: 140px; text-align: center;">Ngày tạo</th>
				<th style="min-width: 180px; text-align: center;">Tên khách hàng</th>
				<th style="width: 180px; text-align: center;">Số lượng mua</th>
				<th style="width: 180px; text-align: right;">Thành tiền</th>
			</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${not empty transactionList}">
					<c:forEach var="trans" items="${transactionList}" varStatus="status">
						<tr>
							<td style="text-align: center; color: var(--text-muted); font-weight: 600;">
									${status.index + 1}
							</td>
							<td style="text-align: center;">
								<strong>${trans.order != null ? trans.order.id : 'N/A'}</strong>
							</td>
							<td style="text-align: center;">
								<fmt:formatDate value="${trans.order.ngaytao}" pattern="dd/MM/yyyy" />
							</td>
							<td style="text-align: center;">
                      <span style="font-weight: 500;">
							  ${trans.order != null && trans.order.customer != null ? trans.order.customer.name : 'Khách hàng'}
					  </span>
							</td>
							<td style="text-align: center; font-weight: 600;">
									${trans.soluong}
							</td>
							<td style="text-align: right; font-weight: 700; color: #15803d;">
								<fmt:formatNumber value="${trans.thanhtien}" pattern="#,##0" /> đ
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6" style="text-align: center; padding: 3rem 1rem; color: var(--text-muted); font-size: 1.05rem;">
							Không có đơn hàng nào của mặt hàng này trong khoảng thời gian đã chọn.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>

	<div style="width: 100%; max-width: 1050px; margin: 1.5rem auto; text-align: left;">
		<a href="${pageContext.request.contextPath}/item-revenue-stat?startDate=${startDate}&endDate=${endDate}" class="btn btn-secondary" style="min-width: 140px;">
			Quay lại
		</a>
	</div>
</div>

</body>
</html>
