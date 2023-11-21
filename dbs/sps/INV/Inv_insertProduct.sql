CREATE OR ALTER PROCEDURE Inv_InsertProduct
	@id INT = NULL,
	@nombre NCHAR(120) = NULL,
	@cantidad INT = NULL,
	@descripcion NVARCHAR(250) = NULL,
	@peso DECIMAL(6,2) = NULL,
	@idTipoProducto SMALLINT = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SET IDENTITY_INSERT dbo.Productos ON
			INSERT INTO dbo.Productos (idProducto, nombre, cantidad, descripcion, peso, idTipoProducto)
			VALUES (@id, @nombre, @cantidad, @descripcion, @peso, @idTipoProducto)
	SET IDENTITY_INSERT dbo.Productos OFF
END