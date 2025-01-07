CREATE PROC sp_hapusPelanggan
	@pelangganID INT
AS
BEGIN
	BEGIN TRANSACTION

    BEGIN TRY
        DELETE FROM Pembayaran
        WHERE tagihan_id IN (SELECT tagihan_id FROM Tagihan WHERE langganan_id IN (SELECT langganan_id FROM Langganan WHERE pelanggan_id = @pelangganID));

        DELETE FROM Tagihan
        WHERE langganan_id IN (SELECT langganan_id FROM Langganan WHERE pelanggan_id = @pelangganID);

        DELETE FROM Langganan
        WHERE pelanggan_id = @pelangganID;

        DELETE FROM Keluhan
        WHERE pelanggan_id = @pelangganID;

        DELETE FROM Pelanggan
        WHERE pelanggan_id = @pelangganID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END

EXEC sp_hapusPelanggan @pelangganID = 33