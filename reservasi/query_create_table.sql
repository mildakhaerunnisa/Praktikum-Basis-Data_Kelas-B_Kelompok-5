-- 1. Membuat table tipe kamar
CREATE TABLE Tipe_Kamar (
id_tipe INT IDENTITY(1,1) PRIMARY KEY,
nama_tipe VARCHAR (50) NOT NULL,
deskripsi VARCHAR (500) NOT NULL,
kapasitas INT NOT NULL,
harga_per_malam DECIMAL(10,2) NOT NULL,
fasilitas VARCHAR (255) NOT NULL
);

-- 2. Membuat table kamar
CREATE TABLE Kamar (
id_kamar INT IDENTITY (1,1) PRIMARY KEY,
nomor_kamar VARCHAR(10) UNIQUE NOT NULL,
lantai INT,
status VARCHAR (20) DEFAULT 'tersedia' CHECK (STATUS IN ('tersedia', 'ditempati', 'maintenance')),
id_tipe INT
FOREIGN KEY (id_tipe) REFERENCES Tipe_kamar(id_tipe) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 3. Membuat table tamu
CREATE TABLE Tamu (
id_tamu INT IDENTITY (1,1) PRIMARY KEY,
nama_lengkap VARCHAR (100) NOT NULL,
nomor_telepon VARCHAR (15) NOT NULL,
nomor_identitas VARCHAR (20) UNIQUE,
alamat VARCHAR (255),
tanggal_registrasi date
);

-- 4. Membuat table reservasi
CREATE TABLE Reservasi (
id_reservasi INT IDENTITY (1,1) PRIMARY KEY,
tanggal_check_in DATE NOT NULL,
tanggal_check_out DATE NOT NULL,
jumlah_tamu INT NOT NULL,
status_reservasi VARCHAR (20) DEFAULT 'pending' CHECK (status_reservasi IN('pending', 'confirmed', 'checked_in', 'checked_out', 'cancelled')),
total_harga DECIMAL (10,2),
catatan VARCHAR(500),
id_tamu INT,
id_kamar INT,
FOREIGN KEY (id_tamu) REFERENCES Tamu (id_tamu) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (id_kamar) REFERENCES Kamar (id_kamar) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 5. Membuat table layanan tambahan
CREATE TABLE Layanan_Tambahan (
id_layanan INT IDENTITY (1,1) PRIMARY KEY,
nama_layanan VARCHAR (100) NOT NULL,
harga DECIMAL (10,2) NOT NULL,
deskripsi VARCHAR (500)
);

-- 6. Membuat table detail_layanan
CREATE TABLE Detail_Layanan (
id_detail INT IDENTITY (1,1) PRIMARY KEY,
jumlah INT NOT NULL,
total_harga DECIMAL (10,2) NOT NULL,
tanggal_penggunaan DATE,
id_reservasi INT,
id_layanan INT,
FOREIGN KEY (id_reservasi) REFERENCES Reservasi (id_reservasi) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (id_layanan) REFERENCES Layanan_Tambahan (id_layanan) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 7. Membuat table pembayaran
CREATE TABLE Pembayaran (
id_pembayaran INT IDENTITY(1,1) PRIMARY KEY,
nomor_transaksi VARCHAR (50) UNIQUE,
jumlah_pembayaran DECIMAL (10,2) NOT NULL,
metode_pembayaran VARCHAR (20) CHECK (metode_pembayaran IN ('cash', 'credit_card','debit_card', 'transfer')) NOT NULL,
status_pembayaran VARCHAR (20) DEFAULT 'pending' CHECK (status_pembayaran IN ('pending', 'completed', 'refunded')),
tanggal_pembayaran DATE,
id_reservasi INT,
FOREIGN KEY (id_reservasi) REFERENCES Reservasi(id_reservasi) ON UPDATE CASCADE ON DELETE CASCADE
);


