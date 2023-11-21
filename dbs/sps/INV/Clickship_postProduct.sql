CREATE OR ALTER PROC dbo.Clickship_postProduct
	@nombre NCHAR(120) = NULL,
	@cantidadNorte INT = NULL,
	@cantidadCaribe INT = NULL,
	@cantidadSur INT = NULL,
	@descripcion NVARCHAR(250) = NULL,
	@peso DECIMAL(6,2) = NULL,
	@idTipoProducto SMALLINT = NULL,
	@precio DECIMAL(18,4) = NULL
AS
BEGIN
	IF (@cantidadNorte=0 OR @cantidadCaribe=0 OR @cantidadSur=0)
	BEGIN
		SELECT 'No se puede ingresar un producto sin existencias' 'Error'
		RETURN;
	END
	IF (@cantidadNorte IS NULL OR @cantidadCaribe IS NULL OR @cantidadSur IS NULL)
	BEGIN
		SELECT 'Ninguna de las cantidades puede ser nula' 'Error'
		RETURN;
	END
	IF (@cantidadNorte < 0 OR @cantidadCaribe < 0 OR @cantidadSur < 0)
	BEGIN
		SELECT 'Ninguna de las cantidades puede ser menor a 0' 'Error'
		RETURN;
	END
	IF (@nombre IS NULL)
	BEGIN
		SELECT 'El nombre no puede ser nulo' 'Error'
		RETURN;
	END
	IF (@descripcion IS NULL)
	BEGIN
		SELECT 'La descripcion no puede ser nula' 'Error'
		RETURN;
	END
	IF (@peso IS NULL)
	BEGIN
		SELECT 'El peso no puede ser nulo' 'Error'
		RETURN;
	END
	IF (@idTipoProducto IS NULL)
	BEGIN
		SELECT 'El tipo de producto no puede ser nulo' 'Error'
		RETURN;
	END
	IF (@precio IS NULL OR @precio=0)
	BEGIN
		SELECT 'El precio no puede ser nulo' 'Error'
		RETURN;
	END

	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @id INT = (SELECT MAX(idProducto)+1 FROM Productos)
		DECLARE @date DATETIME = CURRENT_TIMESTAMP
		IF (@cantidadNorte > 0)
			EXEC [25.36.158.76,1401].INV_NORTE.dbo.Inv_InsertProduct @id, @nombre, @cantidadNorte, @descripcion, @peso, @idTipoProducto
		IF (@cantidadCaribe > 0)
			EXEC [25.36.158.76,1402].INV_CARIBE.dbo.Inv_InsertProduct @id, @nombre, @cantidadCaribe, @descripcion, @peso, @idTipoProducto
		IF (@cantidadSur > 0)
			EXEC [25.36.158.76,1403].INV_SUR.dbo.Inv_InsertProduct @id, @nombre, @cantidadSur, @descripcion, @peso, @idTipoProducto
		INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.PreciosHistoricos (InicioVigencia, ProductoID, precio, MonedaID)
		VALUES (@date, @id, @precio, 1);
		SELECT @id 'productoID';
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() 'Error';
	END CATCH
END