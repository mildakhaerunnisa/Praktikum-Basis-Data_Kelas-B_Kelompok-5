SELECT * FROM [dbo].[Pelanggan];
SELECT * FROM [dbo].[Karyawan];
SELECT * FROM [dbo].[Infrastruktur_Jaringan];
SELECT * FROM [dbo].[Layanan];
SELECT * FROM [dbo].[Langganan];
SELECT * FROM [dbo].[Tagihan];
SELECT * FROM [dbo].[Pembayaran];
SELECT * FROM [dbo].[Koneksi];
SELECT * FROM [dbo].[Keluhan];

-- 1. Total pendapatan dari pembayaran
CREATE VIEW TotalPendapatan AS
SELECT SUM(jumlah_pembayaran) AS TotalPendapatan
FROM Pembayaran
WHERE status_pembayaran = 'Sukses';

-- 2. Jumlah pelanggan aktif
CREATE VIEW JumlahPelangganAktif AS
SELECT COUNT(*) AS JumlahPelangganAktif
FROM Pelanggan p
JOIN Langganan l ON p.pelanggan_id = l.pelanggan_id
WHERE l.status_langganan = 'Aktif';

-- 3. Total pembayaran yang belum sukses
CREATE VIEW PembayaranBelumSukses AS
SELECT COUNT(jumlah_pembayaran) AS TotalPembayaranBelumSukses
FROM Pembayaran
WHERE status_pembayaran = 'Tertunda' OR status_pembayaran = 'Gagal'

-- 4. Rata-rata biaya layanan bulanan
CREATE VIEW RataBiayaBulanan AS
SELECT AVG(biaya_bulanan) AS RataBiayaBulanan
FROM Layanan;

-- 5. Jumlah layanan yang belum ditangani
CREATE VIEW JumlahKeluhanBelumDitangani AS
SELECT COUNT(*) AS JumlahKeluhanBelumDitangani
FROM Keluhan
WHERE status_keluhan = 'Belum Ditangani';

-- 6. Daftar Pelanggan dan layanan yang digunakan
CREATE VIEW PelangganLayanan AS
SELECT p.nama_pelanggan, l.nama_layanan
FROM Pelanggan p
JOIN Langganan lg ON p.pelanggan_id = lg.pelanggan_id
JOIN Layanan l ON lg.layanan_id = l.layanan_id;

-- 7. Keluhan dan Karyawan yang Menangani
CREATE VIEW KeluhanKaryawan AS
SELECT k.deskripsi_keluhan, kr.nama_karyawan
FROM Keluhan k
JOIN Karyawan kr ON k.karyawan_id = kr.karyawan_id;

-- 8. Tagihan dan Status Pembayaran
CREATE VIEW TagihanStatusPembayaran AS
SELECT t.tagihan_id, t.jumlah_tagihan, p.status_pembayaran
FROM Tagihan t
JOIN Pembayaran p ON t.tagihan_id = p.tagihan_id;

-- 9. Layanan dan Perangkat yang Digunakan
CREATE VIEW LayananPerangkat AS
SELECT l.nama_layanan, ij.nama_perangkat
FROM Layanan l
JOIN Infrastruktur_Jaringan ij ON l.perangkat_id = ij.perangkat_id;

-- 10. Daftar pelanggan dan koneksi aktif
CREATE VIEW PelangganKoneksi AS
SELECT p.nama_pelanggan, k.tipe_koneksi, k.bandwith
FROM Pelanggan p
JOIN Koneksi k ON p.pelanggan_id = k.pelanggan_id
WHERE k.status_koneksi = 'Aktif';

-- 11. Daftar semua pelanggan
CREATE VIEW DaftarPelanggan AS
SELECT pelanggan_id, nama_pelanggan, email_pelanggan, nomor_telepon_pelanggan
FROM Pelanggan;

-- 12. Layanan dengan biaya bulanan di atas Rp1.000.000
CREATE VIEW LayananMahal AS
SELECT layanan_id, nama_layanan, biaya_bulanan
FROM Layanan
WHERE biaya_bulanan > 1000000;

-- 13. Infrastruktur Jaringan yang Sedang Pemeliharaan
CREATE VIEW InfrastrukturPemeliharaan AS
SELECT perangkat_id, nama_perangkat, lokasi, status_infrastruktur
FROM Infrastruktur_Jaringan
WHERE status_infrastruktur = 'Pemeliharaan';

-- 14. Daftar pelanggan tidak aktif
CREATE VIEW PelangganTidakAktif AS
SELECT p.pelanggan_id, p.nama_pelanggan, l.status_langganan
FROM Pelanggan p
JOIN Langganan l ON p.pelanggan_id = l.pelanggan_id
WHERE l.status_langganan = 'Tidak Aktif';

-- 15. Riwayat Pembayaran Pelanggan
CREATE VIEW RiwayatPembayaran AS
SELECT p.nama_pelanggan, b.tanggal_pembayaran, b.jumlah_pembayaran, b.metode_pembayaran
FROM Pembayaran b
JOIN Tagihan t ON b.tagihan_id = t.tagihan_id
JOIN Langganan l ON t.langganan_id = l.langganan_id
JOIN Pelanggan p ON l.pelanggan_id = p.pelanggan_id;

SELECT * FROM TotalPendapatan
SELECT * FROM JumlahPelangganAktif
SELECT * FROM PembayaranBelumSukses
SELECT * FROM RataBiayaBulanan
SELECT * FROM JumlahKeluhanBelumDitangani
SELECT * FROM PelangganLayanan
SELECT * FROM KeluhanKaryawan
SELECT * FROM TagihanStatusPembayaran
SELECT * FROM LayananPerangkat
SELECT * FROM PelangganKoneksi
SELECT * FROM DaftarPelanggan
SELECT * FROM LayananMahal
SELECT * FROM InfrastrukturPemeliharaan
SELECT * FROM PelangganTidakAktif
SELECT * FROM RiwayatPembayaran
