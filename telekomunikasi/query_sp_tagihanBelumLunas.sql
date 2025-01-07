CREATE PROC sp_TagihanBelumLunas
AS
BEGIN
	SELECT Tagihan.tagihan_id,Tagihan.tanggal_tagihan,Tagihan.tanggal_jatuh_tempo,Tagihan.jumlah_tagihan,Langganan.pelanggan_id,Pelanggan.nama_pelanggan,Tagihan.
	FROM Tagihan JOIN Langganan ON Tagihan.tagihan_id = Langganan.langganan_id
	JOIN Pelanggan ON Langganan.pelanggan_id = Pelanggan.pelanggan_id
	WHERE Tagihan.jumlah_tagihan >0
END

EXEC sp_TagihanBelumLunas