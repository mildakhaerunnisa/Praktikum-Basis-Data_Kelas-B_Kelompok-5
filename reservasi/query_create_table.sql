CREATE DATABASE Reservasi;

USE Reservasi;

-- 1. Membuat tabel Tipe_Kamar
CREATE TABLE Tipe_Kamar (
    id_tipe INT IDENTITY(1,1) PRIMARY KEY,
    nama_tipe VARCHAR(50) NOT NULL,
    deskripsi VARCHAR(500),
    kapasitas INT NOT NULL,
    harga_per_malam DECIMAL(10,2) NOT NULL,
    fasilitas VARCHAR(255)
);

-- 2. Membuat tabel Kamar
CREATE TABLE Kamar (
    id_kamar INT IDENTITY(1,1) PRIMARY KEY,
    nomor_kamar VARCHAR(10) UNIQUE NOT NULL,
    id_tipe INT,
    lantai INT,
    status VARCHAR(20) DEFAULT 'tersedia' CHECK (status IN ('tersedia', 'ditempati', 'pembersihan', 'maintenance')),
    FOREIGN KEY (id_tipe) REFERENCES Tipe_Kamar(id_tipe)
);

-- 3. Membuat tabel Tamu
CREATE TABLE Tamu (
    id_tamu INT IDENTITY(1,1) PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    nomor_telepon VARCHAR(15),
    nomor_identitas VARCHAR(20) UNIQUE,
    alamat VARCHAR(255),
    tanggal_registrasi DATE
);

-- 4. Membuat tabel Reservasi
CREATE TABLE Reservasi (
    id_reservasi INT IDENTITY(1,1) PRIMARY KEY,
    id_tamu INT,
    id_kamar INT,
    tanggal_check_in DATE NOT NULL,
    tanggal_check_out DATE NOT NULL,
    jumlah_tamu INT NOT NULL,
    status_reservasi VARCHAR(20) DEFAULT 'pending' CHECK (status_reservasi IN ('pending', 'confirmed', 'checked_in', 'checked_out', 'cancelled')),
    total_harga DECIMAL(10,2),
    catatan VARCHAR(500),
    FOREIGN KEY (id_tamu) REFERENCES Tamu(id_tamu),
    FOREIGN KEY (id_kamar) REFERENCES Kamar(id_kamar)
);

-- 5. Membuat tabel Pembayaran
CREATE TABLE Pembayaran (
    id_pembayaran INT IDENTITY(1,1) PRIMARY KEY,
    id_reservasi INT,
    jumlah_pembayaran DECIMAL(10,2) NOT NULL,
    metode_pembayaran VARCHAR(20) CHECK (metode_pembayaran IN ('cash', 'credit_card', 'debit_card', 'transfer')) NOT NULL,
    status_pembayaran VARCHAR(20) DEFAULT 'pending' CHECK (status_pembayaran IN ('pending', 'completed', 'refunded')),
    tanggal_pembayaran DATE,
    nomor_transaksi VARCHAR(50) UNIQUE,
    FOREIGN KEY (id_reservasi) REFERENCES Reservasi(id_reservasi)
);

-- 6. Membuat tabel Layanan_Tambahan
CREATE TABLE Layanan_Tambahan (
    id_layanan INT IDENTITY(1,1) PRIMARY KEY,
    nama_layanan VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    deskripsi VARCHAR(500)
);

-- 7. Membuat tabel Detail_Layanan
CREATE TABLE Detail_Layanan (
    id_detail INT IDENTITY(1,1) PRIMARY KEY,
    id_reservasi INT,
    id_layanan INT,
    jumlah INT NOT NULL,
    total_harga DECIMAL(10,2) NOT NULL,
    tanggal_penggunaan DATE,
    FOREIGN KEY (id_reservasi) REFERENCES Reservasi(id_reservasi),
    FOREIGN KEY (id_layanan) REFERENCES Layanan_Tambahan(id_layanan)
);

