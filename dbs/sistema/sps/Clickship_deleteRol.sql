CREATE OR ALTER PROCEDURE dbo.Clickship_deleteRol
    @pRol INT = NULL
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
	IF (SELECT COUNT (rolID) FROM [RRHH]...roles WHERE rolID = @pRol) = 0
	BEGIN
		SELECT 'El rol no existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert rol
        DELETE [RRHH]...roles WHERE rolID = @pRol
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END