-- Khối lệnh để gọi procedure SP_TAO_NHAN_VIEN
DECLARE
    -- Biến để hứng giá trị trả về từ tham số OUT
    v_ma_nv_moi VARCHAR2(10);
BEGIN
    -- Gọi procedure và truyền các giá trị cần thiết
    SP_TAO_NHAN_VIEN(
        p_HoTen        => 'Nguyễn Văn An',
        p_CCCD         => '012345678901',
        p_NgaySinh     => TO_DATE('1995-08-15', 'YYYY-MM-DD'),
        p_GioiTinh     => 'M',
        p_SDT          => '0987654321',
        p_Email        => 'an.nguyen@company.com',
        p_DiaChi       => '123 Đường ABC, Quận 1, TP. HCM',
        p_ChucVu       => 'Quản lý',
        p_LuongCoBan   => 15000000,
        p_PhucLoi      => 'Bảo hiểm đầy đủ, Lương tháng 13',
        p_NgayVaoLam   => SYSTIMESTAMP,
        p_MaNhanVien_OUT => v_ma_nv_moi -- Truyền biến để nhận kết quả
    );
    
    -- Kiểm tra xem mã nhân viên có được tạo thành công không
    IF v_ma_nv_moi IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Procedure đã trả về mã nhân viên mới: ' || v_ma_nv_moi);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Việc tạo nhân viên đã thất bại.');
    END IF;
END;

-- Sau khi chạy, bạn có thể kiểm tra dữ liệu trong bảng
SELECT * FROM NHAN_VIEN;


-- Khối lệnh để gọi procedure SP_XOA_NHAN_VIEN
DECLARE
    v_ma_nv_can_xoa VARCHAR2(10) := 'NV018'; -- Mã nhân viên muốn xóa
    v_ket_qua       NUMBER;
BEGIN
    -- Trường hợp 1: Xóa một nhân viên tồn tại
    DBMS_OUTPUT.PUT_LINE('--- Thử xóa nhân viên ' || v_ma_nv_can_xoa || ' ---');
    SP_XOA_NHAN_VIEN(
        p_MaNhanVien => v_ma_nv_can_xoa,
        p_Status     => v_ket_qua
    );
    DBMS_OUTPUT.PUT_LINE('Kết quả trả về (Status): ' || v_ket_qua);
    
    DBMS_OUTPUT.PUT_LINE(''); -- In dòng trống cho dễ đọc

    -- Trường hợp 2: Xóa một nhân viên không tồn tại
    v_ma_nv_can_xoa := 'NV999'; -- Mã không có trong CSDL
    DBMS_OUTPUT.PUT_LINE('--- Thử xóa nhân viên ' || v_ma_nv_can_xoa || ' ---');
    SP_XOA_NHAN_VIEN(
        p_MaNhanVien => v_ma_nv_can_xoa,
        p_Status     => v_ket_qua
    );
    DBMS_OUTPUT.PUT_LINE('Kết quả trả về (Status): ' || v_ket_qua);
END;

-- Kiểm tra lại dữ liệu trong bảng để xác nhận
SELECT * FROM NHAN_VIEN;


-- Khối lệnh để gọi procedure
DECLARE
    -- Biến để hứng giá trị trả về từ tham số OUT
    v_ma_hk_moi VARCHAR2(10);
BEGIN
    -- Tạo sơ đồ ghế cho chuyến bay CB001
    TAO_SO_DO_GHE('CB001');
    -- Gọi procedure để thêm một hành khách mới
    SP_THEM_HANH_KHACH(
        p_HoTen        => 'Trần Thị Bình',
        p_CCCD         => '098765432109',
        p_NgaySinh     => TO_DATE('2000-02-20', 'YYYY-MM-DD'),
        p_GioiTinh     => 'F',
        p_QuocTich     => 'Việt Nam',
        p_SDT          => '0912345678',
        p_Email        => 'binh.tran@email.com',
        p_MaVe         => 'VECB00137',
        p_HangGhe      => 'Economy', -- Giá trị hợp lệ
        p_GiaTien      => 2500000,
        p_PhiBoSung    => 100000,
        p_ViTriGhe     => '25A',
        p_MaHanhKhach_OUT => v_ma_hk_moi -- Truyền biến để nhận kết quả
    );
    
    -- Kiểm tra kết quả
    IF v_ma_hk_moi IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Procedure đã trả về mã hành khách mới: ' || v_ma_hk_moi);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Việc thêm hành khách đã thất bại.');
    END IF;
END;
/

-- Sau khi chạy, bạn có thể kiểm tra dữ liệu trong bảng


-- Khối lệnh để gọi procedure
DECLARE
    -- Biến để hứng giá trị trả về từ tham số OUT
    v_ma_tt_moi VARCHAR2(15);
BEGIN
    -- Gọi procedure để tạo một thanh toán mới
    SP_TAO_THANH_TOAN(
        p_MaVe          => 'VECB00137',
        p_MaKhuyenMai   => NULL,
        p_SoTien        => 2500000,
        p_PhuongThuc    => 'Chuyển khoản', -- Giá trị hợp lệ
        p_ThoiGianTT    => SYSTIMESTAMP, -- Lấy thời gian hiện tại
        p_TrangThai     => 'Thành công',   -- Giá trị hợp lệ
        p_MaThanhToan_OUT => v_ma_tt_moi -- Truyền biến để nhận kết quả
    );
    
    -- Kiểm tra kết quả
    IF v_ma_tt_moi IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Procedure đã trả về mã thanh toán mới: ' || v_ma_tt_moi);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Việc tạo thanh toán đã thất bại.');
    END IF;
END;
/

-- Sau khi chạy, bạn có thể kiểm tra dữ liệu trong bảng
SELECT * FROM THANH_TOAN;


-- Khối lệnh để gọi procedure
DECLARE
    -- Biến để hứng giá trị trả về từ tham số OUT
    v_ma_bc_moi VARCHAR2(10);
BEGIN
    -- Gọi procedure để tạo một bằng cấp mới
    -- Giả sử nhân viên 'NV001' đã tồn tại trong bảng NHAN_VIEN
    SP_TAO_BANGCAP(
        p_TenBangCap   => 'TOEIC 750',
        p_MaNhanVien   => 'NV001',
        p_ThoiHan      => TO_TIMESTAMP('2025-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'),
        p_TrangThai    => 'Còn hiệu lực',
        p_MaBangCap_OUT => v_ma_bc_moi -- Truyền biến để nhận kết quả
    );
    
    -- Kiểm tra kết quả
    IF v_ma_bc_moi IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Procedure đã trả về mã bằng cấp mới: ' || v_ma_bc_moi);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Việc tạo bằng cấp đã thất bại.');
    END IF;
END;

-- Sau khi chạy, bạn có thể kiểm tra dữ liệu trong bảng
SELECT * FROM BANG_CAP;

SELECT * FROM HANH_KHACH hk;
SELECT * FROM DICH_VU_BO_SUNG dvbs;
INSERT INTO DICH_VU_BO_SUNG VALUES('DV001', 'Suất ăn Jollibee', 200000);

-- Khối lệnh để gọi procedure
DECLARE
    -- Giả sử hành khách 'HK00001' và dịch vụ 'DV001' đã tồn tại trong các bảng tương ứng
    v_ma_hk       VARCHAR2(10) := 'HK00128';
    v_ma_dv       VARCHAR2(10) := 'DV001';
    v_trang_thai  NUMBER;
BEGIN
    -- Trường hợp 1: Thêm mới thành công
    DBMS_OUTPUT.PUT_LINE('--- Lần 1: Thêm dịch vụ ---');
    SP_THEM_CT_DICHVU(
        p_MaHanhKhach   => v_ma_hk,
        p_MaDichVu      => v_ma_dv,
        p_GhiChu        => 'Yêu cầu suất ăn chay.',
        p_Status        => v_trang_thai
    );
    DBMS_OUTPUT.PUT_LINE('Kết quả trạng thái: ' || v_trang_thai);
    
    DBMS_OUTPUT.PUT_LINE(''); -- Dòng trống

    -- Trường hợp 2: Thêm lại bản ghi đã có
    DBMS_OUTPUT.PUT_LINE('--- Lần 2: Thử thêm lại dịch vụ đã có ---');
    SP_THEM_CT_DICHVU(
        p_MaHanhKhach   => v_ma_hk,
        p_MaDichVu      => v_ma_dv,
        p_GhiChu        => 'Cập nhật ghi chú.', -- Sẽ không được thêm
        p_Status        => v_trang_thai
    );
    DBMS_OUTPUT.PUT_LINE('Kết quả trạng thái: ' || v_trang_thai);
END;
/

-- Sau khi chạy, bạn có thể kiểm tra dữ liệu trong bảng
SELECT * FROM CT_DICH_VU;

-- Test SP_INTHONGTINMAYBAY
BEGIN
    SP_INTHONGTINMAYBAY('Airbus');
END;

-- Khối lệnh để gọi procedure
DECLARE
    -- Biến để hứng giá trị trả về từ tham số OUT
    v_ma_ve_moi VARCHAR2(15);
BEGIN
    SP_TAO_VE_MAY_BAY(
        p_MaChuyenBay   => 'CB007',
        p_MaKhachHang   => NULL,
        p_TongTien      => 3200000,
        p_LoaiVe        => 'Vé xác định', -- Giá trị hợp lệ
        p_NgayDatVe     => SYSTIMESTAMP,   -- Lấy thời gian hiện tại
        p_TrangThaiVe   => 'Chưa thanh toán', -- Giá trị hợp lệ
        p_MaVe_OUT      => v_ma_ve_moi     -- Truyền biến để nhận kết quả
    );
    
    -- Kiểm tra kết quả
    IF v_ma_ve_moi IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Procedure đã trả về mã vé mới: ' || v_ma_ve_moi);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Việc tạo vé đã thất bại.');
    END IF;
END;
/

-- Sau khi chạy, bạn có thể kiểm tra dữ liệu trong bảng
SELECT * FROM VE_MAY_BAY;
