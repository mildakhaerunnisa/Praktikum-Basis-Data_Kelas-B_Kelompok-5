CREATE TRIGGER trg_tambahTagihan
ON Langganan
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Tagihan (tanggal_tagihan, tanggal_jatuh_tempo, jumlah_tagihan, langganan_id)
	SELECT inserted.tanggal_mulai, DATEADD(DAY, 30, inserted.tanggal_mulai), Layanan.biaya_bulanan, inserted.langganan_id
	FROM inserted join Layanan ON inserted.layanan_id = Layanan.layanan_id
END

EXEC sp_tambahLangganan
	@tanggalMulai = '2023-05-20',
	@tanggalBerakhir = '2023-06-20',
	@statusLangganan = 'Aktif',
	@pelangganID = 32,
	@layananID = 10