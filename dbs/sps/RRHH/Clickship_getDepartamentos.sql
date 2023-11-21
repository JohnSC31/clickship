CREATE OR ALTER PROC dbo.Clickship_getDepartamentos
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the employee departments in the system
	BEGIN TRY
		SELECT departamentoID, nombre from [RRHH]...departamentos;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los departamentos' 'Error'
	END CATCH
END