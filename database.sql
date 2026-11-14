-- ========================================================
-- CƠ SỞ DỮ LIỆU: OnlineShop (Theo đặc tả đề tài số 35)
-- ========================================================

CREATE DATABASE IF NOT EXISTS `OnlineShop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `OnlineShop`;

-- 1. Bảng User
DROP TABLE IF EXISTS `OrderDetail`;
DROP TABLE IF EXISTS `Invoice`;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS `ImportDetail`;
DROP TABLE IF EXISTS `ImportReceipt`;
DROP TABLE IF EXISTS `Supplier`;
DROP TABLE IF EXISTS `Product`;
DROP TABLE IF EXISTS `Category`;
DROP TABLE IF EXISTS `Customer`;
DROP TABLE IF EXISTS `Employee`;
DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `sdt` VARCHAR(15) NOT NULL UNIQUE,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `role` VARCHAR(50) NOT NULL DEFAULT 'CUSTOMER',
    `ngaytao` DATE NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Bảng Customer (Kế thừa User)
CREATE TABLE `Customer` (
    `Userid` VARCHAR(255) NOT NULL,
    `diachi` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`Userid`),
    CONSTRAINT `fk_customer_user` FOREIGN KEY (`Userid`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Bảng Employee (Kế thừa User)
CREATE TABLE `Employee` (
    `Userid` VARCHAR(255) NOT NULL,
    `chucvu` VARCHAR(255) DEFAULT 'Nhân viên quản lý',
    PRIMARY KEY (`Userid`),
    CONSTRAINT `fk_employee_user` FOREIGN KEY (`Userid`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Bảng Category
CREATE TABLE `Category` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Bảng Product
CREATE TABLE `Product` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `mota` TEXT DEFAULT NULL,
    `giagoc` DOUBLE NOT NULL DEFAULT 0,
    `giaban` DOUBLE NOT NULL DEFAULT 0,
    `Categoryid` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_product_category` FOREIGN KEY (`Categoryid`) REFERENCES `Category` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Bảng Order
CREATE TABLE `Order` (
    `id` VARCHAR(255) NOT NULL,
    `ngaytao` DATE NOT NULL,
    `tongtien` DOUBLE NOT NULL DEFAULT 0,
    `trangthai` VARCHAR(50) DEFAULT 'COMPLETED',
    `CustomerUserid` VARCHAR(255) DEFAULT NULL,
    `EmployeeUserid` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_order_customer` FOREIGN KEY (`CustomerUserid`) REFERENCES `Customer` (`Userid`) ON DELETE SET NULL,
    CONSTRAINT `fk_order_employee` FOREIGN KEY (`EmployeeUserid`) REFERENCES `Employee` (`Userid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Bảng OrderDetail
CREATE TABLE `OrderDetail` (
    `id` VARCHAR(255) NOT NULL,
    `soluong` INT NOT NULL DEFAULT 1,
    `dongia` DOUBLE NOT NULL DEFAULT 0,
    `thanhtien` DOUBLE NOT NULL DEFAULT 0,
    `Orderid` VARCHAR(255) NOT NULL,
    `Productid` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_orderdetail_order` FOREIGN KEY (`Orderid`) REFERENCES `Order` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_orderdetail_product` FOREIGN KEY (`Productid`) REFERENCES `Product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Bảng Supplier
CREATE TABLE `Supplier` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `sdt` VARCHAR(15) DEFAULT NULL,
    `diachi` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Bảng ImportReceipt
CREATE TABLE `ImportReceipt` (
    `id` VARCHAR(255) NOT NULL,
    `ngaynhap` DATE NOT NULL,
    `tongtien` DOUBLE DEFAULT 0,
    `EmployeeUserid` VARCHAR(255) DEFAULT NULL,
    `Supplierid` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_import_employee` FOREIGN KEY (`EmployeeUserid`) REFERENCES `Employee` (`Userid`),
    CONSTRAINT `fk_import_supplier` FOREIGN KEY (`Supplierid`) REFERENCES `Supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10. Bảng ImportDetail
CREATE TABLE `ImportDetail` (
    `id` VARCHAR(255) NOT NULL,
    `soluong` INT NOT NULL DEFAULT 0,
    `dongia` DOUBLE NOT NULL DEFAULT 0,
    `thanhtien` DOUBLE NOT NULL DEFAULT 0,
    `ImportReceiptid` VARCHAR(255) NOT NULL,
    `Productid` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_importdetail_receipt` FOREIGN KEY (`ImportReceiptid`) REFERENCES `ImportReceipt` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_importdetail_product` FOREIGN KEY (`Productid`) REFERENCES `Product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 11. Bảng Invoice
CREATE TABLE `Invoice` (
    `id` VARCHAR(255) NOT NULL,
    `ngaytao` DATE NOT NULL,
    `tongtien` DOUBLE NOT NULL DEFAULT 0,
    `Orderid` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_invoice_order` FOREIGN KEY (`Orderid`) REFERENCES `Order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========================================================
-- Tạo Views tương thích với tiền tố tbl_
-- ========================================================
CREATE OR REPLACE VIEW `tbl_user` AS SELECT * FROM `User`;
CREATE OR REPLACE VIEW `tbl_customer` AS SELECT * FROM `Customer`;
CREATE OR REPLACE VIEW `tbl_employee` AS SELECT * FROM `Employee`;
CREATE OR REPLACE VIEW `tbl_category` AS SELECT * FROM `Category`;
CREATE OR REPLACE VIEW `tbl_product` AS SELECT * FROM `Product`;
CREATE OR REPLACE VIEW `tbl_order` AS SELECT * FROM `Order`;
CREATE OR REPLACE VIEW `tbl_orderdetail` AS SELECT * FROM `OrderDetail`;

-- ========================================================
-- DỮ LIỆU MẪU THEO ĐÚNG TÀI LIỆU ĐẶC TẢ
-- ========================================================

-- Nhân viên quản lý (Tài khoản đăng nhập trang quản lý)
INSERT INTO `User` (`id`, `name`, `sdt`, `email`, `password`, `role`, `ngaytao`) VALUES
('U_M01', 'Nguyễn Quản Lý', '0988888888', 'ql01@shop.vn', '123456', 'MANAGEMENT', '2026-01-01'),
('U_C01', 'Nguyễn Văn A', '0901234567', 'anv@gmail.com', '123456', 'CUSTOMER', '2026-08-01'),
('U_C02', 'Trần Thị B', '0912345678', 'btt@gmail.com', '123456', 'CUSTOMER', '2026-08-02'),
('U_C03', 'Lê Văn C', '0922334455', 'cle@gmail.com', '123456', 'CUSTOMER', '2026-08-05');

INSERT INTO `Employee` (`Userid`, `chucvu`) VALUES
('U_M01', 'Quản lý cửa hàng');

INSERT INTO `Customer` (`Userid`, `diachi`) VALUES
('U_C01', 'Số 1 Tràng Thi, Cửa Nam, Hoàn Kiếm, Hà Nội'),
('U_C02', '128 Cầu Giấy, Quan Hoa, Cầu Giấy, Hà Nội'),
('U_C03', '45 Kim Mã, Ba Đình, Hà Nội');

-- Danh mục
INSERT INTO `Category` (`id`, `name`) VALUES
('CAT01', 'Giày dép'),
('CAT02', 'Thể thao & Dã ngoại'),
('CAT03', 'Thời trang nam nữ');

-- Sản phẩm (Theo kịch bản đặc tả Trang 14-15)
-- J01: Giày thể thao (Giá gốc 400.000, Giá bán 960.000)
-- J02: Thảm yoga (Giá gốc 150.000, Giá bán 400.000)
INSERT INTO `Product` (`id`, `name`, `mota`, `giagoc`, `giaban`, `Categoryid`) VALUES
('J01', 'Giày thể thao', 'Giày thể thao chạy bộ thoáng khí đệm khí êm ái', 400000, 960000, 'CAT01'),
('J02', 'Thảm yoga', 'Thảm tập yoga định tuyến TPE chống trượt 8mm', 150000, 400000, 'CAT02'),
('J03', 'Vợt cầu lông Pro', 'Vợt cầu lông trợ lực sợi carbon siêu nhẹ', 250000, 650000, 'CAT02'),
('J04', 'Áo thun thể thao', 'Áo thun thể thao dry-fit co giãn 4 chiều', 100000, 250000, 'CAT03');

-- Đơn hàng trong tháng 8/2026 (01/08/2026 - 31/08/2026) theo kịch bản:
-- OD0015: 03/08/2026, Nguyễn Văn A, mua 1 Giày thể thao = 960.000
-- OD0102: 28/08/2026, Trần Thị B, mua 2 Giày thể thao = 1.920.000
-- Thêm các đơn khác để J01 đạt 50 đôi = 48.000.000 đ, J02 đạt 25 thảm = 10.000.000 đ
INSERT INTO `Order` (`id`, `ngaytao`, `tongtien`, `trangthai`, `CustomerUserid`, `EmployeeUserid`) VALUES
('OD0015', '2026-08-03', 960000, 'COMPLETED', 'U_C01', 'U_M01'),
('OD0102', '2026-08-28', 1920000, 'COMPLETED', 'U_C02', 'U_M01'),
('OD0020', '2026-08-10', 19200000, 'COMPLETED', 'U_C03', 'U_M01'),
('OD0035', '2026-08-15', 25920000, 'COMPLETED', 'U_C01', 'U_M01'),
('OD0040', '2026-08-05', 4000000, 'COMPLETED', 'U_C02', 'U_M01'),
('OD0055', '2026-08-20', 6000000, 'COMPLETED', 'U_C03', 'U_M01');

INSERT INTO `OrderDetail` (`id`, `soluong`, `dongia`, `thanhtien`, `Orderid`, `Productid`) VALUES
-- Đơn OD0015: 1 đôi J01
('DT001', 1, 960000, 960000, 'OD0015', 'J01'),
-- Đơn OD0102: 2 đôi J01
('DT002', 2, 960000, 1920000, 'OD0102', 'J01'),
-- Đơn OD0020: 20 đôi J01
('DT003', 20, 960000, 19200000, 'OD0020', 'J01'),
-- Đơn OD0035: 27 đôi J01 (Tổng J01 = 1 + 2 + 20 + 27 = 50 đôi, 48.000.000 đ)
('DT004', 27, 960000, 25920000, 'OD0035', 'J01'),
-- Đơn OD0040: 10 thảm yoga J02
('DT005', 10, 400000, 4000000, 'OD0040', 'J02'),
-- Đơn OD0055: 15 thảm yoga J02 (Tổng J02 = 10 + 15 = 25 cái, 10.000.000 đ)
('DT006', 15, 400000, 6000000, 'OD0055', 'J02');
