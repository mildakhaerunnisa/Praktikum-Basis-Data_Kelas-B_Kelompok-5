CREATE PROC sp_tambahPelanggan
	@namaPelanggan VARCHAR(100),
	@emailPelanggan VARCHAR(100),
	@nomorTeleponPelanggan VARCHAR(15),
	@alamat VARCHAR(255),
	@tanggalRegistrasi DATE
AS
BEGIN 
	INSERT INTO Pelanggan (nama_pelanggan, email_pelanggan, nomor_telepon_pelanggan, alamat,tanggal_registrasi)
	VALUES(@namaPelanggan, @emailPelanggan, @nomorTeleponPelanggan, @alamat, @tanggalRegistrasi)
END

EXEC sp_tambahPelanggan
	@namaPelanggan = 'Fauzan',
	@emailPelanggan = 'fauzan@gmail.com',
	@nomorTeleponPelanggan = '082564829568',
	@alamat = 'Jl. Banjaran No 15 Bandung',
	@tanggalRegistrasi = '2023-05-20'
