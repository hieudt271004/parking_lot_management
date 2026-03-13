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