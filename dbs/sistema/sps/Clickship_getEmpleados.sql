CREATE OR ALTER PROC dbo.Clickship_getEmpleados
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the employees in the system
	BEGIN TRY
		SELECT e.empleadoID, e.nombre, e.apellidos, e.correo, r.rol, d.nombre as departamento, p.nombre as pais FROM [RRHH]...empleados e
		INNER JOIN [RRHH]...roles r on e.rolID = r.rolID
		INNER JOIN [RRHH]...departamentos d on e.departamentoID = d.departamentoID
		INNER JOIN [RRHH]...paises p on e.paisID = p.paisID;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los empleados' 'Error'
	END CATCH
END