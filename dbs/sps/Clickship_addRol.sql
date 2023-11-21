CREATE OR ALTER PROCEDURE dbo.Clickship_addRol
    @pRol VARCHAR(40) = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pRol, '')='')
	BEGIN
		SELECT 'El rol no puede ser nulo' 'Error';
		RETURN
	END

    -- Validate if the rol exists 
	IF (SELECT COUNT (rolID) FROM [RRHH]...roles WHERE rol = @pRol) != 0
	BEGIN
		SELECT 'El rol ya existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert rol
        INSERT INTO [RRHH]...roles (rol)
        VALUES (@pRol)
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END