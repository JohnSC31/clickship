CREATE OR ALTER PROCEDURE dbo.Clickship_editRol
    @pRol INT = NULL,
    @pNewRol VARCHAR(40) = NULL
AS
BEGIN
	-- Validate none of the params are null
	IF (@pRol IS NULL)
	BEGIN
		SELECT 'El rol no puede ser nulo' 'Error';
		RETURN
	END

    IF (ISNULL(@pNewRol, '')='')
	BEGIN
		SELECT 'El nuevo rol no puede ser nulo' 'Error';
		RETURN
	END

    -- Validate if the rol exists 
	IF (SELECT COUNT (rolID) FROM [RRHH]...roles WHERE rolID = @pRol) = 0
	BEGIN
		SELECT 'El rol no existe' 'Error';
		RETURN
	END
	SET NOCOUNT ON
    BEGIN TRY
		--Update rol
		DECLARE @query NVARCHAR(90) = CONCAT('CALL updateRol(', @pRol, ', "', @pNewRol, '")')
		EXEC(@query) AT [RRHH]
		SELECT '' 'Error'
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END
