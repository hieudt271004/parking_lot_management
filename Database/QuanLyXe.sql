USE master
GO

IF DB_ID('QL_BAIGUIXE') IS NOT NULL
DROP DATABASE QL_BAIGUIXE
GO

CREATE DATABASE QL_BAIGUIXE
GO

USE QL_BAIGUIXE
GO


-----------------------------
-- DROP TABLE
-----------------------------
DROP TABLE IF EXISTS ChiTietHoaDonMuaVe
DROP TABLE IF EXISTS HoaDonMuaVe
DROP TABLE IF EXISTS ChiTietRaVao
DROP TABLE IF EXISTS KhachVangLai
DROP TABLE IF EXISTS c_Ve
DROP TABLE IF EXISTS LoaiVe
DROP TABLE IF EXISTS KhachHang
DROP TABLE IF EXISTS NhanVien
DROP TABLE IF EXISTS Xe
DROP TABLE IF EXISTS NguoiDung
GO


-----------------------------
-- TABLE NGUOIDUNG
-----------------------------
CREATE TABLE NguoiDung(
MaND varchar(5) PRIMARY KEY,
Email varchar(32) NOT NULL,
MatKhau varchar(64) NOT NULL,
HoTen varchar(50),
GioiTinh varchar(3),
NgSinh datetime,
DiaChi varchar(256),
QueQuan varchar(256),
SDT varchar(10),
VaiTro varchar(20),

CONSTRAINT check_GioiTinh CHECK (GioiTinh IN ('Nam','Nu')),
CONSTRAINT check_VaiTro CHECK (VaiTro IN ('Khach hang','Nhan vien'))
)
GO


-----------------------------
-- TABLE XE
-----------------------------
CREATE TABLE Xe(
MaXe varchar(5) PRIMARY KEY,
BienSoXe varchar(30),
TenLoaiXe varchar(20),

CONSTRAINT check_TenLoaiXe CHECK (TenLoaiXe IN ('Xe dap','Xe may'))
)
GO


-----------------------------
-- TABLE NHANVIEN
-----------------------------
CREATE TABLE NhanVien(
MaNV varchar(5) PRIMARY KEY,
ViTriNhanVien varchar(30),

CONSTRAINT check_ViTriNhanVien CHECK (ViTriNhanVien IN ('Quan ly','Bao ve')),

FOREIGN KEY (MaNV) REFERENCES NguoiDung(MaND)
)
GO


-----------------------------
-- TABLE KHACHHANG
-----------------------------
CREATE TABLE KhachHang(
MaKH varchar(5) PRIMARY KEY,
MaXe varchar(5),
SoDu decimal(18,2),

FOREIGN KEY (MaKH) REFERENCES NguoiDung(MaND),
FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
)
GO


-----------------------------
-- TABLE LOAIVE
-----------------------------
CREATE TABLE LoaiVe(
MaLoaiVe varchar(5) PRIMARY KEY,
TenLoaiVe varchar(30),
GiaVe decimal(18,2)
)
GO


-----------------------------
-- TABLE VE
-----------------------------
CREATE TABLE c_Ve(
MaVe varchar(5) PRIMARY KEY,
MaLoaiVe varchar(5),
MaKH varchar(5),
NgayKichHoat datetime,
NgayHetHan datetime,
TrangThai varchar(30),

CONSTRAINT check_TrangThai CHECK (TrangThai IN
('Chua kich hoat','Dang su dung','Da het han')),

FOREIGN KEY (MaLoaiVe) REFERENCES LoaiVe(MaLoaiVe),
FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
)
GO


-----------------------------
-- TABLE KHACHVANGLAI
-----------------------------
CREATE TABLE KhachVangLai(
MaTheKVL varchar(5) PRIMARY KEY,
MaXe varchar(5),

FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
)
GO


-----------------------------
-- TABLE CHITIETRAVAO
-----------------------------
CREATE TABLE ChiTietRaVao(
MaCTRaVao varchar(5) PRIMARY KEY,
ThoiGianVao datetime,
ThoiGianRa datetime,
MaKH varchar(5),
MaXe varchar(5),
MaTheKVL varchar(5),

FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
FOREIGN KEY (MaXe) REFERENCES Xe(MaXe),
FOREIGN KEY (MaTheKVL) REFERENCES KhachVangLai(MaTheKVL)
)
GO


-----------------------------
-- TABLE HOADONMUAVE
-----------------------------
CREATE TABLE HoaDonMuaVe(
MaHD varchar(5) PRIMARY KEY,
MaKH varchar(5),
NgayHD datetime,
TongTriGia decimal(18,2),

FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
)
GO


-----------------------------
-- TABLE CHITIETHOADON
-----------------------------
CREATE TABLE ChiTietHoaDonMuaVe(
MaHD varchar(5),
MaLoaiVe varchar(5),
SoLuongVe int,

PRIMARY KEY(MaHD,MaLoaiVe),

FOREIGN KEY (MaHD) REFERENCES HoaDonMuaVe(MaHD),
FOREIGN KEY (MaLoaiVe) REFERENCES LoaiVe(MaLoaiVe)
)
GO


---------------------------------
-- TRIGGER CHECK SODU
---------------------------------
CREATE TRIGGER Check_SoDu_trigger
ON KhachHang
AFTER INSERT, UPDATE
AS
BEGIN

IF EXISTS (SELECT * FROM inserted WHERE SoDu < 0)
BEGIN
    RAISERROR ('So du phai >= 0',16,1)
    ROLLBACK TRANSACTION
END

END
GO


---------------------------------
-- TRIGGER CHECK GIAVE
---------------------------------
CREATE TRIGGER Check_GiaVe_trigger
ON LoaiVe
AFTER INSERT, UPDATE
AS
BEGIN

IF EXISTS (SELECT * FROM inserted WHERE GiaVe < 0)
BEGIN
    RAISERROR ('Gia ve phai >= 0',16,1)
    ROLLBACK TRANSACTION
END

END
GO


---------------------------------
-- TRIGGER CHECK NGAYHETHAN
---------------------------------
CREATE TRIGGER Check_NgayHetHan_trigger
ON c_Ve
AFTER INSERT, UPDATE
AS
BEGIN

IF EXISTS (
SELECT * FROM inserted
WHERE NgayHetHan < NgayKichHoat
)

BEGIN
    RAISERROR ('Ngay het han phai lon hon ngay kich hoat',16,1)
    ROLLBACK TRANSACTION
END

END
GO

-----------------------------
-- SAMPLE DATA
-----------------------------

-- 1. NguoiDung
INSERT INTO NguoiDung VALUES ('ND001','admin@parking.com','admin123','Nguyen Van An','Nam','1990-01-01','123 Le Loi, Q1','Ha Noi','0901234567','Nhan vien')
INSERT INTO NguoiDung VALUES ('ND002','nv01@parking.com','nv123456','Tran Thi Bich','Nu','1992-05-12','456 Tran Hung Dao, Q5','HCM','0912345678','Nhan vien')
INSERT INTO NguoiDung VALUES ('ND003','nv02@parking.com','nv123456','Le Van Cuong','Nam','1988-09-20','789 Nguyen Trai, Q1','Da Nang','0923456789','Nhan vien')
INSERT INTO NguoiDung VALUES ('ND004','kh01@gmail.com','kh123456','Pham Thi Dung','Nu','1995-03-15','101 Bach Dang, Q3','HCM','0934567890','Khach hang')
INSERT INTO NguoiDung VALUES ('ND005','kh02@gmail.com','kh123456','Hoang Van Em','Nam','1998-07-22','202 Hoang Van Thu, Q10','HCM','0945678901','Khach hang')
GO

-- 2. Xe
INSERT INTO Xe VALUES ('X0001','59A-12345','Xe may')
INSERT INTO Xe VALUES ('X0002','51F-67890','Xe may')
INSERT INTO Xe VALUES ('X0003','29B-11111','Xe dap')
INSERT INTO Xe VALUES ('X0004','30D-22222','Xe dap')
INSERT INTO Xe VALUES ('X0005','79C-33333','Xe may')
GO

-- 3. NhanVien
INSERT INTO NhanVien VALUES ('ND001','Quan ly')
INSERT INTO NhanVien VALUES ('ND002','Bao ve')
INSERT INTO NhanVien VALUES ('ND003','Bao ve')
GO

-- 4. KhachHang
INSERT INTO KhachHang VALUES ('ND004','X0001',500000)
INSERT INTO KhachHang VALUES ('ND005','X0002',300000)
GO

-- 5. LoaiVe
INSERT INTO LoaiVe VALUES ('LV001','Ve thang xe may',100000)
INSERT INTO LoaiVe VALUES ('LV002','Ve thang xe dap',50000)
INSERT INTO LoaiVe VALUES ('LV003','Ve quy xe may',270000)
GO

-- 6. KhachVangLai
INSERT INTO KhachVangLai VALUES ('KVL01','X0003')
INSERT INTO KhachVangLai VALUES ('KVL02','X0004')
INSERT INTO KhachVangLai VALUES ('KVL03','X0005')
GO

-- 7. c_Ve
INSERT INTO c_Ve VALUES ('V0001','LV001','ND004','2026-01-01','2026-01-31','Dang su dung')
INSERT INTO c_Ve VALUES ('V0002','LV002','ND005','2026-02-01','2026-02-28','Da het han')
GO

-- 8. ChiTietRaVao
INSERT INTO ChiTietRaVao VALUES ('CT001','2026-03-01 08:00','2026-03-01 17:30','ND004','X0001',NULL)
INSERT INTO ChiTietRaVao VALUES ('CT002','2026-03-10 09:15','2026-03-10 11:45',NULL,'X0003','KVL01')
INSERT INTO ChiTietRaVao VALUES ('CT003','2026-03-15 07:00','2026-03-15 18:00','ND005','X0002',NULL)
INSERT INTO ChiTietRaVao VALUES ('CT004','2026-03-18 08:30',NULL,NULL,'X0004','KVL02')
GO

-- 9. HoaDonMuaVe
INSERT INTO HoaDonMuaVe VALUES ('HD001','ND004','2026-01-01',100000)
INSERT INTO HoaDonMuaVe VALUES ('HD002','ND005','2026-02-01',50000)
GO

-- 10. ChiTietHoaDonMuaVe
INSERT INTO ChiTietHoaDonMuaVe VALUES ('HD001','LV001',1)
INSERT INTO ChiTietHoaDonMuaVe VALUES ('HD002','LV002',1)
GO

PRINT 'Database QL_BAIGUIXE da duoc tao va insert du lieu mau thanh cong!'
