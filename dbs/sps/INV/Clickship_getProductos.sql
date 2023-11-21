CREATE OR ALTER PROC dbo.Clickship_getProductos
	@nombre VARCHAR(250) = null,
	@categoria INT = null,
	@monedaid INT = null
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the products from all 3 servers
	BEGIN TRY
		SELECT p.idProducto, p.nombre, p.cantidad, p.descripcion, p.peso, p.precio, p.simbolo, p.monedaid, p.tipoProducto, fp.foto FROM Productos p
		LEFT JOIN FotosXProductos fp on p.idDefaultFoto = fp.idFoto
		WHERE (@nombre IS NULL OR p.nombre=@nombre) AND (@categoria IS NULL OR p.idTipoProducto=@categoria) AND p.monedaid = COALESCE(@monedaid, 1) AND p.[enabled]=1;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los productos' 'Error'
	END CATCH
END

