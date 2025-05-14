
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

COMMIT;

SELECT * FROM NHAN_VIEN nv;
INSERT INTO NHAN_VIEN (
    MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh,
    SDT, Email, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam
) VALUES
('NV001', 'Nguyễn Văn A', '012345678901234', DATE '1985-03-15', 'M',
 '0901234567', 'vana@example.com', 'Phi công',       15000000, 'Bảo hiểm y tế; Phép năm', TO_TIMESTAMP('2010-06-01 08:00:00','YYYY-MM-DD HH24:MI:SS'));

INSERT INTO NHAN_VIEN (
    MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh,
    SDT, Email, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam
) VALUES
('NV002', 'Trần Thị B', '023456789012345', DATE '1990-07-22', 'F',
 '0912345678', 'thib@example.com', 'Tiếp viên',       12000000, 'Ăn ca; Đồng phục',      TO_TIMESTAMP('2012-09-15 09:30:00','YYYY-MM-DD HH24:MI:SS'));

INSERT INTO NHAN_VIEN (
    MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh,
    SDT, Email, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam
) VALUES
('NV003', 'Lê Văn C',    '034567890123456', DATE '1982-11-05', 'M',
 '0923456789', 'vanc@example.com', 'Kỹ thuật viên',   10000000, 'Phụ cấp trách nhiệm',  TO_TIMESTAMP('2015-01-20 07:45:00','YYYY-MM-DD HH24:MI:SS'));

INSERT INTO NHAN_VIEN (
    MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh,
    SDT, Email, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam
) VALUES
('NV004', 'Phạm Thị D',  '045678901234567', DATE '1988-02-18', 'F',
 '0934567890', 'thid@example.com', 'Nhân viên thủ tục',  8000000, 'Phép năm; Tiền xăng', TO_TIMESTAMP('2018-04-10 08:15:00','YYYY-MM-DD HH24:MI:SS'));

INSERT INTO NHAN_VIEN (
    MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh,
    SDT, Email, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam
) VALUES
('NV005', 'Hoàng Văn E', '056789012345678', DATE '1992-12-30', 'M',
 '0945678901', 'vane@example.com', 'Nhân viên bảo vệ', 11000000, 'Phụ cấp công tác',    TO_TIMESTAMP('2016-11-05 10:00:00','YYYY-MM-DD HH24:MI:SS'));

INSERT INTO NHAN_VIEN (
    MaNhanVien, HoTen, CCCD, NgaySinh, GioiTinh,
    SDT, Email, ChucVu, LuongCoBan, PhucLoi, NgayVaoLam
) VALUES
('NV006', 'Vũ Văn G',    '078901234567890', DATE '1980-09-12', 'M',
 '0967890123', 'vang@example.com', 'Quản lý',         20000000, 'Xe công; Phép năm',    TO_TIMESTAMP('2008-03-01 08:00:00','YYYY-MM-DD HH24:MI:SS'));
UPDATE NHAN_VIEN
SET DiaChi = 'Hồ Chí Minh'

SELECT * FROM NHAN_VIEN nv
