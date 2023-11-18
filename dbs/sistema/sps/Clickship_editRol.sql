CREATE OR ALTER PROCEDURE dbo.Clickship_editRol
    @pRol INT = NULL,
    @pNewRol VARCHAR(40) = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pRol, -1)=-1)
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

    BEGIN TRY
		--Update rol
        UPDATE [RRHH]...roles SET rol = @pNewRol WHERE rolID = @pRol
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END