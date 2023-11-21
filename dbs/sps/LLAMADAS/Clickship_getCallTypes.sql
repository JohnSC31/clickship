CREATE OR ALTER PROC dbo.Clickship_getCallTypes
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the employee departments in the system
	BEGIN TRY
		SELECT idtipollamada, descripcion from [SERVICIO]...tipospregunta;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los departamentos' 'Error'
	END CATCH
END