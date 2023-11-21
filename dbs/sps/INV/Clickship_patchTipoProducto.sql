CREATE OR ALTER PROC dbo.Clickship_patchTipoProducto
	@idTipoProducto INT,
	@tipoProducto VARCHAR(50)=NULL
AS
BEGIN
	IF (@tipoProducto IS NULL OR @tipoProducto='')
	BEGIN
		SELECT 'El tipo de producto nuevo no puede ser nulo' 'Error';
		RETURN;
	END
	IF (@idTipoProducto IS NULL)
	BEGIN
		SELECT 'El tipo de producto por cambiar no puede ser nulo' 'Error';
		RETURN;
	END
	SET NOCOUNT ON;
	BEGIN TRY
		UPDATE [25.36.158.76,1401].INV_NORTE.dbo.TiposProductos SET tipoProducto = @tipoProducto WHERE idTipoProducto=@idTipoProducto;
		UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.TiposProductos SET tipoProducto = @tipoProducto WHERE idTipoProducto=@idTipoProducto;
		UPDATE [25.36.158.76,1403].INV_SUR.dbo.TiposProductos SET tipoProducto = @tipoProducto WHERE idTipoProducto=@idTipoProducto;
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() 'Error'
	END CATCH
END
