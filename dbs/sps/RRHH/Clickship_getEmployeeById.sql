-- Store procedure get one employee
CREATE OR ALTER PROCEDURE Clickship_getEmployeeById
  @empleadoID INT
AS
BEGIN
	BEGIN TRY
	  SELECT TOP(1) * FROM OPENQUERY([RRHH], '
	  SELECT e.empleadoID, e.nombre, e.apellidos, e.correo, r.rol, d.nombre as departamento, s.salario, m.simbolo FROM Empleados e
	  INNER JOIN Roles r on e.rolID = r.rolID
	  INNER JOIN Departamentos d on e.departamentoID = d.departamentoID
	  INNER JOIN SalariosLogs s on s.empleadoID = e.empleadoID
	  INNER JOIN Monedas m on s.monedaID = m.monedaID
	  ORDER BY s.inicioVigencia DESC') as e
	  WHERE e.empleadoID = @empleadoID;

  END TRY
	BEGIN CATCH 
		SELECT 'Ocurri� un error al seleccionar el empleado' 'Error'
	END CATCH
END;
