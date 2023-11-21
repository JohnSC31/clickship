-- Store procedure get one orden by a ordenId
CREATE OR ALTER PROCEDURE Clickship_getOrderById
  @ordenID INT = null
AS
BEGIN
	IF (@ordenID IS NULL)
	BEGIN
		SELECT 'El id de la orden no puede ser nulo' 'Error'
		RETURN;
	END
	BEGIN TRY
	  SELECT o.ordenID, CONCAT(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as [nombreCliente], c.correo, o.fecha, o.costoTotal, o.simbolo, o.nombre as [pais], o.estado, o.EstadoActualID as [estadoID], o.direccion,
	  p.nombre, o.cantidad, o.precioProducto, MAX(o.productoEnEnvio) as productoEnEnvio
	  FROM OPENQUERY([25.36.158.76,1400], 
	  'SELECT o.OrdenID, o.ClienteID, o.fecha, o.costoTotal, p.nombre, o.monedaid, m.simbolo, e.estado, o.EstadoActualID, o.direccion, 
	    po.ProductoID, po.Cantidad, ph.precio*COALESCE(tp.precioCambio, 1) as precioProducto, 
		CASE
			WHEN tr.TrasladoID IS NULL THEN 0
			WHEN CURRENT_TIMESTAMP BETWEEN tr.FechaSalida AND tr.FechaLlegada THEN 1
			ELSE 0
		END as productoEnEnvio
		FROM DepartamentoVentas.dbo.Ordenes o
		INNER JOIN DepartamentoVentas.dbo.Paises p on o.paisID = p.paisID 
		INNER JOIN DepartamentoVentas.dbo.Estados e on o.EstadoActualID = e.EstadoID
		INNER JOIN DepartamentoVentas.dbo.ProductosXOrden po on po.OrdenID = o.OrdenID
		INNER JOIN DepartamentoVentas.dbo.PreciosHistoricos ph on po.PrecioHistoricoID = ph.PrecioHistoricoID
		LEFT JOIN DepartamentoVentas.dbo.TiposDeCambio tp on o.monedaid = tp.monedaid
		INNER JOIN DepartamentoVentas.dbo.Moneda m on m.monedaid = o.monedaid
		LEFT JOIN DepartamentoVentas.dbo.Traslados tr on po.productoID = tr.ProductoID and o.OrdenID = tr.OrdenID') o
		INNER JOIN Clientes c on c.idCliente = o.ClienteID
		INNER JOIN Productos p on o.productoid = p.idProducto AND p.monedaid = o.monedaid
		WHERE o.ordenID = @ordenID
		GROUP BY o.ordenID, CONCAT(c.nombre, ' ', c.apellido1, ' ', c.apellido2), c.correo, o.fecha, o.costoTotal, o.simbolo, o.nombre, o.estado, o.EstadoActualID, o.direccion,
		p.nombre, o.cantidad, o.precioProducto
	END TRY
	BEGIN CATCH 
		SELECT 'Ocurri� un error al seleccionar la orden' 'Error'
	END CATCH
END;