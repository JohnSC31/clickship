CREATE OR ALTER PROC dbo.Clickship_insertUbicacion
	@pLat DECIMAL(18,14) = NULL,
	@pLon DECIMAL(18,14) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @ubi GEOGRAPHY;
		SET @ubi = GEOGRAPHY::Point(@pLat, @pLon, 4326);
		INSERT INTO Ubicaciones (Ubicacion) VALUES (@ubi);
	END TRY
	BEGIN CATCH
	END CATCH
END;