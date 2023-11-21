CREATE OR ALTER PROC dbo.Clickship_postCambioEstado
	@ordenID INT = NULL,
	@estadoID INT = NULL
AS
BEGIN
	IF (@ordenID IS NULL)
	BEGIN
		SELECT 'El id de la orden por cambiar no puede ser nula' 'Error';
		RETURN;
	END;
	IF (@estadoID IS NULL)
	BEGIN
		SELECT 'El nuevo estado de la orden no puede ser nulo' 'Error';
		RETURN;
	END;

SET NOCOUNT ON;
	BEGIN TRY
		UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes SET EstadoActualID = @estadoID WHERE OrdenID=@estadoID;
		DECLARE @date DATETIME = CURRENT_TIMESTAMP
		INSERT INTO BitacoraOrdenes (OrdenID, EstadoID, Fecha) VALUES (@ordenID, @estadoID, @date);
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() 'Error'
	END CATCH
END;