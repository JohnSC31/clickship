CREATE OR ALTER PROC dbo.Clickship_getEstadosVentas
AS
BEGIN
	SET NOCOUNT ON
	--Selects the sale states from Ventas server
	BEGIN TRY
		SELECT EstadoID, Estado from [25.36.158.76,1400].DepartamentoVentas.dbo.Estados;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los estados de las ventas' 'Error';
	END CATCH
END