CREATE OR ALTER PROCEDURE dbo.Clickship_getHistorialEmpleado
    @pEmpleado INT = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pEmpleado, -1)=-1)
	BEGIN
		SELECT 'El empleado no puede ser nulo' 'Error';
		RETURN
	END

	-- Validate if the employee already exists
	IF (SELECT COUNT (empleadoID) FROM [RRHH]...empleados WHERE empleadoID = @pEmpleado) = 0
	BEGIN
		SELECT 'El empleado no existe' 'Error';
		RETURN
	END

    BEGIN TRY
		SELECT sl.fecha, sl.montoNeto, sl.horasTrabajadas, sl.monedaID, m.simbolo FROM [RRHH]...salarioslogs as sl
        INNER JOIN [RRHH]...monedas as m ON m.monedaID = sl.monedaID
        WHERE  sl.empleadoID = @pEmpleado

        SELECT '' 'Error'
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END