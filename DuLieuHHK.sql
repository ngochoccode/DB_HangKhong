﻿
-- Sân bay

INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('SGN', N'Tân Sơn Nhất', N'TP. Hồ Chí Minh', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('HAN', N'Nội Bài', N'Hà Nội', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('DAD', N'Đà Nẵng', N'Đà Nẵng', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('CXR', N'Cam Ranh', N'Khánh Hòa', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('PQC', N'Phú Quốc', N'Kiên Giang', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('HUI', N'Phú Bài', N'Thừa Thiên Huế', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('VII', N'Vinh', N'Nghệ An', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('BMV', N'Buôn Ma Thuột', N'Đắk Lắk', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('VCA', N'Cần Thơ', N'Cần Thơ', N'Việt Nam');
INSERT INTO SAN_BAY (MaSanBay, TenSanBay, TinhThanhPho, QuocGia) VALUES ('THD', N'Thọ Xuân', N'Thanh Hóa', N'Việt Nam');
COMMIT;

-- Máy bay
INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB001', N'Airbus A321', 180, N'Airbus', N'Đang sử dụng', 'SGN');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB002', N'Boeing 737', 90, N'Boeing', N'Đang bảo trì', 'HAN');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB003', N'ATR 72', 68, N'ATR', N'Đang sử dụng', 'DAD');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB004', N'Airbus A320neo', 100, N'Airbus', N'Đang sử dụng', 'CXR');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB005', N'Boeing 787-9', 274, N'Boeing', N'Đang bảo trì', 'PQC');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB006', N'Embraer E190', 98, N'Embraer', N'Đang sử dụng', 'SGN');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB007', N'Bombardier Q400', 78, N'Bombardier', N'Dừng hoạt động', 'HUI');
COMMIT;

-- Tuyến bay
INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB001', 'SGN', 'HAN', 1150.00);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB002', 'HAN', 'DAD', 630.50);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB003', 'DAD', 'SGN', 965.25);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB004', 'SGN', 'PQC', 300.00);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB005', 'CXR', 'HAN', 1050.75);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB006', 'VII', 'SGN', 900.00);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB007', 'SGN', 'BMV', 320.00);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB008', 'HAN', 'VCA', 1220.00);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB009', 'SGN', 'THD', 1080.00);

INSERT INTO TUYEN_BAY (MaTuyenBay, SanBayDi, SanBayDen, KhoangCach) 
VALUES ('TB010', 'HUI', 'SGN', 660.00);

-- Chuyến bay
INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB001', 'TB001', 'MB001', TO_TIMESTAMP('2025-06-06 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 1500000, 30);

INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB002', 'TB002', 'MB002', TO_TIMESTAMP('2025-06-06 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 1200000, 50);

INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB003', 'TB003', 'MB003', TO_TIMESTAMP('2025-06-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 1000000, 40);

INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB004', 'TB004', 'MB004', TO_TIMESTAMP('2025-06-06 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 1750000, 20);

INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB005', 'TB005', 'MB005', TO_TIMESTAMP('2025-06-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 2000000, 10);

INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB006', 'TB006', 'MB006', TO_TIMESTAMP('2025-06-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 1100000, 60);

INSERT INTO CHUYEN_BAY (MaChuyenBay, MaTuyenBay, MaMayBay, GioCatCanh, GioHaCanh, TrangThai, GiaVe, SoGheTrong) 
VALUES ('CB007', 'TB007', 'MB007', TO_TIMESTAMP('2025-06-06 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-06 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đang mở', 950000, 25);


INSERT INTO NHAN_VIEN (MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam) 
VALUES(
    FN_TAO_MANV, 'Trần Thị B', '012345678902', TO_DATE('1992-02-02', 'YYYY-MM-DD'),
    'F', '0912345678', 'b@example.com', 'TP.HCM', 'Kỹ thuật viên', 8200000, NULL, SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN (MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam) 
VALUES(
    FN_TAO_MANV, 'Lê Văn C', '012345678903', TO_DATE('1985-03-03', 'YYYY-MM-DD'),
    'M', '0923456789', 'c@example.com', 'Đà Nẵng', 'Nhân viên bảo vệ', 6500000, NULL, SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN (MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam) 
VALUES(
    FN_TAO_MANV, 'Phạm Thị D', '012345678904', TO_DATE('1988-04-04', 'YYYY-MM-DD'),
    'F', '0934567890', 'd@example.com', 'Cần Thơ', 'Nhân viên bảo vệ', 6600000, NULL, SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN (MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam) 
VALUES(
    FN_TAO_MANV, 'Hoàng Văn E', '012345678905', TO_DATE('1993-05-05', 'YYYY-MM-DD'),
    'M', '0945678901', 'e@example.com', 'Bình Dương', 'Nhân viên thủ tục', 7000000, NULL, SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN (MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam)
VALUES(
    FN_TAO_MANV, 'Đặng Thị F', '012345678906', TO_DATE('1995-06-06', 'YYYY-MM-DD'),
    'F', '0956789012', 'f@example.com', 'Hải Phòng', 'Nhân viên thủ tục', 7100000, NULL, SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN 
(MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam)
 VALUES(
    FN_TAO_MANV, 'Vũ Văn G', '012345678907', TO_DATE('1980-07-07', 'YYYY-MM-DD'),
    'M', '0967890123', 'g@example.com', 'Nghệ An', 'Quản lý', 15000000, 'Bảo hiểm + thưởng', SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN 
(MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam) 
VALUES(
    FN_TAO_MANV, 'Bùi Thị H', '012345678908', TO_DATE('1982-08-08', 'YYYY-MM-DD'),
    'F', '0978901234', 'h@example.com', 'Nam Định', 'Quản lý', 15200000, 'Bảo hiểm + thưởng', SYSTIMESTAMP
);

INSERT INTO NHAN_VIEN 
(MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh, SDT, Email, DiaChi, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam) 
VALUES(
    FN_TAO_MANV, 'Bùi Thị H', '111', TO_DATE('1982-08-08', 'YYYY-MM-DD'),
    'F', '123', '123', 'Nam Định', 'Quản lý', 15200000, 'Bảo hiểm + thưởng', SYSTIMESTAMP
);

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH001', 'Nguyễn Thị A', '001123456789', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901234567', 'nguyenthia@example.com', 'Cá nhân', 150.75, 'Thành viên thường', TO_TIMESTAMP('2026-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH002', 'Trần Văn B', '002987654321', TO_DATE('1985-03-20', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0912345678', 'tranvanb@example.com', 'Cá nhân', 500.20, 'Bạc', TO_TIMESTAMP('2026-06-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH003', 'Lê Thị C', '003112233445', TO_DATE('1992-07-01', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0923456789', 'lethic@example.com', 'Cá nhân', 1200.00, 'Vàng', TO_TIMESTAMP('2026-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH004', 'Phạm Văn D', '004556677880', TO_DATE('1978-11-10', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0934567890', 'phamvand@example.com', 'Doanh nghiệp', 2500.50, 'Kim cương', TO_TIMESTAMP('2026-08-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH005', 'Võ Thị E', '005221144336', TO_DATE('1998-09-05', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0945678901', 'vothie@example.com', 'Cá nhân', 300.00, 'Thành viên thường', TO_TIMESTAMP('2026-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH006', 'Đặng Minh F', '006778899001', TO_DATE('1982-04-12', 'YYYY-MM-DD'), 'M', 'Hoa Kỳ', '0956789012', 'dangminhf@example.com', 'Cá nhân', 800.80, 'Bạc', TO_TIMESTAMP('2026-10-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH007', 'Hoàng Thị G', '007445566778', TO_DATE('1993-02-28', 'YYYY-MM-DD'), 'F', 'Canada', '0967890123', 'hoangthig@example.com', 'Cá nhân', 1600.00, 'Vàng', TO_TIMESTAMP('2026-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH008', 'Ngô Văn H', '008112233440', TO_DATE('1970-06-18', 'YYYY-MM-DD'), 'M', 'Úc', '0978901234', 'ngovanh@example.com', 'Doanh nghiệp', 3500.10, 'Kim cương', TO_TIMESTAMP('2026-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH009', 'Châu Thị I', '009556677880', TO_DATE('1996-08-08', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0989012345', 'chauthin@example.com', 'Cá nhân', 400.00, 'Thành viên thường', TO_TIMESTAMP('2027-01-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO KHACH_HANG (MaKhachHang, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, LoaiKhachHang, DiemThuong, HangThanhVien, ThoiHanTV, ThoiGianCapNhatDT)
VALUES ('KH010', 'Vũ Đình K', '010112233440', TO_DATE('1989-10-25', 'YYYY-MM-DD'), 'M', 'Đức', '0990123456', 'vudinhk@example.com', 'Cá nhân', 1000.00, 'Bạc', TO_TIMESTAMP('2027-02-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-05-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB001'), 'CB001', 'KH001', 1500000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB001'), 'CB001', 'KH002', 1500000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB001'), 'CB001', 'KH003', 1500000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-21 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB001'), 'CB001', 'KH004', 1500000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB001'), 'CB001', 'KH005', 1500000, 'Vé xác định', TO_TIMESTAMP('2025-05-22 08:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

-- Vé cho chuyến bay CB002 (6 vé - GiaVe: 1200000)
INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB002'), 'CB002', 'KH006', 1200000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB002'), 'CB002', 'KH007', 1200000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB002'), 'CB002', 'KH008', 1200000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-21 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB002'), 'CB002', 'KH009', 1200000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB002'), 'CB002', 'KH010', 1200000, 'Vé xác định', TO_TIMESTAMP('2025-05-22 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB002'), 'CB002', 'KH001', 1200000, 'Vé xác định', TO_TIMESTAMP('2025-05-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

-- Vé cho chuyến bay CB003 (4 vé - GiaVe: 1000000)
INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB003'), 'CB003', 'KH002', 1000000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB003'), 'CB003', 'KH003', 1000000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB003'), 'CB003', 'KH004', 1000000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-22 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB003'), 'CB003', 'KH005', 1000000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

-- Vé cho chuyến bay CB004 (5 vé - GiaVe: 1750000)
INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB004'), 'CB004', 'KH006', 1750000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB004'), 'CB004', 'KH007', 1750000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB004'), 'CB004', 'KH008', 1750000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-22 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB004'), 'CB004', 'KH009', 1750000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB004'), 'CB004', 'KH010', 1750000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

-- Vé cho chuyến bay CB005 (6 vé - GiaVe: 2000000)
INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB005'), 'CB005', 'KH001', 2000000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB005'), 'CB005', 'KH002', 2000000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB005'), 'CB005', 'KH003', 2000000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB005'), 'CB005', 'KH004', 2000000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB005'), 'CB005', 'KH005', 2000000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB005'), 'CB005', 'KH006', 2000000, 'Vé xác định', TO_TIMESTAMP('2025-05-24 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

-- Vé cho chuyến bay CB006 (4 vé - GiaVe: 1100000)
INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB006'), 'CB006', 'KH007', 1100000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB006'), 'CB006', 'KH008', 1100000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB006'), 'CB006', 'KH009', 1100000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-22 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB006'), 'CB006', 'KH010', 1100000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

-- Vé cho chuyến bay CB007 (5 vé - GiaVe: 950000)
INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB007'), 'CB007', 'KH001', 950000, 'Vé xác định', TO_TIMESTAMP('2025-05-20 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB007'), 'CB007', 'KH002', 950000, 'Vé xác định', TO_TIMESTAMP('2025-05-21 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB007'), 'CB007', 'KH003', 950000, 'Vé khung giờ', TO_TIMESTAMP('2025-05-22 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chưa thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB007'), 'CB007', 'KH004', 950000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

INSERT INTO VE_MAY_BAY (MaVe, MaChuyenBay, MaKhachHang, TongTien, LoaiVe, NgayDatVe, TrangThaiVe)
VALUES (FN_TAO_MAVE('CB007'), 'CB007', 'KH005', 950000, 'Vé xác định', TO_TIMESTAMP('2025-05-23 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Đã thanh toán');

BEGIN
    -- Vé VECB00137 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Hồng Anh', '012111111111', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000001', 'anh.le@example.com', 'VECB00137', 'Economy', 1500000, 50000, NULL);

    -- Vé VECB00138 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Mạnh Hùng', '013222222222', TO_DATE('1992-02-15', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000002', 'hung.nguyen@example.com', 'VECB00138', 'Business', 750000, 75000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Thị Thảo', '014333333333', TO_DATE('1991-03-20', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000003', 'thao.tran@example.com', 'VECB00138', 'Business', 750000, 75000, NULL);

    -- Vé VECB00139 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Gia Huy', '015444444444', TO_DATE('2010-04-05', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000004', 'huy.pham@example.com', 'VECB00139', 'Economy', 500000, 25000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đinh Ngọc Ánh', '016555555555', TO_DATE('1985-05-10', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000005', 'anh.dinh@example.com', 'VECB00139', 'Economy', 500000, 25000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Ngô Văn Chung', '017666666666', TO_DATE('1987-06-20', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000006', 'chung.ngo@example.com', 'VECB00139', 'Economy', 500000, 25000, NULL);

    -- Vé VECB00140 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Bùi Thị Hà', '018777777777', TO_DATE('1975-07-07', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000007', 'ha.bui@example.com', 'VECB00140', 'First Class', 1500000, 100000, NULL);

    -- Vé VECB00141 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đặng Văn Lực', '019888888888', TO_DATE('1993-08-01', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000008', 'luc.dang@example.com', 'VECB00141', 'Premium Economy', 750000, 60000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Hoàng Lan Hương', '020999999999', TO_DATE('1994-09-10', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000009', 'huong.hoang@example.com', 'VECB00141', 'Premium Economy', 750000, 60000, NULL);

    -- Vé VECB00242 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Quốc Tuấn', '021111111112', TO_DATE('1988-10-25', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000010', 'tuan.nguyen@example.com', 'VECB00242', 'Economy', 1200000, 40000, NULL);

    -- Vé VECB00243 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Minh Quân', '022222222223', TO_DATE('1990-11-11', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000011', 'quan.le@example.com', 'VECB00243', 'Business', 600000, 80000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Thị Ngân', '023333333334', TO_DATE('1991-12-30', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000012', 'ngan.tran@example.com', 'VECB00243', 'Business', 600000, 80000, NULL);

    -- Vé VECB00244 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Võ Đức Duy', '024444444445', TO_DATE('2012-01-01', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000013', 'duy.vo@example.com', 'VECB00244', 'Economy', 400000, 20000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Thanh Thảo', '025555555556', TO_DATE('1980-02-02', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000014', 'thao.pham@example.com', 'VECB00244', 'Economy', 400000, 20000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Tấn An', '026666666667', TO_DATE('1981-03-03', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000015', 'an.nguyen@example.com', 'VECB00244', 'Economy', 400000, 20000, NULL);

    -- Vé VECB00245 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lý Hải Đăng', '027777777778', TO_DATE('1995-04-04', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000016', 'dang.ly@example.com', 'VECB00245', 'First Class', 1200000, 90000, NULL);

    -- Vé VECB00246 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đặng Thị Anh', '028888888889', TO_DATE('1989-05-05', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000017', 'anh.dang@example.com', 'VECB00246', 'Premium Economy', 600000, 50000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Bùi Văn Hùng', '029999999990', TO_DATE('1990-06-06', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000018', 'hung.bui@example.com', 'VECB00246', 'Premium Economy', 600000, 50000, NULL);
    
    -- Vé VECB00247 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Võ Thị Kiều', '030000000001', TO_DATE('1997-07-07', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000019', 'kieu.vo@example.com', 'VECB00247', 'Economy', 400000, 30000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Hoàng Đạt', '031111111112', TO_DATE('1996-08-08', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000020', 'dat.nguyen@example.com', 'VECB00247', 'Economy', 400000, 30000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Thanh Trung', '032222222223', TO_DATE('1995-09-09', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000021', 'trung.tran@example.com', 'VECB00247', 'Economy', 400000, 30000, NULL);

    -- Vé VECB00348 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Thanh Hà', '033333333334', TO_DATE('1990-10-10', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000022', 'ha.le@example.com', 'VECB00348', 'Business', 1000000, 60000, NULL);

    -- Vé VECB00349 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Duy Vinh', '034444444445', TO_DATE('1985-11-11', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000023', 'vinh.pham@example.com', 'VECB00349', 'Economy', 500000, 25000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Thị Bích', '035555555556', TO_DATE('1986-12-12', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000024', 'bich.nguyen@example.com', 'VECB00349', 'Economy', 500000, 25000, NULL);

    -- Vé VECB00350 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Văn Long', '036666666667', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000025', 'long.tran@example.com', 'VECB00350', 'Economy', 333333.33, 15000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Võ Thị Diễm', '037777777778', TO_DATE('2001-02-02', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000026', 'diem.vo@example.com', 'VECB00350', 'Economy', 333333.33, 15000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Hoàng Mạnh Huy', '038888888889', TO_DATE('2002-03-03', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000027', 'huy.hoang@example.com', 'VECB00350', 'Economy', 333333.33, 15000, NULL);

    -- Vé VECB00351 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Thị Minh', '039999999990', TO_DATE('1998-04-04', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000028', 'minh.nguyen@example.com', 'VECB00351', 'Premium Economy', 500000, 40000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Văn Thành', '040000000001', TO_DATE('1997-05-05', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000029', 'thanh.pham@example.com', 'VECB00351', 'Premium Economy', 500000, 40000, NULL);

    -- Vé VECB00452 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đào Văn An', '041111111112', TO_DATE('1990-06-06', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000030', 'an.dao@example.com', 'VECB00452', 'Business', 1750000, 100000, NULL);

    -- Vé VECB00453 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Bùi Thị Lan', '042222222223', TO_DATE('1988-07-07', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000031', 'lan.bui@example.com', 'VECB00453', 'Economy', 875000, 40000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Văn Phúc', '043333333334', TO_DATE('1987-08-08', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000032', 'phuc.tran@example.com', 'VECB00453', 'Economy', 875000, 40000, NULL);

    -- Vé VECB00454 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Thị Mai', '044444444445', TO_DATE('2005-09-09', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000033', 'mai.le@example.com', 'VECB00454', 'Economy', 583333.33, 20000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Tấn Lợi', '045555555556', TO_DATE('1970-10-10', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000034', 'loi.nguyen@example.com', 'VECB00454', 'Economy', 583333.33, 20000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Vũ Thị Thanh', '046666666667', TO_DATE('1971-11-11', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000035', 'thanh.vu@example.com', 'VECB00454', 'Economy', 583333.33, 20000, NULL);

    -- Vé VECB00455 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phan Thanh Hải', '047777777778', TO_DATE('1980-12-12', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000036', 'hai.phan@example.com', 'VECB00455', 'First Class', 1750000, 120000, NULL);
    -- Vé VECB00456 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đặng Thị Thu', '048888888889', TO_DATE('1999-01-01', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000037', 'thu.dang@example.com', 'VECB00456', 'Premium Economy', 583333.33, 50000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Văn Tùng', '049999999990', TO_DATE('1998-02-02', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000038', 'tung.le@example.com', 'VECB00456', 'Premium Economy', 583333.33, 50000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Thị Kim', '050000000001', TO_DATE('1997-03-03', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000039', 'kim.tran@example.com', 'VECB00456', 'Premium Economy', 583333.33, 50000, NULL);

    -- Vé VECB00557 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Thu Huyền', '051111111112', TO_DATE('1985-04-04', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000040', 'huyen.nguyen@example.com', 'VECB00557', 'Business', 2000000, 120000, NULL);

    -- Vé VECB00558 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Văn Lâm', '052222222223', TO_DATE('1990-05-05', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000041', 'lam.pham@example.com', 'VECB00558', 'Economy', 1000000, 50000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đỗ Thị Lan', '053333333334', TO_DATE('1991-06-06', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000042', 'lan.do@example.com', 'VECB00558', 'Economy', 1000000, 50000, NULL);

    -- Vé VECB00559 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Thị Thanh', '054444444445', TO_DATE('2000-07-07', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000043', 'thanh.le@example.com', 'VECB00559', 'Economy', 666666.67, 30000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Văn Hùng', '055555555556', TO_DATE('1999-08-08', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000044', 'hung.tran@example.com', 'VECB00559', 'Economy', 666666.67, 30000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Vũ Thị Hoa', '056666666667', TO_DATE('1998-09-09', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000045', 'hoa.vu@example.com', 'VECB00559', 'Economy', 666666.67, 30000, NULL);

    -- Vé VECB00560 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Hoàng Mạnh Cường', '057777777778', TO_DATE('1980-10-10', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000046', 'cuong.hoang@example.com', 'VECB00560', 'First Class', 2000000, 150000, NULL);

    -- Vé VECB00561 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Thị Thùy', '058888888889', TO_DATE('1995-11-11', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000047', 'thuy.nguyen@example.com', 'VECB00561', 'Premium Economy', 1000000, 70000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Văn Long', '059999999990', TO_DATE('1994-12-12', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000048', 'long.pham@example.com', 'VECB00561', 'Premium Economy', 1000000, 70000, NULL);

    -- Vé VECB00562 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Thị Mai Anh', '060000000001', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000049', 'maianh.le@example.com', 'VECB00562', 'Economy', 666666.67, 35000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Văn Minh', '061111111112', TO_DATE('1999-02-02', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000050', 'minh.tran@example.com', 'VECB00562', 'Economy', 666666.67, 35000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Vũ Thị Ngọc', '062222222223', TO_DATE('1998-03-03', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000051', 'ngoc.vu@example.com', 'VECB00562', 'Economy', 666666.67, 35000, NULL);

    -- Vé VECB00663 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đặng Văn Khoa', '063333333334', TO_DATE('1990-04-04', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000052', 'khoa.dang@example.com', 'VECB00663', 'Business', 1100000, 70000, NULL);

    -- Vé VECB00664 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Đình Thi', '064444444445', TO_DATE('1985-05-05', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000053', 'thi.nguyen@example.com', 'VECB00664', 'Economy', 550000, 20000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Thị Hương', '065555555556', TO_DATE('1986-06-06', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000054', 'huong.le@example.com', 'VECB00664', 'Economy', 550000, 20000, NULL);

    -- Vé VECB00665 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Văn Đức', '066666666667', TO_DATE('2000-07-07', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000055', 'duc.tran@example.com', 'VECB00665', 'Economy', 366666.67, 10000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Thị Linh', '067777777778', TO_DATE('2001-08-08', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000056', 'linh.pham@example.com', 'VECB00665', 'Economy', 366666.67, 10000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Đỗ Gia Bảo', '068888888889', TO_DATE('2002-09-09', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000057', 'bao.do@example.com', 'VECB00665', 'Economy', 366666.67, 10000, NULL);

    -- Vé VECB00666 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Thị Bích', '069999999990', TO_DATE('1990-10-10', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000058', 'bich.nguyen1@example.com', 'VECB00666', 'Business', 950000, 50000, NULL);

    -- Vé VECB00767 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Văn Hiệp', '070000000001', TO_DATE('1985-11-11', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000059', 'hiep.le@example.com', 'VECB00767', 'Economy', 475000, 15000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Thị Thu Thảo', '071111111112', TO_DATE('1986-12-12', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000060', 'thuthao.tran@example.com', 'VECB00767', 'Economy', 475000, 15000, NULL);

    -- Vé VECB00768 (3 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Phạm Tuấn Anh', '072222222223', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000061', 'tuananh.pham@example.com', 'VECB00768', 'Economy', 316666.67, 10000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Vũ Thị Mai', '073333333334', TO_DATE('1999-02-02', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000062', 'mai.vu@example.com', 'VECB00768', 'Economy', 316666.67, 10000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Hoàng Đình Toàn', '074444444445', TO_DATE('1998-03-03', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000063', 'toan.hoang@example.com', 'VECB00768', 'Economy', 316666.67, 10000, NULL);

    -- Vé VECB00769 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Nguyễn Minh Hải', '075555555556', TO_DATE('1980-04-04', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000064', 'hai.nguyen@example.com', 'VECB00769', 'First Class', 950000, 80000, NULL);

    -- Vé VECB00770 (2 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Lê Thị Diệu', '076666666667', TO_DATE('1995-05-05', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000065', 'dieu.le@example.com', 'VECB00770', 'Premium Economy', 475000, 30000, NULL);
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Trần Văn Quang', '077777777778', TO_DATE('1994-06-06', 'YYYY-MM-DD'), 'M', 'Việt Nam', '0901000066', 'quang.tran@example.com', 'VECB00770', 'Premium Economy', 475000, 30000, NULL);

    -- Vé VECB00771 (1 hành khách)
    INSERT INTO HANH_KHACH (MaHanhKhach, HoTen, CCCD, NgaySinh, GioiTinh, QuocTich, SDT, Email, MaVe, HangGhe, GiaTien, PhiBoSung, ViTriGhe)
    VALUES (FN_TAO_MAHK(), 'Bùi Ngọc Lan', '078888888889', TO_DATE('1993-07-07', 'YYYY-MM-DD'), 'F', 'Việt Nam', '0901000067', 'lan.bui2@example.com', 'VECB00771', 'Economy', 900000, 30000, NULL);

    COMMIT;
END;

INSERT INTO GOI_HANH_LY (MaGoiHanhLy, TenGoiHanhLy, TrongLuongMax, GiaTien)
VALUES ('GHL01', 'Xách tay', 10.00, 0.00);

INSERT INTO GOI_HANH_LY (MaGoiHanhLy, TenGoiHanhLy, TrongLuongMax, GiaTien)
VALUES ('GHL02', 'Xách tay bonus', 10.00, 150000.00);

INSERT INTO GOI_HANH_LY (MaGoiHanhLy, TenGoiHanhLy, TrongLuongMax, GiaTien)
VALUES ('GHL03', 'Ký gửi 20kg', 20.00, 200000.00);

INSERT INTO GOI_HANH_LY (MaGoiHanhLy, TenGoiHanhLy, TrongLuongMax, GiaTien)
VALUES ('GHL04', 'Ký gửi 30kg', 30.00, 300000.00); -- Lưu ý: Bạn ghi là "10" cho trọng lượng ở đây, nhưng tên là "30kg" và giá cao, nên tôi sẽ đặt là 30.00. Nếu bạn muốn 10kg, hãy đổi lại.

INSERT INTO GOI_HANH_LY (MaGoiHanhLy, TenGoiHanhLy, TrongLuongMax, GiaTien)
VALUES ('GHL05', 'Ký gửi 40kg', 40.00, 400000.00); -- Tương tự, tôi đặt là 40.00.


DECLARE
    TYPE HanhKhachArray IS TABLE OF VARCHAR2(15);
    -- Danh sách các MaHanhKhach bạn đã cung cấp
    p_HanhKhachList HanhKhachArray := HanhKhachArray(
        'HK064', 'HK065', 'HK066', 'HK067', 'HK068', 'HK069', 'HK070', 'HK071',
        'HK072', 'HK073', 'HK074', 'HK075', 'HK076', 'HK077', 'HK078', 'HK079',
        'HK080', 'HK081', 'HK082', 'HK083', 'HK084', 'HK085', 'HK086', 'HK087',
        'HK088', 'HK089', 'HK090', 'HK091', 'HK092', 'HK093', 'HK094', 'HK095',
        'HK096', 'HK097'
    );
    
    TYPE GoiHanhLyRecord IS RECORD (
        MaGoiHanhLy VARCHAR2(10),
        TrongLuongMin NUMBER(5,2),
        TrongLuongMax NUMBER(5,2)
    );
    TYPE GoiHanhLyArray IS TABLE OF GoiHanhLyRecord;
    
    -- Định nghĩa các gói hành lý và khoảng trọng lượng hợp lý
    GoiHanhLys GoiHanhLyArray := GoiHanhLyArray(
        GoiHanhLyRecord('GHL01', 2.00, 10.00),  -- Xách tay (tối đa 10kg)
        GoiHanhLyRecord('GHL02', 2.00, 10.00),  -- Xách tay bonus (tối đa 10kg)
        GoiHanhLyRecord('GHL03', 10.00, 20.00), -- Ký gửi 20kg
        GoiHanhLyRecord('GHL04', 15.00, 30.00), -- Ký gửi 30kg
        GoiHanhLyRecord('GHL05', 20.00, 40.00)  -- Ký gửi 40kg
    );
    
    TYPE TrangThaiArray IS TABLE OF NVARCHAR2(100);
    TrangThais TrangThaiArray := TrangThaiArray('Chưa gửi', 'Đã gửi', 'Đang vận chuyển', 'Đã nhận');
    
    TYPE ViTriArray IS TABLE OF NVARCHAR2(100);
    ViTris ViTriArray := ViTriArray('Khoang hàng trước', 'Khoang hàng sau', 'Cabin');

    v_num_luggage NUMBER;
    v_selected_goi_hl GoiHanhLyRecord;
    v_trong_luong NUMBER(5,2);
    v_trang_thai NVARCHAR2(100);
    v_vi_tri_hanh_ly NVARCHAR2(100);

BEGIN
    -- Đặt seed cho hàm random để có kết quả khác nhau mỗi lần chạy
    DBMS_RANDOM.SEED(TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISS'));

    FOR i IN 1..p_HanhKhachList.COUNT LOOP
        -- Ngẫu nhiên 1 hoặc 2 hành lý cho mỗi hành khách
        v_num_luggage := TRUNC(DBMS_RANDOM.VALUE(1, 3)); -- Sinh ra 1 hoặc 2

        FOR j IN 1..v_num_luggage LOOP
            -- Ngẫu nhiên chọn một gói hành lý từ danh sách
            v_selected_goi_hl := GoiHanhLys(TRUNC(DBMS_RANDOM.VALUE(1, GoiHanhLys.COUNT + 1)));
            
            -- Ngẫu nhiên trọng lượng trong khoảng cho phép của gói hành lý đã chọn
            v_trong_luong := ROUND(DBMS_RANDOM.VALUE(v_selected_goi_hl.TrongLuongMin, v_selected_goi_hl.TrongLuongMax), 2);
            
            -- Ngẫu nhiên trạng thái của hành lý
            v_trang_thai := TrangThais(TRUNC(DBMS_RANDOM.VALUE(1, TrangThais.COUNT + 1)));
            
            -- Ngẫu nhiên vị trí hành lý
            v_vi_tri_hanh_ly := ViTris(TRUNC(DBMS_RANDOM.VALUE(1, ViTris.COUNT + 1)));

            INSERT INTO HANH_LY (MaHanhLy, MaGoiHanhLy, MaHanhKhach, TrongLuong, TrangThai, ViTriHanhLy)
            VALUES (
                FN_TAO_MAHL(),             -- Mã hành lý duy nhất
                v_selected_goi_hl.MaGoiHanhLy, -- Mã gói hành lý được chọn
                p_HanhKhachList(i),        -- Mã hành khách hiện tại
                v_trong_luong,
                v_trang_thai,
                v_vi_tri_hanh_ly
            );
        END LOOP;
    END LOOP;
    
    COMMIT;
END;




