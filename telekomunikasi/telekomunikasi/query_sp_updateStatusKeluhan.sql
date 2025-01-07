CREATE PROC sp_updateStatusKeluhan
	@KeluhanID INT,
	@statusKeluhan VARCHAR(20)
AS
BEGIN
	IF @statusKeluhan NOT IN ('Belum Ditangani', 'Sedang Diproses', 'Selesai')
	BEGIN
		RAISERROR ('Status keluhan tidak valid', 16, 1)
		RETURN
	END

	UPDATE Keluhan
	SET status_keluhan = @statusKeluhan
	WHERE keluhan_id = @KeluhanID

	PRINT('Status Keluhan berhasil diperbarui')
END

EXEC sp_updateStatusKeluhan
	@keluhanID = 1,
	@statusKeluhan = 'Selesai'
