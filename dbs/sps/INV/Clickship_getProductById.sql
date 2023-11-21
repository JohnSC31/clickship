CREATE OR ALTER PROC dbo.Clickship_getProductoById
	@productID INT = NULL,
	@monedaID INT = NULL
AS
BEGIN
	IF (@productID IS NULL)
	BEGIN
	SELECT 'El id del producto no puede ser nulo' 'Error';
	RETURN;
	END
	SET NOCOUNT ON
	BEGIN TRY
		--Return a result set
		DECLARE @cantidadNorte INT;
		DECLARE @cantidadCaribe INT;
		DECLARE @cantidadSur INT;
		SET @cantidadNorte = COALESCE(
		(SELECT p.cantidad FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos p WHERE p.idProducto = @productID), 0)
		SET @cantidadCaribe = COALESCE(
		(SELECT p.cantidad FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos p WHERE p.idProducto = @productID), 0)
		SET @cantidadSur = COALESCE(
		(SELECT p.cantidad FROM [25.36.158.76,1403].INV_SUR.dbo.Productos p WHERE p.idProducto = @productID), 0)

		SELECT p.idProducto, p.nombre, p.cantidad, p.descripcion, p.peso, p.precio, p.simbolo, p.Monedaid, p.tipoProducto, fp.foto, @cantidadNorte as [cantidadNorte], @cantidadCaribe as [cantidadCaribe], @cantidadSur [cantidadSur], p.idTipoProducto
		FROM Productos p
		LEFT JOIN FotosXProductos fp on p.idProducto = fp.idProducto AND fp.[enabled]=1
		WHERE p.idProducto = @productID AND p.monedaid = COALESCE(@monedaid, 1) AND p.[enabled]=1;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar el producto' 'Error'
	END CATCH
END

