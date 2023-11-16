CREATE OR ALTER PROC dbo.Clickship_getRoles
AS
BEGIN
	SET NOCOUNT ON
	--Selects all employee roles from rrhh server
	BEGIN TRY
		SELECT rolID, rol from [RRHH]...roles;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al consultar todos los roles' 'Error';
	END CATCH
END