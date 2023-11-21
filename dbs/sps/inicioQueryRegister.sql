CREATE OR ALTER PROCEDURE dbo.Clickship_registerClient
    @pLogin NVARCHAR(50) = NULL, 
    @pPassword NVARCHAR(50) = NULL, 
    @pFirstName NVARCHAR(40) = NULL, 
    @pLastName NVARCHAR(40) = NULL,
	@pLastName2 NVARCHAR(40) = NULL, 
    @responseMessage NVARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON

	IF (ISNULL(@pLogin, -1)=-1)
	BEGIN
		SET @responseMessage='El correo no puede ser nulo'
		RETURN
	END
	IF (ISNULL(@pPassword, -1)=-1)
	BEGIN
		SET @responseMessage='La contraseña no puede ser nula'
		RETURN
	END
	IF (ISNULL(@pFirstName, -1)=-1)
	BEGIN
		SET @responseMessage='El nombre no puede ser nulo'
		RETURN
	END
	IF (ISNULL(@pLastName, -1)=-1)
	BEGIN
		SET @responseMessage='El primer apellido no puede ser nulo'
		RETURN
	END
	IF (ISNULL(@pLastName2, -1)=-1)
	BEGIN
		SET @responseMessage='El segundo apellido no puede ser nulo'
		RETURN
	END


    BEGIN TRY

        INSERT INTO dbo.[Clientes] (correo, contrasena, nombre, apellido1, apellido2)
        VALUES(@pLogin, HASHBYTES('SHA2_512', @pPassword), @pFirstName, @pLastName, @pLastName2)

        SET @responseMessage=''

    END TRY
    BEGIN CATCH
        SET @responseMessage=ERROR_MESSAGE() 
    END CATCH

END