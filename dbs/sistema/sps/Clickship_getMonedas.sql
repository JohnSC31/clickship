CREATE OR ALTER PROC dbo.Clickship_getMonedas
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the currencies in the system
	BEGIN TRY
		SELECT monedaID, nombre, acronimo, simbolo from [RRHH]...monedas;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar las monedas' 'Error';
	END CATCH
END