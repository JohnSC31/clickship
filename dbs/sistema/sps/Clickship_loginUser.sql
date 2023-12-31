CREATE OR ALTER PROCEDURE dbo.Clickship_loginClient
    @pLogin NVARCHAR(50) = NULL, 
    @pPassword NVARCHAR(50) = NULL, 
    @responseMessage NVARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON
	BEGIN TRY
		-- Validate none of the params are null
		IF (ISNULL(@pLogin, '')='')
		BEGIN
			SET @responseMessage='El correo no puede ser nulo'
			RETURN
		END
		IF (ISNULL(@pPassword, '')='')
		BEGIN
			SET @responseMessage='La contraseņa no puede ser nula'
			RETURN
		END

		DECLARE @idClient INT
		SET @idClient = (SELECT idCliente FROM Clientes WHERE correo = @pLogin AND contrasena = HASHBYTES('SHA2_512', @pPassword))
		IF(ISNULL(@idClient, -1)=-1)
		BEGIN
			SET @responseMessage='El correo o la contrasenna son incorrectos'
			RETURN
		END
		ELSE
		BEGIN
			SELECT idCliente, nombre, apellido1, apellido2, correo FROM Clientes WHERE idCliente = @idClient
			RETURN;
		END
    END TRY
    BEGIN CATCH
        SET @responseMessage=ERROR_MESSAGE() 
    END CATCH

END