/* ================================= 1. QUẢN LÝ NHÂN VIÊN =================================== */
-- 1.1 Mỗi nhân viên phải thuộc một trong các loại sau: Phi công, Tiếp viên, Kỹ thuật viên,
-- Nhân viên bảo vệ, Nhân viên thủ tục, Quản lý.
ALTER TABLE NHAN_VIEN
ADD CONSTRAINT CHECK_NhanVien_ChucVu CHECK(ChucVu IN ('Phi công', 'Tiếp viên',
'Kỹ thuật viên', 'Nhân viên bảo vệ', 'Nhân viên thủ tục', 'Quản lý'));

-- 1.2 Mỗi nhân viên phải làm việc phải từ 18 tuổi trở lên.
CREATE OR REPLACE TRIGGER TRG_NHANVIEN_KIEMTRATUOI
BEFORE INSERT OR UPDATE ON NHAN_VIEN
FOR EACH ROW
BEGIN
  IF EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM :NEW.NGAYSINH) < 18 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nhân viên phải trên 18 tuổi!');
  END IF;
END;

-- 1.3 Phi công phải có bằng lái hợp lệ và còn thời hạn
-- Trigger trên bảng NHAN_VIEN
CREATE OR REPLACE TRIGGER TRG_PHICONG_CHECKBANGCAP
BEFORE INSERT OR UPDATE ON NHAN_VIEN
FOR EACH ROW
WHEN (NEW.ChucVu = 'Phi công') 
DECLARE
    v_count NUMBER;
BEGIN
    -- Kiểm tra xem nhân viên có bằng lái hợp lệ và còn thời hạn không
    SELECT COUNT(*) INTO v_count
    FROM BANG_CAP
    WHERE MaNhanVien = :NEW.MaNhanVien
      AND TenBangCap IN ('PPL', 'CPL', 'HPL')
      AND TrangThai = 'Còn hạn';

    -- Nếu không tìm thấy bằng lái hợp lệ
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Phi công phải có bằng lái hợp lệ và còn thời hạn!');
    END IF;
END;

-- Trigger trên bảng BANG_CAP
CREATE OR REPLACE TRIGGER TRG_BANGCAP_CHECKPHICONG
BEFORE INSERT OR UPDATE ON BANG_CAP
FOR EACH ROW
DECLARE
    v_chucvu NVARCHAR2(50);
BEGIN
    -- Lấy chức vụ của nhân viên
    SELECT ChucVu INTO v_chucvu
    FROM NHAN_VIEN
    WHERE MaNhanVien = :NEW.MaNhanVien;

    -- Nếu nhân viên là phi công, kiểm tra bằng lái
    IF v_chucvu = 'Phi công' AND 
       :NEW.TenBangCap NOT IN ('PPL', 'CPL', 'HPL') THEN
        RAISE_APPLICATION_ERROR(-20003, 'Phi công chỉ có thể có bằng PPL, CPL hoặc HPL!');
    END IF;
END;

-- 1.4 Tiếp viên phải có chứng chỉ đào tạo hợp lệ và còn thời hạn
-- Trigger trên bảng NHAN_VIEN

CREATE OR REPLACE TRIGGER TRG_TIEPVIEN_CHECKBANGCAP
BEFORE INSERT OR UPDATE ON NHAN_VIEN
FOR EACH ROW
WHEN (NEW.ChucVu = 'Tiếp viên') 
DECLARE
    v_count NUMBER;
BEGIN
    -- Kiểm tra xem nhân viên có chứng chỉ hợp lệ và còn thời hạn không
    SELECT COUNT(*) INTO v_count
    FROM BANG_CAP
    WHERE MaNhanVien = :NEW.MaNhanVien
      AND TenBangCap IS NOT NULL
      AND TrangThai = 'Còn hạn';

    -- Nếu không tìm thấy chứng chỉ hợp lệ
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Tiếp viên phải có chứng chỉ đào tạo hợp lệ và còn thời hạn!');
    END IF;
END;

-- Trigger trên bảng BANG_CAP
CREATE OR REPLACE TRIGGER TRG_BANGCAP_CHECKTIEPVIEN
BEFORE INSERT OR UPDATE ON BANG_CAP
FOR EACH ROW
DECLARE
    v_chucvu NVARCHAR2(50);
BEGIN
    -- Lấy chức vụ của nhân viên
    SELECT ChucVu INTO v_chucvu
    FROM NHAN_VIEN
    WHERE MaNhanVien = :NEW.MaNhanVien;

    -- Nếu nhân viên là tiếp viên, kiểm tra chứng chỉ
    IF v_chucvu = 'Tiếp viên' AND :NEW.TenBangCap IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'Tiếp viên phải có chứng chỉ đào tạo hợp lệ!');
    END IF;
END;
/* ============================================ 2. QUẢN LÝ CHUYẾN BAY ================================== */
 2.1 Ràng buộc toàn vẹn cho trạng thái của chuyến bay đang chọn (TrangThai) nhận giá trị là “Đang mở” thì mới có thể đặt vé chuyến bay đó.
CREATE OR REPLACE TRIGGER TRG_VE_MAY_BAY_CHECK_TRANGTHAI
BEFORE INSERT OR UPDATE ON VE_MAY_BAY
FOR EACH ROW
DECLARE
    v_trang_thai CHUYEN_BAY.TRANGTHAI%TYPE;
BEGIN
    -- Lấy trạng thái chuyến bay tương ứng
    SELECT TrangThai INTO v_trang_thai
    FROM CHUYEN_BAY
    WHERE MaChuyenBay = :NEW.MaChuyenBay;

    -- Nếu trạng thái khác 'Đang mở' thì chặn lại
    IF v_trang_thai != 'Đang mở' THEN
        RAISE_APPLICATION_ERROR(-20201, 'Chỉ các chuyến bay đang mở mới được phép đặt vé.');
    END IF;
END;
/

2.2 Ràng buộc toàn vẹn cho thời gian khách hàng có thể đặt vé là trước thời gian cất cánh của chuyến bay (GioCatCanh) 3 giờ.
CREATE OR REPLACE TRIGGER TRG_VE_MAY_BAY_DATVE_TRUOC3H
BEFORE INSERT OR UPDATE ON VE_MAY_BAY
FOR EACH ROW
DECLARE
    v_gio_cat_canh TIMESTAMP;
BEGIN
    -- Lấy thời gian cất cánh của chuyến bay
    SELECT GioCatCanh INTO v_gio_cat_canh
    FROM CHUYEN_BAY
    WHERE MaChuyenBay = :NEW.MaChuyenBay;

    -- Kiểm tra nếu thời gian hiện tại cách thời gian cất cánh < 3 giờ
    IF v_gio_cat_canh - SYSTIMESTAMP < INTERVAL '3' HOUR THEN
        RAISE_APPLICATION_ERROR(-20202, 'Chỉ được đặt vé trước giờ cất cánh ít nhất 3 giờ.');
    END IF;
END;
/

2.3 Ràng buộc toàn vẹn cho tình trạng vé (TrangThaiVe) nhận giá trị “Chưa thanh toán” và số lượng ghế trống của chuyến bay (SoGheTrong) giảm xuống 1 đơn vị sau khi hoàn tất thủ tục đăng ký.
CREATE OR REPLACE TRIGGER TRG_VE_MAY_BAY_UPDATE_SOGHETRONG
AFTER UPDATE OF TrangThaiVe ON VE_MAY_BAY
FOR EACH ROW
BEGIN
    -- Trường hợp: vé chuyển sang "Đã thanh toán" từ trạng thái khác
    IF :OLD.TrangThaiVe != 'Đã thanh toán' AND :NEW.TrangThaiVe = 'Đã thanh toán' THEN
        UPDATE CHUYEN_BAY
        SET SoGheTrong = SoGheTrong - 1
        WHERE MaChuyenBay = :NEW.MaChuyenBay;

    -- Trường hợp: vé chuyển sang "Đã hủy" từ trạng thái "Đã thanh toán"
    ELSIF :OLD.TrangThaiVe = 'Đã thanh toán' AND :NEW.TrangThaiVe = 'Đã hủy' THEN
        UPDATE CHUYEN_BAY
        SET SoGheTrong = SoGheTrong + 1
        WHERE MaChuyenBay = :NEW.MaChuyenBay;
    END IF;
END;
/

2.4 Ràng buộc toàn vẹn cho khách hàng không được đặt vé đang được giữ chỗ/có tình trạng (TrangThaiVe) đã nhận một trong các giá trị (”Chưa thanh toán”, “Đã thanh toán”).
CREATE OR REPLACE TRIGGER TRG_CT_VE_GIUGHE 
BEFORE INSERT OR UPDATE ON CT_VE
FOR EACH ROW
DECLARE
    v_chuyen_bay   VE_MAY_BAY.MaChuyenBay%TYPE;
    v_trang_thai   VE_MAY_BAY.TrangThaiVe%TYPE;
    v_vi_tri_ghe   CT_VE.ViTriGhe%TYPE;
    v_ma_khach     VE_MAY_BAY.MaKhachHang%TYPE;
    v_count        NUMBER;
BEGIN
    -- Lấy thông tin vé mới
    SELECT MaChuyenBay, TrangThaiVe, MaKhachHang
    INTO v_chuyen_bay, v_trang_thai, v_ma_khach
    FROM VE_MAY_BAY
    WHERE MaVe = :NEW.MaVe;

    -- Chỉ kiểm tra nếu trạng thái giữ chỗ là “Chưa thanh toán” hoặc “Đã thanh toán”
    IF v_trang_thai IN ('Chưa thanh toán', 'Đã thanh toán') THEN
        -- Kiểm tra xem có vé khác đã giữ chỗ này chưa
        SELECT COUNT(*)
        INTO v_count
        FROM CT_VE ct
        JOIN VE_MAY_BAY ve ON ct.MaVe = ve.MaVe
        WHERE ve.MaChuyenBay = v_chuyen_bay
          AND ct.ViTriGhe = :NEW.ViTriGhe
          AND ve.TrangThaiVe IN ('Chưa thanh toán', 'Đã thanh toán')
          AND ve.MaVe != :NEW.MaVe;

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20206, 'Ghế này đã được giữ hoặc đặt bởi người khác.');
        END IF;
    END IF;
END;
/

2.5 Ràng buộc toàn vẹn cho tình trạng của vé máy bay (TrangThaiVe) nhận một trong các giá trị (”Chưa thanh toán”, “Đã thanh toán”) thì mới có thể hủy/đổi vé.
CREATE OR REPLACE TRIGGER TRG_QUAN_LY_HUY_DOI_VE_CHECK_HOPLE
BEFORE INSERT OR UPDATE ON QUAN_LY_HUY_DOI_VE
FOR EACH ROW
DECLARE
    v_trang_thai_ve     VE_MAY_BAY.TRANGTHAIVE%TYPE;
    v_trang_thai_cb     CHUYEN_BAY.TRANGTHAI%TYPE;
    v_ma_chuyen_bay     CHUYEN_BAY.MACHUYENBAY%TYPE;
BEGIN
    -- Chỉ kiểm tra nếu yêu cầu là Hủy vé hoặc Đổi vé
    IF :NEW.LoaiYeuCau IN ('Hủy vé', 'Đổi vé') THEN
        -- Lấy trạng thái vé và mã chuyến bay
        SELECT TrangThaiVe, MaChuyenBay
        INTO v_trang_thai_ve, v_ma_chuyen_bay
        FROM VE_MAY_BAY
        WHERE MaVe = :NEW.MaVe;

        -- Kiểm tra trạng thái vé có hợp lệ không
        IF v_trang_thai_ve NOT IN ('Chưa thanh toán', 'Đã thanh toán') THEN
            RAISE_APPLICATION_ERROR(-20203, 'Chỉ vé đã hoặc chưa thanh toán mới được hủy/đổi.');
        END IF;

        -- Lấy trạng thái chuyến bay
        SELECT TrangThai
        INTO v_trang_thai_cb
        FROM CHUYEN_BAY
        WHERE MaChuyenBay = v_ma_chuyen_bay;

        -- Kiểm tra trạng thái chuyến bay phải là “Đang mở”
        IF v_trang_thai_cb != 'Đang mở' THEN
            RAISE_APPLICATION_ERROR(-20204, 'Chỉ được hủy/đổi vé nếu chuyến bay còn đang mở.');
        END IF;
    END IF;
END;
/

2.6 Ràng buộc toàn vẹn cho vé máy bay chỉ được hủy/đổi chỗ trước ngày cất cánh của chuyến bay (GioCatCanh) 1 ngày.
CREATE OR REPLACE TRIGGER TRG_QUAN_LY_HUY_DOI_VE_TRUOC1NGAY 
BEFORE INSERT OR UPDATE ON QUAN_LY_HUY_DOI_VE
FOR EACH ROW
DECLARE
    v_ma_cb       VE_MAY_BAY.MaChuyenBay%TYPE;
    v_gio_catcanh CHUYEN_BAY.GioCatCanh%TYPE;
BEGIN
    -- Chỉ áp dụng cho yêu cầu hủy hoặc đổi vé
    IF :NEW.LoaiYeuCau IN ('Hủy vé', 'Đổi vé') THEN
        -- Lấy mã chuyến bay từ vé
        SELECT MaChuyenBay INTO v_ma_cb
        FROM VE_MAY_BAY
        WHERE MaVe = :NEW.MaVe;

        -- Lấy giờ cất cánh của chuyến bay
        SELECT GioCatCanh INTO v_gio_catcanh
        FROM CHUYEN_BAY
        WHERE MaChuyenBay = v_ma_cb;

        -- Kiểm tra nếu thời gian yêu cầu >= 1 ngày trước giờ cất cánh
        IF v_gio_catcanh - :NEW.ThoiGianYeuCau < INTERVAL '1' DAY THEN
            RAISE_APPLICATION_ERROR(-20205, 'Vé chỉ được hủy/đổi trước giờ cất cánh ít nhất 1 ngày.');
        END IF;
    END IF;
END;
/

2.7 Ràng buộc toàn vẹn cho tình trạng vé bị hủy/đổi và số lượng ghế trống của chuyến bay (SoGheTrong) tăng lên một đơn vị sau khi hoàn tất thủ tục
CREATE OR REPLACE TRIGGER TRG_QUAN_LY_HUY_DOI_VE_UPDATE_GHE
AFTER UPDATE ON QUAN_LY_HUY_DOI_VE
FOR EACH ROW
DECLARE
    v_ma_cb        VE_MAY_BAY.MaChuyenBay%TYPE;
    v_trang_thai   VE_MAY_BAY.TrangThaiVe%TYPE;
BEGIN
    -- Kiểm tra nếu trạng thái cập nhật là 'Đã chấp nhận'
    IF :NEW.TrangThai = 'Đã chấp nhận' AND :OLD.TrangThai != 'Đã chấp nhận' THEN
        -- Lấy mã chuyến bay và trạng thái vé tương ứng
        SELECT MaChuyenBay, TrangThaiVe INTO v_ma_cb, v_trang_thai
        FROM VE_MAY_BAY
        WHERE MaVe = :NEW.MaVe;

        -- Nếu vé đã bị hủy thì mới tăng ghế trống
        IF v_trang_thai = 'Đã hủy' THEN
            UPDATE CHUYEN_BAY
            SET SoGheTrong = SoGheTrong + 1
            WHERE MaChuyenBay = v_ma_cb;
        END IF;
    END IF;
END;
/


2.8 Ràng buộc toàn vẹn cho ngày đặt vé phải nằm trong khoảng giữa ngày bắt đầu (NgayBatDau) và ngày kết thúc của voucher/ưu đãi (NgayKetThuc).

CREATE OR REPLACE TRIGGER TRG_THANH_TOAN_CHECK_THOIGIANKM
BEFORE INSERT OR UPDATE ON THANH_TOAN
FOR EACH ROW
DECLARE
    v_ngay_dat_ve   VE_MAY_BAY.NgayDatVe%TYPE;
    v_ngay_bat_dau  KHUYEN_MAI.NgayBatDau%TYPE;
    v_ngay_ket_thuc KHUYEN_MAI.NgayKetThuc%TYPE;
BEGIN
    -- Lấy ngày đặt vé
    SELECT NgayDatVe INTO v_ngay_dat_ve
    FROM VE_MAY_BAY
    WHERE MaVe = :NEW.MaVe;

    -- Lấy thời gian hiệu lực của khuyến mãi
    SELECT NgayBatDau, NgayKetThuc INTO v_ngay_bat_dau, v_ngay_ket_thuc
    FROM KHUYEN_MAI
    WHERE MaKhuyenMai = :NEW.MaKhuyenMai;

    -- Kiểm tra điều kiện khuyến mãi hợp lệ
    IF v_ngay_dat_ve NOT BETWEEN v_ngay_bat_dau AND v_ngay_ket_thuc THEN
        RAISE_APPLICATION_ERROR(-20207, 'Ngày đặt vé không nằm trong khoảng thời gian áp dụng khuyến mãi.');
    END IF;
END;
/


### 2.9 Ràng buộc toàn vẹn cho số lượt được dùng mỗi voucher/ưu đãi là một lần trên một vé

ALTER TABLE THANH_TOAN
ADD CONSTRAINT unique_km_mot_lan_cho_mot_ve
UNIQUE (MaVe, MaKhuyenMai);


2.10 Ràng buộc toàn vẹn cho tình trạng vé máy bay nhận giá trị “Chưa thanh toán” thì mới có thể áp dụng voucher/ưu đãi.
CREATE OR REPLACE TRIGGER trg_thanh_toan_check_trangthaive 
BEFORE INSERT OR UPDATE ON THANH_TOAN
FOR EACH ROW
DECLARE
    v_trang_thai VE_MAY_BAY.TrangThaiVe%TYPE;
BEGIN
    -- Nếu có khuyến mãi được áp dụng
    IF :NEW.MaKhuyenMai IS NOT NULL THEN
        -- Lấy trạng thái của vé
        SELECT TrangThaiVe INTO v_trang_thai
        FROM VE_MAY_BAY
        WHERE MaVe = :NEW.MaVe;

        -- Kiểm tra nếu không phải 'Chưa thanh toán' thì báo lỗi
        IF v_trang_thai <> 'Chưa thanh toán' THEN
            RAISE_APPLICATION_ERROR(-20208, 'Chỉ vé chưa thanh toán mới được áp dụng khuyến mãi.');
        END IF;
    END IF;
END;
/


/* ============================================ 3. QUẢN LÝ KHÁCH HÀNG ================================== */
-- 3.1. Căn cước công dân (CCCD) phải là duy nhất.
-- Đã set UNIQUE trong CREATE TABLE KHACH_HANG
-- 3.2. Ngày sinh khách hàng (NgaySinh) không được vượt quá ngày hiện tại. 
CREATE OR REPLACE TRIGGER TRG_KHACH_HANG_NgaySinh
BEFORE INSERT OR UPDATE ON KHACH_HANG
FOR EACH ROW
BEGIN
    IF :NEW.NgaySinh > TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20301, 'Ngày sinh không được vượt quá ngày hiện tại.');
    END IF;
END;

-- 3.3. Ngày sinh khách hàng (NgaySinh) được nhập theo định dạng (dd/mm/yyyy) (Điều kiện: 1 ≤ dd ≤ 31, 1 ≤ mm ≤ 12)

-- 3.4. Số điện thoại của khách hàng (SDT) phải có độ dài 10-12 ký tự và chỉ chứa chữ số.
CREATE OR REPLACE TRIGGER TRG_KHACH_HANG_SDT
BEFORE INSERT OR UPDATE ON KHACH_HANG
FOR EACH ROW
BEGIN
    IF :NEW.SDT IS NOT NULL THEN
        -- Kiểm tra độ dài
        IF LENGTH(:NEW.SDT) < 10 OR LENGTH(:NEW.SDT) > 12 THEN
            RAISE_APPLICATION_ERROR(-20302, 'Số điện thoại phải có độ dài từ 10 đến 12 ký tự.');
        END IF;

        -- Kiểm tra chỉ chứa chữ số
        IF REGEXP_LIKE(:NEW.SDT, '[^0-9]') THEN
            RAISE_APPLICATION_ERROR(-20303, 'Số điện thoại chỉ được chứa chữ số.');
        END IF;
    END IF;
END;

-- 3.5 Email của khách hàng (Email) phải có định dạng hợp lệ (chứa ký tự '@' và '.').
CREATE OR REPLACE TRIGGER TRG_KHACH_HANG_Email
BEFORE INSERT OR UPDATE ON KHACH_HANG
FOR EACH ROW
BEGIN
    IF :NEW.Email IS NOT NULL THEN
        IF NOT REGEXP_LIKE(:NEW.Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
            RAISE_APPLICATION_ERROR(-20304, 'Email không hợp lệ. Phải chứa "@" và "." theo định dạng chuẩn.');
        END IF;
    END IF;
END;


