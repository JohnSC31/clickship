CREATE OR ALTER PROC dbo.Clickship_getPaises
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the names of the countries in the system
	BEGIN TRY
		SELECT paisID, nombre from [RRHH]...paises;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los paises' 'Error'
	END CATCH
END