CREATE OR ALTER PROC dbo.Clickship_postTipoProducto
	@tipoProducto VARCHAR(50)=NULL
AS
BEGIN
	IF (@tipoProducto IS NULL OR @tipoProducto='')
	BEGIN
		SELECT 'El tipo de producto no puede ser nulo' 'Error';
		RETURN;
	END
	SET NOCOUNT ON;
	BEGIN TRY
		INSERT INTO [25.36.158.76,1401].INV_NORTE.dbo.TiposProductos (tipoProducto) VALUES (@tipoProducto);
		INSERT INTO [25.36.158.76,1402].INV_CARIBE.dbo.TiposProductos (tipoProducto) VALUES (@tipoProducto);
		INSERT INTO [25.36.158.76,1403].INV_SUR.dbo.TiposProductos (tipoProducto) VALUES (@tipoProducto);
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() 'Error'
	END CATCH
END
