CREATE OR ALTER PROCEDURE dbo.Clickship_deleteFotosProducto
	@productID INT = NULL
AS
BEGIN
	IF (@productID IS NULL)
	BEGIN
		SELECT 'El id del producto no puede ser nulo' 'Error';
		RETURN;
	END

	SET NOCOUNT ON;
	BEGIN TRY
		UPDATE FotosXProductos SET [enabled]=0 WHERE idProducto= @productID;
		DELETE FROM DefaultFotosXProductos WHERE idProducto = @productID;
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		SELECT 'No se pudo eliminar el producto con exito' 'Error';
	END CATCH
END;