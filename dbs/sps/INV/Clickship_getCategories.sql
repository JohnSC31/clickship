CREATE OR ALTER PROC dbo.Clickship_getCategories
AS
BEGIN
	SET NOCOUNT ON
	--Selects all types from the 3 servers
	BEGIN TRY
		SELECT * FROM TiposProductos WHERE [enabled]=1;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error seleccionando los tipos de los productos' 'Error';
	END CATCH
END