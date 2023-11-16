CREATE OR ALTER PROC dbo.Clickship_getProductos
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the products from all 3 servers
	BEGIN TRY
		
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar las llamadas' 'Error'
	END CATCH
END

