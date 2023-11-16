CREATE OR ALTER PROCEDURE dbo.Clickship_loginClient
    @pLogin NVARCHAR(50) = NULL, 
    @pPassword NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON
	BEGIN TRY
		-- Validate none of the params are null
		IF (ISNULL(@pLogin, '')='')
		BEGIN
			SELECT 'El correo no puede ser nulo' 'Error';
			RETURN
		END
		IF (ISNULL(@pPassword, '')='')
		BEGIN
			SELECT 'La contraseña no puede ser nula' 'Error';
			RETURN
		END

		DECLARE @idClient INT
		SET @idClient = (SELECT idCliente FROM Clientes WHERE correo = @pLogin AND contrasena = HASHBYTES('SHA2_512', @pPassword))
		IF(ISNULL(@idClient, -1)=-1)
		BEGIN
			SELECT 'El correo o la contraseña son incorrectos' 'Error';
			RETURN
		END
		ELSE
		BEGIN
			SELECT idCliente, nombre, apellido1, apellido2, correo FROM Clientes WHERE idCliente = @idClient
			RETURN;
		END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error';
    END CATCH

END