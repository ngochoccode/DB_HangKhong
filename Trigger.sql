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


