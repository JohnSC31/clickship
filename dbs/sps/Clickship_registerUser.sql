CREATE OR ALTER PROCEDURE dbo.Clickship_registerClient
    @pLogin NVARCHAR(50) = NULL, 
    @pPassword NVARCHAR(50) = NULL, 
    @pFirstName NVARCHAR(40) = NULL, 
    @pLastName NVARCHAR(40) = NULL,
	@pLastName2 NVARCHAR(40) = NULL
AS
BEGIN
    SET NOCOUNT ON

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
	IF (ISNULL(@pFirstName, '')='')
	BEGIN
		SELECT 'El nombre no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pLastName, '')='')
	BEGIN
		SELECT 'El primer apellido no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pLastName2, '')='')
	BEGIN
		SELECT 'El segundo apellido no puede ser nulo' 'Error';
		RETURN
	END

	-- Validate if the email is not in use
	DECLARE @existentClient INT
	SET @existentClient = (SELECT idCliente FROM Clientes WHERE correo = @pLogin)
	IF (ISNULL(@existentClient, -1)!=-1)
	BEGIN
		SELECT 'El correo electronico ya está en uso' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert user into system
        INSERT INTO dbo.[Clientes] (correo, contrasena, nombre, apellido1, apellido2)
        VALUES(@pLogin, HASHBYTES('SHA2_512', @pPassword), @pFirstName, @pLastName, @pLastName2)
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH

END