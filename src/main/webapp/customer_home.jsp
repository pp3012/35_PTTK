<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="page-wrapper">
    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 2rem; border-bottom: 1px solid var(--border-color); padding-bottom: 1.25rem;">
        <div>
            <h1 class="page-title" style="margin-bottom: 0.35rem;">Trang chủ khách hàng</h1>
            <p style="color: var(--text-muted); font-size: 1rem;">
                Xin chào, <strong>${sessionScope.currentUser.name != null ? sessionScope.currentUser.name : 'Khách hàng'}</strong>!
            </p>
        </div>
        <div style="display: flex; gap: 0.75rem;">
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-secondary btn-sm" style="color: var(--danger);">Đăng xuất</a>
        </div>
    </div>

    <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert-success">
            ${sessionScope.successMsg}
        </div>
        <c:remove var="successMsg" scope="session" />
    </c:if>


    <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 1.25rem; color: var(--text-primary);">
        Mời bắt đầu mua sắm
    </h2>

    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1.5rem;">
        <div style="background: #ffffff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 1.5rem;">
            <span class="badge" style="margin-bottom: 0.5rem;">CAT01 - Giày dép</span>
            <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 0.35rem;">Giày thể thao (J01)</h3>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 1rem;">Giày chạy bộ cao cấp</p>
            <div style="font-size: 1.25rem; font-weight: 700; color: #15803d; margin-bottom: 1.25rem;">960.000 đ</div>
            <button type="button" class="btn btn-secondary btn-sm btn-block" onclick="alert('Đã thêm sản phẩm vào giỏ hàng demo!')">Thêm vào giỏ</button>
        </div>

        <div style="background: #ffffff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 1.5rem;">
            <span class="badge" style="margin-bottom: 0.5rem;">CAT02 - Dụng cụ thể thao</span>
            <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 0.35rem;">Thảm yoga (J02)</h3>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 1rem;">Thảm tập chống trượt</p>
            <div style="font-size: 1.25rem; font-weight: 700; color: #15803d; margin-bottom: 1.25rem;">400.000 đ</div>
            <button type="button" class="btn btn-secondary btn-sm btn-block" onclick="alert('Đã thêm sản phẩm vào giỏ hàng demo!')">Thêm vào giỏ</button>
        </div>

        <div style="background: #ffffff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 1.5rem;">
            <span class="badge" style="margin-bottom: 0.5rem;">CAT03 - Thời trang nam</span>
            <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 0.35rem;">Áo thun thể thao (J03)</h3>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 1rem;">Áo thun thấm hút mồ hôi</p>
            <div style="font-size: 1.25rem; font-weight: 700; color: #15803d; margin-bottom: 1.25rem;">300.000 đ</div>
            <button type="button" class="btn btn-secondary btn-sm btn-block" onclick="alert('Đã thêm sản phẩm vào giỏ hàng demo!')">Thêm vào giỏ</button>
        </div>
    </div>
</div>

</body>
</html>
