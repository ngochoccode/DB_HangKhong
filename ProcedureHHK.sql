CREATE OR REPLACE PROCEDURE TAO_SO_DO_GHE(p_MaChuyenBay IN VARCHAR2) AS
    v_MaMayBay      VARCHAR2(10);
    v_SoGhe         NUMBER;
    v_GheDaTao      NUMBER := 0;
    v_HangSo        NUMBER := 1;
    v_CotGhe        CHAR(1);
    v_CacCotGhe     SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('A', 'B', 'C', 'D', 'E', 'F');
BEGIN
    -- Lấy mã máy bay từ chuyến bay
    SELECT MaMayBay INTO v_MaMayBay
    FROM CHUYEN_BAY
    WHERE MaChuyenBay = p_MaChuyenBay;

    -- Lấy số ghế từ máy bay
    SELECT SoGhe INTO v_SoGhe
    FROM MAY_BAY
    WHERE MaMayBay = v_MaMayBay;

    -- Xoá ghế cũ (nếu có)
    DELETE FROM CHUYEN_BAY_GHE WHERE MaChuyenBay = p_MaChuyenBay;

    -- Tạo sơ đồ ghế
    WHILE v_GheDaTao < v_SoGhe LOOP
        FOR i IN 1 .. v_CacCotGhe.COUNT LOOP
            EXIT WHEN v_GheDaTao = v_SoGhe;

            v_CotGhe := v_CacCotGhe(i);

            INSERT INTO CHUYEN_BAY_GHE (
                MaChuyenBay,
                ViTriGhe,
                HangGhe,
                TrangThaiGhe
            ) VALUES (
                p_MaChuyenBay,
                TO_CHAR(v_HangSo) || v_CotGhe,
                'Economy',
                N'Trống'
            );

            v_GheDaTao := v_GheDaTao + 1;
        END LOOP;
        v_HangSo := v_HangSo + 1;
    END LOOP;

    COMMIT;
END;

--- Procedure trừ điểm khách hàng
CREATE OR REPLACE PROCEDURE SP_TRU_DIEM_KHACH_HANG (
    p_MaKhachHang IN VARCHAR2,
    p_DiemTru IN NUMBER
) AS
BEGIN
    UPDATE KHACH_HANG
    SET DiemThuong = DiemThuong - p_DiemTru,
        ThoiGianCapNhatDT = SYSTIMESTAMP
    WHERE MaKhachHang = p_MaKhachHang;

END;

---- procedure cập nhật thông tin nhân viên
CREATE OR REPLACE PROCEDURE UpdateNhanVien (
    p_MaNhanVien   IN VARCHAR2,
    p_HoTen        IN NVARCHAR2,
    p_CCCD         IN NVARCHAR2,
    p_NgaySinh     IN DATE,
    p_GioiTinh     IN CHAR,
    p_SDT          IN VARCHAR2,
    p_Email        IN VARCHAR2,
    p_DiaChi       IN NVARCHAR2,
    p_ChucVu       IN NVARCHAR2,
    p_LuongCoBan   IN NUMBER,
    p_PhucLoi      IN NVARCHAR2,
    p_NgayVaoLam   IN TIMESTAMP
) IS
BEGIN
    -- Cập nhật thông tin nhân viên
    UPDATE NHAN_VIEN
    SET
        HoTen       = p_HoTen,
        CCCD        = p_CCCD,
        NgaySinh    = p_NgaySinh,
        GioiTinh    = p_GioiTinh,
        SDT         = p_SDT,
        Email       = p_Email,
        DiaChi      = p_DiaChi,
        ChucVu      = p_ChucVu,
        LuongCoBan  = p_LuongCoBan,
        PhucLoi     = p_PhucLoi,
        NgayVaoLam  = p_NgayVaoLam
    WHERE MaNhanVien = p_MaNhanVien;

    -- Kiểm tra kết quả
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cập nhật thành công nhân viên có mã: ' || p_MaNhanVien);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên có mã: ' || p_MaNhanVien);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Lỗi khi cập nhật nhân viên: ' || SQLERRM);
END;


---- Procedure in danh sách máy bay của 1 hãng 
CREATE OR REPLACE PROCEDURE SP_INTHONGTINMAYBAY(p_HangSanXuat IN NVARCHAR2) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Danh sách máy bay thuộc về hãng: ' || p_HangSanXuat);
    FOR rec IN (
        SELECT MaMayBay, LoaiMayBay, SoGhe, TrangThai, ViTriHienTai
        FROM MAY_BAY
        WHERE HangSanXuat = p_HangSanXuat
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('----- MÁY BAY ' || rec.MaMayBay || ' -----');
        DBMS_OUTPUT.PUT_LINE('** Loại máy bay: ' || rec.LoaiMayBay);
        DBMS_OUTPUT.PUT_LINE('** Số ghế: ' || rec.SoGhe);
        DBMS_OUTPUT.PUT_LINE(''); -- dòng trống phân cách
    END LOOP;

    -- Trường hợp không có máy bay nào
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy máy bay nào của hãng: ' || p_HangSanXuat);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Lỗi khi in thông tin máy bay: ' || SQLERRM);
END;

-- ===================================================================
CREATE OR REPLACE PROCEDURE SP_TAO_NHAN_VIEN (
    -- Tham số đầu vào (IN) - tương ứng với các cột trong bảng
    p_HoTen        IN NHAN_VIEN.HoTen%TYPE,
    p_CCCD         IN NHAN_VIEN.CCCD%TYPE,
    p_NgaySinh     IN NHAN_VIEN.NgaySinh%TYPE,
    p_GioiTinh     IN NHAN_VIEN.GioiTinh%TYPE,
    p_SDT          IN NHAN_VIEN.SDT%TYPE,
    p_Email        IN NHAN_VIEN.Email%TYPE,
    p_DiaChi       IN NHAN_VIEN.DiaChi%TYPE,
    p_ChucVu       IN NHAN_VIEN.ChucVu%TYPE,
    p_LuongCoBan   IN NHAN_VIEN.LuongCoBan%TYPE,
    p_PhucLoi      IN NHAN_VIEN.PhucLoi%TYPE,
    p_NgayVaoLam   IN NHAN_VIEN.NgayVaoLam%TYPE,
    
    -- Tham số đầu ra (OUT) - mã nhân viên mới được tạo
    p_MaNhanVien_OUT OUT NHAN_VIEN.MaNhanVien%TYPE
)
AS
    -- Biến cục bộ để lưu mã nhân viên mới
    v_MaNhanVien NHAN_VIEN.MaNhanVien%TYPE;
BEGIN
    -- Bước 1: Gọi hàm FN_TAO_MANV để sinh mã nhân viên mới và gán vào biến cục bộ
    v_MaNhanVien := FN_TAO_MANV();

    -- Bước 2: Thêm bản ghi mới vào bảng NHAN_VIEN
    INSERT INTO NHAN_VIEN (
        MaNhanVien,
        HoTen,
        CCCD,
        NgaySinh,
        GioiTinh,
        SDT,
        Email,
        DiaChi,
        ChucVu,
        LuongCoBan,
        PhucLoi,
        NgayVaoLam
    )
    VALUES (
        v_MaNhanVien, -- Sử dụng mã vừa được sinh ra
        p_HoTen,
        p_CCCD,
        p_NgaySinh,
        p_GioiTinh,
        p_SDT,
        p_Email,
        p_DiaChi,
        p_ChucVu,
        p_LuongCoBan,
        p_PhucLoi,
        p_NgayVaoLam
    );

    -- Bước 3: Gán mã nhân viên đã tạo vào tham số đầu ra
    p_MaNhanVien_OUT := v_MaNhanVien;

    -- Bước 4: Lưu lại các thay đổi nếu không có lỗi xảy ra
    COMMIT;
    
    -- Thông báo thành công (tùy chọn)
    DBMS_OUTPUT.PUT_LINE('Tạo thành công nhân viên với mã: ' || v_MaNhanVien);

EXCEPTION
    -- Nếu có bất kỳ lỗi nào xảy ra (ví dụ: dữ liệu không hợp lệ, vi phạm ràng buộc)
    WHEN OTHERS THEN
        -- Hoàn tác lại mọi thay đổi
        ROLLBACK;
        
        -- Gán giá trị NULL cho tham số đầu ra để báo hiệu thất bại
        p_MaNhanVien_OUT := NULL;
        
        -- In ra thông báo lỗi để gỡ rối
        DBMS_OUTPUT.PUT_LINE('Lỗi khi tạo nhân viên: ' || SQLERRM);
        
        -- Ném lại lỗi để ứng dụng gọi có thể bắt được
        RAISE;
END SP_TAO_NHAN_VIEN;

CREATE OR REPLACE PROCEDURE SP_XOA_NHAN_VIEN (
    -- Tham số đầu vào: Mã của nhân viên cần xóa
    p_MaNhanVien IN NHAN_VIEN.MaNhanVien%TYPE,
    
    -- Tham số đầu ra (tùy chọn): Báo cáo trạng thái
    -- 1: Thành công, 0: Không tìm thấy, -1: Lỗi
    p_Status OUT NUMBER
)
AS
BEGIN
    -- Thực hiện xóa nhân viên dựa trên mã được cung cấp
    DELETE FROM NHAN_VIEN
    WHERE MaNhanVien = p_MaNhanVien;
    
    -- Kiểm tra xem có dòng nào được xóa không
    IF SQL%ROWCOUNT > 0 THEN
        -- Nếu có, nghĩa là xóa thành công
        DBMS_OUTPUT.PUT_LINE('Đã xóa thành công nhân viên có mã: ' || p_MaNhanVien);
        p_Status := 1; -- Gán trạng thái thành công
        COMMIT; -- Lưu thay đổi
    ELSE
        -- Nếu không, nghĩa là không tìm thấy mã nhân viên
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên có mã: ' || p_MaNhanVien || '. Không có gì được xóa.');
        p_Status := 0; -- Gán trạng thái không tìm thấy
    END IF;

EXCEPTION
    -- Xử lý các lỗi có thể xảy ra (ví dụ: lỗi ràng buộc khóa ngoại)
    WHEN OTHERS THEN
        ROLLBACK; -- Hoàn tác lại mọi thay đổi
        p_Status := -1; -- Gán trạng thái lỗi
        DBMS_OUTPUT.PUT_LINE('Lỗi khi xóa nhân viên: ' || SQLERRM);
        RAISE; -- Ném lại lỗi để ứng dụng gọi có thể bắt được
END SP_XOA_NHAN_VIEN;


CREATE OR REPLACE PROCEDURE SP_THEM_HANH_KHACH (
    -- Tham số đầu vào (IN)
    p_HoTen        IN HANH_KHACH.HoTen%TYPE,
    p_CCCD         IN HANH_KHACH.CCCD%TYPE,
    p_NgaySinh     IN HANH_KHACH.NgaySinh%TYPE,
    p_GioiTinh     IN HANH_KHACH.GioiTinh%TYPE,
    p_QuocTich     IN HANH_KHACH.QuocTich%TYPE,
    p_SDT          IN HANH_KHACH.SDT%TYPE,
    p_Email        IN HANH_KHACH.Email%TYPE,
    p_MaVe         IN HANH_KHACH.MaVe%TYPE,
    p_HangGhe      IN HANH_KHACH.HangGhe%TYPE,
    p_GiaTien      IN HANH_KHACH.GiaTien%TYPE,
    p_PhiBoSung    IN HANH_KHACH.PhiBoSung%TYPE,
    p_ViTriGhe     IN HANH_KHACH.ViTriGhe%TYPE,
    
    -- Tham số đầu ra (OUT) - mã hành khách mới được tạo
    p_MaHanhKhach_OUT OUT HANH_KHACH.MaHanhKhach%TYPE
)
AS
    -- Biến cục bộ để lưu mã hành khách mới
    v_MaHanhKhach HANH_KHACH.MaHanhKhach%TYPE;
BEGIN
    -- Bước 1: Gọi hàm FN_TAO_MAHK để sinh mã hành khách mới
    v_MaHanhKhach := FN_TAO_MAHK();

    -- Bước 2: Thêm bản ghi mới vào bảng HANH_KHACH
    INSERT INTO HANH_KHACH (
        MaHanhKhach,
        HoTen,
        CCCD,
        NgaySinh,
        GioiTinh,
        QuocTich,
        SDT,
        Email,
        MaVe,
        HangGhe,
        GiaTien,
        PhiBoSung,
        ViTriGhe
    )
    VALUES (
        v_MaHanhKhach, -- Sử dụng mã vừa được sinh
        p_HoTen,
        p_CCCD,
        p_NgaySinh,
        p_GioiTinh,
        p_QuocTich,
        p_SDT,
        p_Email,
        p_MaVe,
        p_HangGhe,
        p_GiaTien,
        p_PhiBoSung,
        p_ViTriGhe
    );

    -- Bước 3: Gán mã hành khách đã tạo vào tham số đầu ra
    p_MaHanhKhach_OUT := v_MaHanhKhach;

    -- Bước 4: Lưu lại các thay đổi
    COMMIT;
    
    -- Thông báo thành công (tùy chọn)
    DBMS_OUTPUT.PUT_LINE('Thêm thành công hành khách với mã: ' || v_MaHanhKhach);

EXCEPTION
    -- Xử lý các lỗi có thể xảy ra (ví dụ: vi phạm ràng buộc UNIQUE, CHECK, NOT NULL)
    WHEN OTHERS THEN
        ROLLBACK; -- Hoàn tác lại mọi thay đổi
        
        -- Gán giá trị NULL cho tham số đầu ra để báo hiệu thất bại
        p_MaHanhKhach_OUT := NULL;
        
        -- In ra thông báo lỗi để gỡ rối
        DBMS_OUTPUT.PUT_LINE('Lỗi khi thêm hành khách: ' || SQLERRM);
        
        -- Ném lại lỗi để ứng dụng gọi có thể bắt được
        RAISE;
END SP_THEM_HANH_KHACH;

CREATE OR REPLACE PROCEDURE SP_TAO_THANH_TOAN (
    -- Tham số đầu vào (IN)
    p_MaVe          IN THANH_TOAN.MaVe%TYPE,
    p_MaKhuyenMai   IN THANH_TOAN.MaKhuyenMai%TYPE,
    p_SoTien        IN THANH_TOAN.SoTien%TYPE,
    p_PhuongThuc    IN THANH_TOAN.PhuongThuc%TYPE,
    p_ThoiGianTT    IN THANH_TOAN.ThoiGianTT%TYPE,
    p_TrangThai     IN THANH_TOAN.TrangThai%TYPE,
    
    -- Tham số đầu ra (OUT)
    p_MaThanhToan_OUT OUT THANH_TOAN.MaThanhToan%TYPE
)
AS
    -- Biến cục bộ để lưu mã thanh toán mới
    v_MaThanhToan THANH_TOAN.MaThanhToan%TYPE;
BEGIN
    -- Bước 1: Gọi hàm FN_TAO_MATT để sinh mã thanh toán mới
    v_MaThanhToan := FN_TAO_MATT();

    -- Bước 2: Thêm bản ghi mới vào bảng THANH_TOAN
    INSERT INTO THANH_TOAN (
        MaThanhToan,
        MaVe,
        MaKhuyenMai,
        SoTien,
        PhuongThuc,
        ThoiGianTT,
        TrangThai
    )
    VALUES (
        v_MaThanhToan, -- Sử dụng mã vừa được sinh
        p_MaVe,
        p_MaKhuyenMai,
        p_SoTien,
        p_PhuongThuc,
        p_ThoiGianTT,
        p_TrangThai
    );

    -- Bước 3: Gán mã thanh toán đã tạo vào tham số đầu ra
    p_MaThanhToan_OUT := v_MaThanhToan;

    -- Bước 4: Lưu lại các thay đổi
    COMMIT;
    
    -- Thông báo thành công (tùy chọn)
    DBMS_OUTPUT.PUT_LINE('Tạo thành công thanh toán với mã: ' || v_MaThanhToan);

EXCEPTION
    -- Xử lý các lỗi có thể xảy ra (ví dụ: vi phạm ràng buộc CHECK, NOT NULL)
    WHEN OTHERS THEN
        ROLLBACK; -- Hoàn tác lại mọi thay đổi
        
        -- Gán giá trị NULL cho tham số đầu ra để báo hiệu thất bại
        p_MaThanhToan_OUT := NULL;
        
        -- In ra thông báo lỗi để gỡ rối
        DBMS_OUTPUT.PUT_LINE('Lỗi khi tạo thanh toán: ' || SQLERRM);
        
        -- Ném lại lỗi để ứng dụng gọi có thể bắt được
        RAISE;
END SP_TAO_THANH_TOAN;

CREATE OR REPLACE PROCEDURE SP_TAO_BANGCAP (
    -- Tham số đầu vào (IN)
    p_TenBangCap   IN BANG_CAP.TenBangCap%TYPE,
    p_MaNhanVien   IN BANG_CAP.MaNhanVien%TYPE,
    p_ThoiHan      IN BANG_CAP.ThoiHan%TYPE,
    p_TrangThai    IN BANG_CAP.TrangThai%TYPE,
    
    -- Tham số đầu ra (OUT)
    p_MaBangCap_OUT OUT BANG_CAP.MaBangCap%TYPE
)
AS
    -- Biến cục bộ để lưu mã bằng cấp mới
    v_MaBangCap BANG_CAP.MaBangCap%TYPE;
BEGIN
    -- Bước 1: Gọi hàm FN_TAO_MABC để sinh mã bằng cấp mới
    v_MaBangCap := FN_TAO_MABC();

    -- Bước 2: Thêm bản ghi mới vào bảng BANG_CAP
    INSERT INTO BANG_CAP (
        MaBangCap,
        TenBangCap,
        MaNhanVien,
        ThoiHan,
        TrangThai
    )
    VALUES (
        v_MaBangCap, -- Sử dụng mã vừa được sinh
        p_TenBangCap,
        p_MaNhanVien,
        p_ThoiHan,
        p_TrangThai
    );

    -- Bước 3: Gán mã bằng cấp đã tạo vào tham số đầu ra
    p_MaBangCap_OUT := v_MaBangCap;

    -- Bước 4: Lưu lại các thay đổi
    COMMIT;
    
    -- Thông báo thành công (tùy chọn)
    DBMS_OUTPUT.PUT_LINE('Tạo thành công bằng cấp với mã: ' || v_MaBangCap);

EXCEPTION
    -- Xử lý các lỗi có thể xảy ra
    WHEN OTHERS THEN
        ROLLBACK; -- Hoàn tác lại mọi thay đổi
        
        -- Gán giá trị NULL cho tham số đầu ra để báo hiệu thất bại
        p_MaBangCap_OUT := NULL;
        
        -- In ra thông báo lỗi để gỡ rối
        DBMS_OUTPUT.PUT_LINE('Lỗi khi tạo bằng cấp: ' || SQLERRM);
        
        -- Ném lại lỗi để ứng dụng gọi có thể bắt được
        RAISE;
END SP_TAO_BANGCAP;

CREATE OR REPLACE PROCEDURE SP_THEM_CT_DICHVU (
    -- Tham số đầu vào (IN)
    p_MaHanhKhach   IN CT_DICH_VU.MaHanhKhach%TYPE,
    p_MaDichVu      IN CT_DICH_VU.MaDichVu%TYPE,
    p_GhiChu        IN CT_DICH_VU.GhiChu%TYPE,
    
    -- Tham số đầu ra (OUT) để báo cáo trạng thái
    -- 1: Thành công, 0: Đã tồn tại, -1: Lỗi khác
    p_Status OUT NUMBER
)
AS
BEGIN
    -- Thêm bản ghi mới vào bảng CT_DICH_VU
    INSERT INTO CT_DICH_VU (
        MaHanhKhach,
        MaDichVu,
        GhiChu
    )
    VALUES (
        p_MaHanhKhach,
        p_MaDichVu,
        p_GhiChu
    );

    -- Nếu INSERT thành công, gán trạng thái và COMMIT
    p_Status := 1; -- Thành công
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Thêm thành công dịch vụ ' || p_MaDichVu || ' cho hành khách ' || p_MaHanhKhach || '.');

EXCEPTION
    -- Bắt lỗi nếu cặp (MaHanhKhach, MaDichVu) đã tồn tại (vi phạm khóa chính)
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        p_Status := 0; -- Trạng thái: Đã tồn tại
        DBMS_OUTPUT.PUT_LINE('Lỗi: Hành khách ' || p_MaHanhKhach || ' đã đăng ký dịch vụ ' || p_MaDichVu || ' này rồi.');

    -- Bắt các lỗi khác (ví dụ: MaHanhKhach hoặc MaDichVu không tồn tại nếu có khóa ngoại)
    WHEN OTHERS THEN
        ROLLBACK; -- Hoàn tác lại mọi thay đổi
        p_Status := -1; -- Trạng thái: Lỗi khác
        DBMS_OUTPUT.PUT_LINE('Lỗi khi thêm chi tiết dịch vụ: ' || SQLERRM);
        RAISE;
END SP_THEM_CT_DICHVU;


CREATE OR REPLACE PROCEDURE SP_TAO_VE_MAY_BAY (
    -- Tham số đầu vào (IN)
    p_MaChuyenBay   IN VE_MAY_BAY.MaChuyenBay%TYPE,
    p_MaKhachHang   IN VE_MAY_BAY.MaKhachHang%TYPE,
    p_TongTien      IN VE_MAY_BAY.TongTien%TYPE,
    p_LoaiVe        IN VE_MAY_BAY.LoaiVe%TYPE,
    p_NgayDatVe     IN VE_MAY_BAY.NgayDatVe%TYPE,
    p_TrangThaiVe   IN VE_MAY_BAY.TrangThaiVe%TYPE,
    
    -- Tham số đầu ra (OUT)
    p_MaVe_OUT OUT VE_MAY_BAY.MaVe%TYPE
)
AS
    -- Biến cục bộ để lưu mã vé mới
    v_MaVe VE_MAY_BAY.MaVe%TYPE;
BEGIN
    -- Bước 1: Gọi hàm FN_TAO_MAVE để sinh mã vé mới, truyền vào mã chuyến bay
    v_MaVe := FN_TAO_MAVE(p_MaChuyenBay);

    -- Bước 2: Thêm bản ghi mới vào bảng VE_MAY_BAY
    INSERT INTO VE_MAY_BAY (
        MaVe,
        MaChuyenBay,
        MaKhachHang,
        TongTien,
        LoaiVe,
        NgayDatVe,
        TrangThaiVe
    )
    VALUES (
        v_MaVe, -- Sử dụng mã vé vừa được sinh
        p_MaChuyenBay,
        p_MaKhachHang,
        p_TongTien,
        p_LoaiVe,
        p_NgayDatVe,
        p_TrangThaiVe
    );

    -- Bước 3: Gán mã vé đã tạo vào tham số đầu ra
    p_MaVe_OUT := v_MaVe;

    -- Bước 4: Lưu lại các thay đổi
    COMMIT;
    
    -- Thông báo thành công (tùy chọn)
    DBMS_OUTPUT.PUT_LINE('Tạo thành công vé máy bay với mã: ' || v_MaVe);

EXCEPTION
    -- Xử lý các lỗi có thể xảy ra (ví dụ: vi phạm ràng buộc CHECK, NOT NULL)
    WHEN OTHERS THEN
        ROLLBACK; -- Hoàn tác lại mọi thay đổi
        
        -- Gán giá trị NULL cho tham số đầu ra để báo hiệu thất bại
        p_MaVe_OUT := NULL;
        
        -- In ra thông báo lỗi để gỡ rối
        DBMS_OUTPUT.PUT_LINE('Lỗi khi tạo vé máy bay: ' || SQLERRM);
        
        -- Ném lại lỗi để ứng dụng gọi có thể bắt được
        RAISE;
END SP_TAO_VE_MAY_BAY;
