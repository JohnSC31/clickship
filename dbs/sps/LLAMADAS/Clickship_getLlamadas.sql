CREATE OR ALTER PROC dbo.Clickship_getLlamadas
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the calls received by costumers
	BEGIN TRY
		SELECT ll.idllamada as [idLlamada], CONCAT(e.nombre, ' ', e.apellidos) as [empleado], ll.fecha_hora as [fecha], CONCAT(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as [cliente], ll.descripcion, tp.descripcion as [tipoPregunta], ll.ordenid as [idOrden] from [SERVICIO]...llamadas ll
		INNER JOIN [SERVICIO]...tipospregunta tp on ll.idtipopregunta = tp.idtipollamada
		INNER JOIN Clientes c on ll.clienteID = c.idCliente
		INNER JOIN [RRHH]...empleados e on ll.empleadoid = e.empleadoID;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar las llamadas' 'Error'
	END CATCH
END

