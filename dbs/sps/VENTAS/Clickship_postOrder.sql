CREATE OR ALTER PROC dbo.Clickship_postOrder
	@pClienteID INT = NULL,
	@pCostoTotal DECIMAL(18,4) = NULL,
	@pLat DECIMAL(18,14) = NULL,
	@pLon DECIMAL(18,14) = NULL,
	@pDireccion VARCHAR(250) = NULL,
	@pMonedaID INT = NULL
AS
BEGIN
	IF (@pClienteID IS NULL)
	BEGIN
		SELECT 'El cliente no puede ser nulo' 'Error'
		RETURN;
	END
	IF (@pCostoTotal IS NULL OR @pCostoTotal=0)
	BEGIN
		SELECT 'El costo no puede ser nulo o 0' 'Error'
		RETURN;
	END
	IF (@pLat IS NULL OR @pLon IS NULL)
	BEGIN
		SELECT 'La ubicacion no puede ser nula' 'Error'
		RETURN;
	END
	IF (@pDireccion IS NULL OR @pDireccion = '')
	BEGIN
		SELECT 'La direccion no puede ser nula' 'Error'
		RETURN;
	END
	IF (@pMonedaID IS NULL)
	BEGIN
		SELECT 'La moneda no puede ser nula' 'Error'
		RETURN;
	END

	DECLARE @ubicacion GEOGRAPHY;
	SET @ubicacion = GEOGRAPHY::Point(@pLat, @pLon, 4326);

	DECLARE @bodegaMasCercana INT = (SELECT TOP 1 idInventario FROM Inventarios ORDER BY @ubicacion.STDistance(ubicacion) ASC)
	DECLARE @paisBodega INT = (SELECT idPais FROM Inventarios WHERE idInventario = @bodegaMasCercana)

	SET NOCOUNT ON;
	BEGIN TRY
		EXEC [25.36.158.76,1400].DepartamentoVentas.dbo.Clickship_insertUbicacion @pLat, @pLon;
		DECLARE @ubiID INT = (SELECT * FROM OPENQUERY([25.36.158.76,1400],'SELECT MAX(UbicacionID) FROM .DepartamentoVentas.dbo.Ubicaciones'))
		DECLARE @date DATETIME = CURRENT_TIMESTAMP
		INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes 
		(ClienteID, Fecha, CostoTotal, EstadoActualID, PaisID, UbicacionID, Direccion, MonedaID, InventarioID) VALUES 
		(@pClienteID, @date, @pCostoTotal, 2, @paisBodega, @ubiID, @pDireccion, @pMonedaID, @bodegaMasCercana);
		SELECT MAX(OrdenID) AS ordenid FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes;
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() 'Error'
	END CATCH
END;