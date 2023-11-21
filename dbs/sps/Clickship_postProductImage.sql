CREATE OR ALTER PROC dbo.Clickship_postProductImage
	@productoID INT = NULL,
	@imagen VARCHAR(MAX) = NULL
AS
BEGIN
	IF (@productoID IS NULL)
	BEGIN
		SELECT 'El id del producto no puede ser nulo' 'Error'
		RETURN;
	END
	IF (@imagen IS NULL)
	BEGIN
		SELECT 'No se puede insertar una imagen nula' 'Error'
		RETURN;
	END

	DECLARE @defaultImageID INT;
	SET @defaultImageID = (SELECT idDefaultFoto FROM DefaultFotosXProductos WHERE idProducto = @productoID)

	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @decodedImage VARBINARY(MAX);
		SELECT @decodedImage = CAST(N'' AS XML).value('xs:base64Binary(sql:variable("@imagen"))', 'VARBINARY(MAX)')
		IF (@defaultImageID IS NULL)
		BEGIN	
			INSERT INTO FotosXProductos (idProducto, foto, isDefault) VALUES (@productoID, @decodedImage, 0)
			INSERT INTO DefaultFotosXProductos SELECT idFoto as idDefaultFoto, idProducto FROM FotosXProductos WHERE idProducto = @productoID;
		END
		ELSE
			INSERT INTO FotosXProductos (idProducto, foto, isDefault) VALUES (@productoID, @decodedImage, 0)
		SELECT '' 'Error';
	END TRY
	BEGIN CATCH
		SELECT CONCAT('Hubo un error al insertar la imagen ', ERROR_MESSAGE()) 'Error';
	END CATCH

END