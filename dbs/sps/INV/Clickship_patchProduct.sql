CREATE OR ALTER PROC dbo.Clickship_patchProduct
	@productID INT = NULL,
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
	IF (@productID IS NULL)
	BEGIN
		SELECT 'El id del producto por editar no puede ser nulo' 'Error';
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

		DECLARE @idNorte INT;
		DECLARE @idCaribe INT;
		DECLARE @idSur INT;
		SET @idNorte = (SELECT p.idproducto FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos p WHERE p.idProducto = @productID)
		SET @idCaribe = (SELECT p.idproducto FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos p WHERE p.idProducto = @productID)
		SET @idSur = (SELECT p.idproducto FROM [25.36.158.76,1403].INV_SUR.dbo.Productos p WHERE p.idProducto = @productID)
		DECLARE @date DATETIME = CURRENT_TIMESTAMP

		IF (@cantidadNorte!=0)
		BEGIN
			IF (@idNorte IS NULL)
				EXEC [25.36.158.76,1401].INV_NORTE.dbo.Inv_InsertProduct @productid, @nombre, @cantidadNorte, @descripcion, @peso, @idTipoProducto
			ELSE
				UPDATE [25.36.158.76,1401].INV_NORTE.dbo.Productos SET nombre=@nombre, cantidad=@cantidadNorte, descripcion=@descripcion, peso=@peso, idTipoProducto=@idTipoProducto
				WHERE idProducto = @productID
		END

		IF (@cantidadCaribe!=0)
		BEGIN
			IF (@idCaribe IS NULL)
				EXEC [25.36.158.76,1402].INV_CARIBE.dbo.Inv_InsertProduct @productid, @nombre, @cantidadNorte, @descripcion, @peso, @idTipoProducto
			ELSE
				UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.Productos SET nombre=@nombre, cantidad=@cantidadNorte, descripcion=@descripcion, peso=@peso, idTipoProducto=@idTipoProducto
				WHERE idProducto = @productID
		END

		IF (@cantidadSur!=0)
		BEGIN
			IF (@idSur IS NULL)
				EXEC [25.36.158.76,1403].INV_SUR.dbo.Inv_InsertProduct @productid, @nombre, @cantidadNorte, @descripcion, @peso, @idTipoProducto
			ELSE
				UPDATE [25.36.158.76,1403].INV_SUR.dbo.Productos SET nombre=@nombre, cantidad=@cantidadNorte, descripcion=@descripcion, peso=@peso, idTipoProducto=@idTipoProducto
				WHERE idProducto = @productID
		END

		UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.PreciosHistoricos SET FinalVigencia=@date 
		WHERE ProductoID = @productID AND InicioVigencia = (
			SELECT MAX(InicioVigencia) FROM [25.36.158.76,1400].DepartamentoVentas.dbo.PreciosHistoricos 
			WHERE ProductoID = @productID)
				
		INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.PreciosHistoricos (InicioVigencia, ProductoID, precio, MonedaID)
		VALUES (@date, @productid, @precio, 1);
		
		SELECT @productID 'id';
	END TRY
	BEGIN CATCH
		SELECT CONCAT('Hubo un error al actualizar el producto con id ', @productID) 'Error';
	END CATCH
END;