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

-- 1.3. Nhân viên phi công/tiếp viên chỉ được phân công cho một máy bay tại một thời điểm.
CREATE OR REPLACE TRIGGER TRG_CHECK_PHAN_CONG
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

-- 1.4. Chỉ phân công cho phi công/tiếp viên khi chuyến bay có trạng thái “Đang mở”.
CREATE OR REPLACE TRIGGER trg_check_chuyen_bay_status
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

-- 1.5. Trạng thái nhân viên nhận giá trị “Đã phân công” thì không được phân công ca mới trong cùng khoảng thời gian.
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

/* ============================================ 2. QUẢN LÝ VÉ MÁY BAY ================================== */
-- 2.1 Ràng buộc toàn vẹn cho trạng thái của chuyến bay đang chọn (TrangThai) nhận giá trị là “Đang mở” hoặc "Hoãn" thì mới có thể đặt vé chuyến bay đó.
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










