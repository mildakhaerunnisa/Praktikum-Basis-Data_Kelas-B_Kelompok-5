CREATE DATABASE telekomunikasi
USE telekomunikasi
-- Tabel Pelanggan
CREATE TABLE Pelanggan (
    pelanggan_id INT IDENTITY(1,1) PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email_pelanggan VARCHAR(100) UNIQUE NOT NULL,
    nomor_telepon_pelanggan VARCHAR(15) UNIQUE NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    tanggal_registrasi DATE NOT NULL
);

-- Tabel Karyawan
CREATE TABLE Karyawan (
    karyawan_id INT IDENTITY(1,1) PRIMARY KEY,
    nama_karyawan VARCHAR(100) NOT NULL,
    email_karyawan VARCHAR(100) UNIQUE NOT NULL,
    nomor_telepon_karyawan VARCHAR(15) UNIQUE NOT NULL,
    jabatan VARCHAR(50) NOT NULL
);

-- Tabel Infrastruktur_Jaringan
CREATE TABLE Infrastruktur_Jaringan (
    perangkat_id INT IDENTITY(1,1) PRIMARY KEY,
    nama_perangkat VARCHAR(100) NOT NULL,
    tipe_perangkat VARCHAR(50) NOT NULL CHECK (tipe_perangkat IN ('Router', 'Switch', 'Modem', 'Firewall', 'Server')),
    alamat_ip VARCHAR(15) NOT NULL UNIQUE,
    lokasi VARCHAR(100),
    status_infrastruktur VARCHAR(20) DEFAULT 'Aktif' CHECK (status_infrastruktur IN ('Aktif', 'Tidak Aktif', 'Pemeliharaan')),
    tanggal_instalasi DATE NOT NULL
);

-- Tabel Layanan
CREATE TABLE Layanan (
    layanan_id INT IDENTITY(1,1) PRIMARY KEY,
    nama_layanan VARCHAR(50) NOT NULL,
    deskripsi_layanan VARCHAR(255),
    biaya_bulanan DECIMAL(10,2) NOT NULL,
	karyawan_id INT,
	FOREIGN KEY (karyawan_id) REFERENCES Karyawan(karyawan_id) ON UPDATE CASCADE ON DELETE CASCADE,
	perangkat_id INT,
	FOREIGN KEY (perangkat_id) REFERENCES Infrastruktur_Jaringan(perangkat_id) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabel Langganan
CREATE TABLE Langganan (
    langganan_id INT IDENTITY(1,1) PRIMARY KEY,
    tanggal_mulai DATE NOT NULL,
    tanggal_berakhir DATE NOT NULL,
    status_langganan VARCHAR(20) NOT NULL DEFAULT 'Aktif' CHECK (status_langganan IN ('Aktif', 'Tidak Aktif')),
	pelanggan_id INT NOT NULL
    FOREIGN KEY (pelanggan_id) REFERENCES Pelanggan(pelanggan_id) ON UPDATE CASCADE ON DELETE CASCADE,
	layanan_id INT
    FOREIGN KEY (layanan_id) REFERENCES Layanan(layanan_id) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabel Tagihan
CREATE TABLE Tagihan (
    tagihan_id INT IDENTITY(1,1) PRIMARY KEY,
    tanggal_tagihan DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    jumlah_tagihan DECIMAL(10,2) NOT NULL,
    langganan_id INT,  
    FOREIGN KEY (langganan_id) REFERENCES Langganan(langganan_id) ON UPDATE CASCADE ON DELETE CASCADE,
);

-- Tabel Pembayaran
CREATE TABLE Pembayaran (
    pembayaran_id INT IDENTITY(1,1) PRIMARY KEY,
    tanggal_pembayaran DATE NOT NULL,
    metode_pembayaran VARCHAR(50) NOT NULL CHECK (metode_pembayaran IN ('Tunai', 'Kartu Kredit', 'Transfer Bank', 'Dompet Digital')),
    jumlah_pembayaran DECIMAL(10,2) NOT NULL,
    status_pembayaran VARCHAR(20) NOT NULL DEFAULT 'Tertunda' CHECK (status_pembayaran IN ('Sukses', 'Gagal', 'Tertunda')),
	tagihan_id INT
    FOREIGN KEY (tagihan_id) REFERENCES Tagihan(tagihan_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel Koneksi
CREATE TABLE Koneksi (
	koneksi_id INT IDENTITY(1,1) PRIMARY KEY,
	tipe_koneksi VARCHAR(255)NOT NULL,
	bandwith DECIMAL(10,2) NOT NULL,
	status_koneksi VARCHAR(20) NOT NULL DEFAULT 'Aktif' CHECK (status_koneksi IN ('Aktif', 'Tidak Aktif', 'Pemeliharaan')),
	pelanggan_id INT
	FOREIGN KEY (pelanggan_id) REFERENCES Pelanggan(pelanggan_id) ON UPDATE CASCADE ON DELETE CASCADE,
	perangkat_id INT
	FOREIGN KEY (perangkat_id) REFERENCES Infrastruktur_Jaringan(perangkat_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel Keluhan
CREATE TABLE Keluhan (
    keluhan_id INT IDENTITY(1,1) PRIMARY KEY,
    tanggal_keluhan DATE NOT NULL,
    deskripsi_keluhan VARCHAR(255),
    status_keluhan VARCHAR(20) NOT NULL DEFAULT 'Belum Ditangani' CHECK (status_keluhan IN ('Belum Ditangani', 'Sedang Diproses', 'Selesai')),
	pelanggan_id INT
	FOREIGN KEY (pelanggan_id) REFERENCES Pelanggan(pelanggan_id) ON UPDATE CASCADE ON DELETE CASCADE,
	karyawan_id INT,
    FOREIGN KEY (karyawan_id) REFERENCES Karyawan(karyawan_id) ON UPDATE CASCADE ON DELETE CASCADE
);

SELECT * FROM Pelanggan