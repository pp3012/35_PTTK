<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn thống kê</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper" style="max-width: 650px; margin: 4rem auto; text-align: center;">
    <h1 class="page-title page-title-center" style="margin-bottom: 2.5rem;">Chọn thống kê</h1>

    <form action="${pageContext.request.contextPath}/item-revenue-stat" method="get">
        <div class="form-group" style="text-align: left; max-width: 400px; margin: 0 auto 2rem;">
            <label class="form-label" for="statType">
                Loại thống kê: <span class="req">*</span>
            </label>
            <select id="statType" name="statType" class="form-control" style="cursor: pointer;" required>
                <option value="item-revenue" selected>Thống kê mặt hàng theo doanh thu</option>
            </select>
        </div>

        <div style="display: flex; justify-content: center; gap: 1.25rem;">
            <button type="submit" class="btn btn-primary" style="min-width: 140px;">
                Xem
            </button>
            <a href="${pageContext.request.contextPath}/management-home" class="btn btn-secondary" style="min-width: 140px;">
                Quay lại
            </a>
        </div>
    </form>
</div>

</body>
</html>
