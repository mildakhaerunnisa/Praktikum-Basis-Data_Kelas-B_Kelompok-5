CREATE PROC sp_tambahLangganan
	@tanggalMulai DATE,
	@tanggalBerakhir DATE,
	@statusLangganan VARCHAR(20),
	@PelangganID INT,
	@LayananID INT
AS
BEGIN
	IF  @statusLangganan NOT IN ('Aktif', 'Tidak Aktif')
	BEGIN
		RAISERROR ('Status langganan harus "Aktif" atau "Tidak Aktif"', 16, 1);
		RETURN;
	END

	INSERT INTO Langganan (tanggal_mulai,tanggal_berakhir,status_langganan, pelanggan_id, layanan_id)
	VALUES (@tanggalMulai, @tanggalBerakhir, @statusLangganan, @PelangganID, @LayananID)

END

EXEC sp_tambahLangganan
	@tanggalMulai = '2023-08-05',
	@tanggalBerakhir = '2023-09-05',
	@statusLangganan = 'Aktif',
	@PelangganID = 33,
	@LayananID = 3

	select * from Pelanggan
	select * from Langganan
	select * from Tagihan