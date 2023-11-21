CREATE OR ALTER PROCEDURE dbo.Clickship_deleteProducto
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
		UPDATE [25.36.158.76,1401].INV_NORTE.dbo.Productos SET [enabled]=0 WHERE idProducto = @productID;
		UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.Productos SET [enabled]=0 WHERE idProducto = @productID;
		UPDATE [25.36.158.76,1403].INV_SUR.dbo.Productos SET [enabled]=0 WHERE idProducto = @productID;
		UPDATE FotosXProductos SET [enabled]=0 WHERE idProducto= @productID;
		DELETE FROM DefaultFotosXProductos WHERE idProducto = @productID;
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		SELECT 'No se pudo eliminar el producto con exito' 'Error';
	END CATCH
END;