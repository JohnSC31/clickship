CREATE OR ALTER PROC dbo.Clickship_getLlamadaById
	@llamadaID INT = null
AS
BEGIN
	IF (@llamadaID IS NULL)
	BEGIN
	SELECT 'El id de la llamada no puede ser nulo' 'Error';
	RETURN;
	END;
	SET NOCOUNT ON
	--Selects one call by id
	BEGIN TRY
		SELECT ll.idllamada as [idLlamada], CONCAT(e.nombre, ' ', e.apellidos) as [empleado], ll.fecha_hora as [fecha], CONCAT(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as [cliente], ll.descripcion, tp.descripcion as [tipoPregunta], ll.ordenid as [idOrden], c.correo, o.EstadoActualID, est.Estado
		from [SERVICIO]...llamadas ll
		INNER JOIN [SERVICIO]...tipospregunta tp on ll.idtipopregunta = tp.idtipollamada
		INNER JOIN Clientes c on ll.clienteID = c.idCliente
		INNER JOIN [RRHH]...empleados e on ll.empleadoid = e.empleadoID
		INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes o on o.OrdenID = ll.ordenid
		INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.Estados est on o.EstadoActualID = est.EstadoID
		WHERE ll.idllamada = @llamadaID;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar las llamadas' 'Error'
	END CATCH
END

