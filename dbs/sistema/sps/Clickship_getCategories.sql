CREATE OR ALTER PROC dbo.Clickship_getCategories
AS
BEGIN
	SET NOCOUNT ON
	--Selects all types from the 3 servers and groups them to avoid duplicates
	BEGIN TRY
		SELECT tipoProducto FROM TiposProductos
		UNION
		SELECT tipoProducto FROM TiposProductos
		UNION
		SELECT tipoProducto FROM TiposProductos
		GROUP BY tipoProducto;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error seleccionando los tipos de los productos' 'Error';
	END CATCH
END