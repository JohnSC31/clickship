-- Store procedure get all orders from a client
CREATE OR ALTER PROCEDURE Clickship_getClientOrders
  @clienteID INT = null
AS
IF (@clienteID IS NULL)
BEGIN
	SELECT 'El id de la orden no puede ser nulo'
	RETURN;
END
BEGIN
	BEGIN TRY
	  SELECT o.ordenID, CONCAT(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as [nombreCliente], o.fecha, o.costoTotal, m.simbolo, o.nombre as [pais], o.estado, o.direccion, o.ubicacion  
	  FROM OPENQUERY([25.36.158.76,1400], 
		'SELECT o.OrdenID, o.ClienteID, o.fecha, o.costoTotal, p.nombre, o.monedaid, e.estado, U.ubicacion, o.direccion 
		FROM DepartamentoVentas.dbo.Ordenes o
		INNER JOIN DepartamentoVentas.dbo.Paises p on o.paisID = p.paisID 
		INNER JOIN DepartamentoVentas.dbo.Estados e on o.EstadoActualID = e.EstadoID
		INNER JOIN DepartamentoVentas.dbo.Ubicaciones u on u.UbicacionID = o.UbicacionID') o
		INNER JOIN Clientes c on c.idCliente = o.ClienteID
		INNER JOIN [RRHH]...Monedas m on m.MonedaID = o.monedaid
		WHERE c.idCliente=@clienteID;
  END TRY
	BEGIN CATCH 
		SELECT 'Ocurri� un error al seleccionar la orden' 'Error'
	END CATCH
END;