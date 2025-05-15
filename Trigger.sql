================================= 1. QUẢN LÝ NHÂN VIÊN =================================== */
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

-- 1.5 Nhân viên phi công/tiếp viên chỉ được phân công cho một máy bay tại một thời điểm.
CREATE OR REPLACE TRIGGER trg_PHAN_CONG_BAY_CHECK_ONLY 
BEFORE INSERT OR UPDATE ON PHAN_CONG_BAY
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM PHAN_CONG_BAY
    WHERE MaNhanVien = :NEW.MaNhanVien
      AND ((:NEW.ThoiGianBatDau < ThoiGianKetThuc) 
      AND (ThoiGianBatDau < :NEW.ThoiGianKetThuc))
      AND MaChuyenBay <> :NEW.MaChuyenBay;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Nhân viên đã được phân công cho một chuyến bay khác trong cùng thời gian.');
    END IF;
END;
/

-- 1.6 Chỉ phân công cho phi công/tiếp viên khi chuyến bay có trạng thái “Đang mở”.

-- Trigger trên bảng PHAN_CONG_BAY
    CREATE OR REPLACE TRIGGER trg_chuyen_bay_check_status
    BEFORE INSERT OR UPDATE ON PHAN_CONG_BAY
    FOR EACH ROW
    DECLARE
        v_trang_thai CHUYEN_BAY.TrangThai%TYPE; 
    BEGIN
        -- Lấy trạng thái của chuyến bay
        SELECT TrangThai INTO v_trang_thai
        FROM CHUYEN_BAY
        WHERE MaChuyenBay = :NEW.MaChuyenBay;
    
        -- Kiểm tra nếu chuyến bay không ở trạng thái "Đang mở"
        IF v_trang_thai <> 'Đang mở' THEN
            RAISE_APPLICATION_ERROR(-20007, 'Không thể phân công nhân viên vì chuyến bay không ở trạng thái "Đang mở".');
        END IF;
    END;
    /
    
-- Trigger trên bảng CHUYEN_BAY
    CREATE OR REPLACE TRIGGER trg_chuyen_bay_update_status
    BEFORE UPDATE ON CHUYEN_BAY
    FOR EACH ROW
    DECLARE
        v_count NUMBER;
    BEGIN
        -- Chỉ kiểm tra khi trạng thái được cập nhật thành "Đang mở"
        IF :NEW.TrangThai = 'Đang mở' THEN
            -- Kiểm tra xem chuyến bay đã có phi công/tiếp viên được phân công chưa
            SELECT COUNT(*) INTO v_count
            FROM PHAN_CONG_BAY
            WHERE MaChuyenBay = :NEW.MaChuyenBay;
    
            -- Nếu đã có người được phân công, không cho phép cập nhật trạng thái
            IF v_count > 0 THEN
                RAISE_APPLICATION_ERROR(-20008, 'Không thể cập nhật trạng thái "Đang mở" vì chuyến bay đã có phi công/tiếp viên được phân công.');
            END IF;
        END IF;
    END;
    /
    
-- 1.7 Trạng thái nhân viên nhận giá trị “Đã phân công” thì không được phân công ca mới trong cùng khoảng thời gian.
CREATE OR REPLACE TRIGGER trg_check_phan_cong_ca_truc
BEFORE INSERT OR UPDATE ON PHAN_CONG_CA_TRUC
FOR EACH ROW
DECLARE
    v_count NUMBER;  
    v_trang_thai PHAN_CONG_CA_TRUC.TrangThai%TYPE;  -- Sử dụng %TYPE để đảm bảo kiểu dữ liệu đúng
BEGIN
    -- Kiểm tra xem nhân viên đã được phân công ca khác trong cùng khoảng thời gian chưa
    SELECT COUNT(*)
    INTO v_count
    FROM PHAN_CONG_CA_TRUC
    WHERE MaNhanVien = :NEW.MaNhanVien
      AND MaSanBay <> :NEW.MaSanBay
      AND TrangThai = 'Đã phân công'
      AND (ThoiGianKetThuc > :NEW.ThoiGianBatDau AND ThoiGianBatDau < :NEW.ThoiGianKetThuc);

    -- Nếu tìm thấy kết quả trùng lặp, báo lỗi
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20009, 'Nhân viên đã được phân công ca khác trong cùng khoảng thời gian.');
    END IF;
END;
/

/* ============================================ 2. QUẢN LÝ CHUYẾN BAY ================================== */
-- 2.1 Ràng buộc toàn vẹn cho trạng thái của chuyến bay đang chọn (TrangThai) nhận giá trị là “Đang mở” thì mới có thể đặt vé chuyến bay đó.
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


-- 2.2 Ràng buộc toàn vẹn cho thời gian khách hàng có thể đặt vé là trước thời gian cất cánh của chuyến bay (GioCatCanh) 3 giờ.
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


-- 2.3 Ràng buộc toàn vẹn cho tình trạng vé (TrangThaiVe) nhận giá trị “Chưa thanh toán” và số lượng ghế trống của chuyến bay (SoGheTrong) giảm xuống 1 đơn vị sau khi hoàn tất thủ tục đăng ký.

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


-- 2.4 Ràng buộc toàn vẹn cho khách hàng không được đặt vé đang được giữ chỗ/có tình trạng (TrangThaiVe) đã nhận một trong các giá trị (”Chưa thanh toán”, “Đã thanh toán”).

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

-- 2.5 Ràng buộc toàn vẹn cho tình trạng của vé máy bay (TrangThaiVe) nhận một trong các giá trị (”Chưa thanh toán”, “Đã thanh toán”) thì mới có thể hủy/đổi vé.

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


-- 2.6 Ràng buộc toàn vẹn cho vé máy bay chỉ được hủy/đổi chỗ trước ngày cất cánh của chuyến bay (GioCatCanh) 1 ngày.
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

-- 2.7 Ràng buộc toàn vẹn cho tình trạng vé bị hủy/đổi và số lượng ghế trống của chuyến bay (SoGheTrong) tăng lên một đơn vị sau khi hoàn tất thủ tục

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

-- 2.8 Ràng buộc toàn vẹn cho ngày đặt vé phải nằm trong khoảng giữa ngày bắt đầu (NgayBatDau) và ngày kết thúc của voucher/ưu đãi (NgayKetThuc).

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


-- 2.9 Ràng buộc toàn vẹn cho số lượt được dùng mỗi voucher/ưu đãi là một lần trên một vé

ALTER TABLE THANH_TOAN
ADD CONSTRAINT unique_km_mot_lan_cho_mot_ve
UNIQUE (MaVe, MaKhuyenMai);


-- 2.10 Ràng buộc toàn vẹn cho tình trạng vé máy bay nhận giá trị “Chưa thanh toán” thì mới có thể áp dụng voucher/ưu đãi.
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


-- 3.6. Tổng điểm (DiemThuong) chỉ được tính cho chuyến bay nhận giá trị “Đã kết thúc”.
CREATE OR REPLACE TRIGGER TRG_CHUYEN_BAY_TRANGTHAI_DIEMTHUONG
AFTER UPDATE OF TrangThai ON CHUYEN_BAY
FOR EACH ROW
WHEN (
    NEW.TrangThai = 'Đã kết thúc'
    AND (OLD.TrangThai IS NULL OR OLD.TrangThai != 'Đã kết thúc')
)
DECLARE
    CURSOR cur_tt IS
        SELECT kh.MaKhachHang, tt.SoTien, kh.HangThanhVien
        FROM THANH_TOAN tt
        JOIN VE_MAY_BAY ve ON tt.MaVe = ve.MaVe
        JOIN KHACH_HANG kh ON ve.MaKhachHang = kh.MaKhachHang
        WHERE ve.MaChuyenBay = :NEW.MaChuyenBay
          AND tt.TrangThai = 'Thành công';

    v_DiemCong NUMBER;
BEGIN
    FOR rec IN cur_tt LOOP
        CASE rec.HangThanhVien
            WHEN 'Thành viên thường' THEN
                v_DiemCong := (rec.SoTien / 100000) * 2;
            WHEN 'Bạc' THEN
                v_DiemCong := (rec.SoTien / 100000) * 8;
            WHEN 'Vàng' THEN
                v_DiemCong := (rec.SoTien / 100000) * 10;
            WHEN 'Kim cương' THEN
                v_DiemCong := (rec.SoTien / 100000) * 12;
            ELSE
                v_DiemCong := 0;
        END CASE;

        UPDATE KHACH_HANG
        SET DiemThuong = NVL(DiemThuong, 0) + v_DiemCong
        WHERE MaKhachHang = rec.MaKhachHang;
    END LOOP;
END;

-- 3.7. Số lượng chuyến bay quy định tối thiểu để nâng hạng (HangThanhVien):
CREATE OR REPLACE TRIGGER TRG_CAPNHAT_HANG_THANH_VIEN
AFTER INSERT OR DELETE ON CHUYEN_BAY
FOR EACH ROW
DECLARE
    v_so_luong_chuyen_bay NUMBER;
    v_ma_khach_hang VARCHAR2(50);  -- Giả sử MaKhachHang là kiểu VARCHAR2
BEGIN
    -- Xác định MaKhachHang từ bảng VE_MAY_BAY
    IF INSERTING THEN
        SELECT ve.MaKhachHang
        INTO v_ma_khach_hang
        FROM VE_MAY_BAY ve
        WHERE ve.MaChuyenBay = :NEW.MaChuyenBay;
    ELSIF DELETING THEN
        SELECT ve.MaKhachHang
        INTO v_ma_khach_hang
        FROM VE_MAY_BAY ve
        WHERE ve.MaChuyenBay = :OLD.MaChuyenBay;
    END IF;

    -- Đếm số lượng chuyến bay của khách hàng
    SELECT COUNT(*) 
    INTO v_so_luong_chuyen_bay
    FROM CHUYEN_BAY cb
    JOIN VE_MAY_BAY ve ON cb.MaChuyenBay = ve.MaChuyenBay
    WHERE ve.MaKhachHang = v_ma_khach_hang;

    -- Cập nhật hạng thành viên dựa trên số lượng chuyến bay
    IF v_so_luong_chuyen_bay BETWEEN 0 AND 2 THEN
        UPDATE KHACH_HANG
        SET HangThanhVien = 'Thành viên thường'
        WHERE MaKhachHang = v_ma_khach_hang;
    ELSIF v_so_luong_chuyen_bay BETWEEN 4 AND 9 THEN
        UPDATE KHACH_HANG
        SET HangThanhVien = 'Thành viên bạc'
        WHERE MaKhachHang = v_ma_khach_hang;
    ELSIF v_so_luong_chuyen_bay BETWEEN 10 AND 29 THEN
        UPDATE KHACH_HANG
        SET HangThanhVien = 'Thành viên vàng'
        WHERE MaKhachHang = v_ma_khach_hang;
    ELSE
        UPDATE KHACH_HANG
        SET HangThanhVien = 'Thành viên kim cương'
        WHERE MaKhachHang = v_ma_khach_hang;
    END IF;
END;

-- 3.8. Số lượng điểm thưởng (DiemThuong) quy đổi thành voucher/ưu đãi
-- 3.9. Thời gian sử dụng điểm thưởng là 60 ngày kể từ ngày cập nhật.
-- 3.10. Số lần phản hồi của mỗi khách hàng là 1 lần.
CREATE OR REPLACE TRIGGER TRG_PHANHOI_COUNT
BEFORE INSERT ON PHAN_HOI
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Kiểm tra xem khách hàng đã có phản hồi hay chưa
    SELECT COUNT(*)
    INTO v_count
    FROM PHAN_HOI
    WHERE MaKhachHang = :NEW.MaKhachHang;
    
    IF v_count > 0 THEN
        -- Nếu đã có phản hồi từ khách hàng, gây lỗi để không cho phép thêm
        RAISE_APPLICATION_ERROR(-20305, 'Khách hàng chỉ được phép phản hồi một lần.');
    END IF;
END;
/* 3.11. Thời gian gửi đánh giá tối đa là 30 ngày (720h) kể từ ngày kết thúc của chuyến bay đó. 
(Sau thời gian này khách hàng sẽ không được gửi đánh giá đến chuyến bay nữa). */
CREATE OR REPLACE TRIGGER TRG_DANH_GIA_THOIGIAN
BEFORE INSERT ON DANH_GIA
FOR EACH ROW
DECLARE
    v_giohacanh TIMESTAMP;
BEGIN
    -- Lấy thời gian hạ cánh của chuyến bay
    SELECT GioHaCanh
      INTO v_giohacanh
      FROM CHUYEN_BAY
     WHERE MaChuyenBay = :NEW.MaChuyenBay;

    -- Chỉ cho phép đánh giá nếu:
    --   + thời điểm hiện tại (SYSTIMESTAMP) ≥ thời gian hạ cánh
    --   + và ≤ thời gian hạ cánh + 30 ngày
    IF SYSTIMESTAMP < v_giohacanh
       OR SYSTIMESTAMP > v_giohacanh + INTERVAL '30' DAY
    THEN
        RAISE_APPLICATION_ERROR(
           -20306,
           'Đánh giá chỉ được gửi trong vòng 30 ngày kể từ ngày hạ cánh chuyến bay.'
        );
    END IF;
END;

-- 3.12. Tình trạng chuyến bay nhận giá trị “Đã kết thúc” thì mới có thể gửi đánh giá
-- 3.13. Số sao đánh giá nằm trong khoảng giá trị từ 1 đến 5: Đã viết CHECK 
COMMIT;
SAVEPOINT after_3;

/* ================================ QUẢN LÝ CHUYẾN BAY ============================= */
-- 4.1. Sân bay đi (SanBayDi) và sân bay đến (SanBayDen) của chuyến bay mới không được trùng nhau.
ALTER TABLE TUYEN_BAY
ADD CONSTRAINT CHECK_TUYEN_BAY_SANBAYDI_DEN
    CHECK (SanBayDi <> SanBayDen);

-- 4.2. Trạng thái chuyến bay (TrangThai) sau khi thêm vào chỉ nhận giá trị “Đang mở”.
CREATE OR REPLACE TRIGGER TRG_CHUYEN_BAY_INSERT_TRANGTHAI
BEFORE INSERT ON CHUYEN_BAY
FOR EACH ROW
BEGIN
    -- Tự động gán TrangThai thành 'Đang mở' bất kể giá trị đầu vào
    :NEW.TrangThai := 'Đang mở';
END;

-- 4.3. Số lượng ghế còn trống (SoGheTrong) của chuyến bay ≤ số ghế của máy bay.
CREATE OR REPLACE TRIGGER TRG_CHUYEN_BAY_SOGHETRONG
BEFORE INSERT OR UPDATE OF SoGheTrong, MaMayBay ON CHUYEN_BAY
FOR EACH ROW
DECLARE
    v_soghe_maybay   MAY_BAY.SoGhe%TYPE;
BEGIN
    -- Lấy tổng số ghế của máy bay tương ứng
    SELECT SoGhe
      INTO v_soghe_maybay
      FROM MAY_BAY
     WHERE MaMayBay = :NEW.MaMayBay;

    -- Nếu số ghế trống > số ghế máy bay → lỗi
    IF :NEW.SoGheTrong > v_soghe_maybay THEN
        RAISE_APPLICATION_ERROR(
            -20401,
            'Số ghế trống không được vượt quá số ghế của máy bay.'
        );
    END IF;
END;

-- 4.4. Giờ khởi hành của chuyến bay mới (GioCatCanh) phải ≥ thời gian hiện tại 1 tiếng.
CREATE OR REPLACE TRIGGER TRG_CHUYEN_BAY_GIOCATCANH
BEFORE INSERT OR UPDATE OF GioCatCanh ON CHUYEN_BAY
FOR EACH ROW
BEGIN
    -- Yêu cầu: giờ khởi hành tối thiểu phải cách thời điểm hiện tại ít nhất 1 tiếng
    IF :NEW.GioCatCanh < SYSTIMESTAMP + INTERVAL '1' HOUR THEN
        RAISE_APPLICATION_ERROR(
            -20402,
            'Giờ khởi hành phải cách thời điểm hiện tại ít nhất 1 tiếng.'
        );
    END IF;
END;

-- 4.5. Giá vé của chuyến bay (GiaVe) phải không âm (≥0).
ALTER TABLE CHUYEN_BAY
ADD CONSTRAINT CHECK_CHUYEN_BAY_GIAVE
    CHECK (GiaVe >= 0);

-- 4.6. Số lượng ghế trống (SoGheTrong) = 0 thì trạng thái của chuyến bay (TrangThai) sẽ nhận giá trị “Đã đóng”.
CREATE OR REPLACE TRIGGER TRG_CHUYEN_BAY_SET_TRANGTHAI_FULL
BEFORE INSERT OR UPDATE OF SoGheTrong ON CHUYEN_BAY
FOR EACH ROW
BEGIN
    -- Nếu không còn ghế trống thì tự động đặt trạng thái là 'Đã đóng'
    IF :NEW.SoGheTrong = 0 THEN
        :NEW.TrangThai := 'Đã đóng';
    END IF;
END;
-- 4.7. Trạng thái chuyến bay (TrangThai) nhận giá trị “Đang mở” khi số lượng ghế trống (SoGheTrong) ≥ 1.
CREATE OR REPLACE TRIGGER TRG_CHUYEN_BAY_TRANGTHAI_SOGHETRONG
BEFORE INSERT OR UPDATE OF TrangThai, SoGheTrong ON CHUYEN_BAY
FOR EACH ROW
BEGIN
    -- Nếu đang đặt trạng thái 'Đã đóng' nhưng vẫn còn ít nhất 1 ghế trống → lỗi
    IF :NEW.TrangThai = 'Đã đóng'
       AND :NEW.SoGheTrong >= 1
    THEN
        RAISE_APPLICATION_ERROR(
            -20403,
            'Không thể đặt trạng thái ''Đã đóng'' khi vẫn còn ghế trống.'
        );
    END IF;
END;

/* ================================ QUẢN LÝ DỊCH VỤ BỔ SUNG  ============================= */
-- 5.1. Chỉ những vé nhận giá trị “Chưa thanh toán” hoặc “Đã thanh toán” thì mới có thể đăng ký dịch vụ bổ sung.
CREATE OR REPLACE TRIGGER trg_ct_dich_vu_check_trangthai_ve_dangky
BEFORE INSERT OR UPDATE ON CT_DICH_VU
FOR EACH ROW
DECLARE
    v_trang_thai VARCHAR2(50);
BEGIN
    -- Lấy trạng thái vé tương ứng
    SELECT TrangThaiVe INTO v_trang_thai
    FROM VE_MAY_BAY
    WHERE MaVe = :NEW.MaVe;

    -- Kiểm tra trạng thái vé
    IF v_trang_thai NOT IN ('Chưa thanh toán', 'Đã thanh toán') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Chỉ những vé chưa thanh toán hoặc đã thanh toán mới được đăng ký dịch vụ.');
    END IF;
END;
/

-- 5.2. Giá tiền dịch vụ bổ sung (GiaTien) không âm (≥0).
ALTER TABLE DICH_VU_BO_SUNG
ADD CONSTRAINT check_dich_vu_bo_sung_giatien_khong_am
CHECK (GiaTien >= 0);





