CREATE OR ALTER PROC dbo.Clickship_deleteTipoProducto
	@idTipoProducto INT
AS
BEGIN
	IF (@idTipoProducto IS NULL)
	BEGIN
		SELECT 'El tipo de producto por eliminar no puede ser nulo' 'Error';
		RETURN;
	END
	SET NOCOUNT ON;
	BEGIN TRY
		UPDATE [25.36.158.76,1401].INV_NORTE.dbo.TiposProductos SET [enabled] = 0 WHERE idTipoProducto=@idTipoProducto;
		UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.TiposProductos SET [enabled] = 0 WHERE idTipoProducto=@idTipoProducto;
		UPDATE [25.36.158.76,1403].INV_SUR.dbo.TiposProductos SET [enabled] = 0 WHERE idTipoProducto=@idTipoProducto;
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() 'Error'
	END CATCH
END
