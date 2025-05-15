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
VALUES ('MB002', N'Boeing 737', 160, N'Boeing', N'Đang bảo trì', 'HAN');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB003', N'ATR 72', 68, N'ATR', N'Đang sử dụng', 'DAD');

INSERT INTO MAY_BAY (MaMayBay, LoaiMayBay, SoGhe, HangSanXuat, TrangThai, ViTriHienTai) 
VALUES ('MB004', N'Airbus A320neo', 186, N'Airbus', N'Đang sử dụng', 'CXR');

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
COMMIT;

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
COMMIT;
SELECT * FROM CHUYEN_BAY;
SELECT * FROM MAY_BAY mb;
SELECT * FROM SAN_BAY sb;
SELECT * FROM TUYEN_BAY tb;
DELETE FROM CHUYEN_BAY;
SELECT 


SELECT CB.MACHUYENBAY, TB.SANBAYDI, TB.SANBAYDEN, CB.GIOCATCANH, CB.GIOHACANH, CB.GIAVE, CB.SOGHETRONG 
FROM CHUYEN_BAY CB JOIN TUYEN_BAY TB ON CB.MATUYENBAY = TB.MATUYENBAY 
WHERE LOWER(TB.SANBAYDI) = LOWER ('HAN')  AND LOWER (TB.SANBAYDEN) = LOWER ('DAD')  
AND TRUNC(CB.GIOCATCANH) = TO_DATE('06/06/2025', 'DD/MM/YYYY')  AND CB.SOGHETRONG >= 1;



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




