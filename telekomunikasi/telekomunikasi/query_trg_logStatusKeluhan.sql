CREATE TABLE logStatusKeluhan (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    status_keluhan_lama VARCHAR(20),
    status_keluhan_baru VARCHAR(20),
    tanggal_perubahan DATE NOT NULL,
	keluhan_id INT NOT NULL
    FOREIGN KEY (keluhan_id) REFERENCES Keluhan(keluhan_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TRIGGER trg_logStatusKeluhan
ON Keluhan
AFTER UPDATE
AS
BEGIN
    DECLARE @keluhan_id INT, @status_keluhan_lama VARCHAR(20), @status_keluhan_baru VARCHAR(20), @tanggal_perubahan DATE;

    SELECT @keluhan_id = keluhan_id, @status_keluhan_baru = status_keluhan
    FROM INSERTED;

    SELECT @status_keluhan_lama = status_keluhan
    FROM DELETED;

    SELECT @tanggal_perubahan = Keluhan.tanggal_keluhan
    FROM Langganan  JOIN Keluhan  ON Keluhan.pelanggan_id = Langganan.pelanggan_id 
    WHERE Keluhan.keluhan_id = @keluhan_id;

    INSERT INTO logStatusKeluhan(status_keluhan_lama, status_keluhan_baru, tanggal_perubahan, keluhan_id)
    VALUES (@status_keluhan_lama, @status_keluhan_baru, @tanggal_perubahan, @keluhan_id);
END;

UPDATE Keluhan
set status_keluhan = 'Selesai'
where keluhan_id = 3

select * from logStatusKeluhan
select * from Keluhan