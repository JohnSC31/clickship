CREATE OR ALTER PROC dbo.Clickship_getVentas
AS
BEGIN
	SET NOCOUNT ON
	--Selects all orders
	BEGIN TRY
		SELECT o.ordenID, CONCAT(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as [nombreCliente], o.fecha, o.costoTotal, m.simbolo , o.nombre as [pais], o.estado FROM OPENQUERY([25.36.158.76,1400], 'SELECT o.OrdenID, o.ClienteID, o.fecha, o.costoTotal, p.nombre, o.monedaid, e.estado FROM DepartamentoVentas.dbo.Ordenes o
		INNER JOIN DepartamentoVentas.dbo.Paises p on o.paisID = p.paisID INNER JOIN DepartamentoVentas.dbo.Estados e on o.EstadoActualID = e.EstadoID') o
		INNER JOIN Clientes c on c.idCliente = o.ClienteID
		INNER JOIN [RRHH]...Monedas m on m.MonedaID = o.monedaid
		ORDER BY o.fecha DESC;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error seleccionando las ventas de los productos' 'Error';
	END CATCH
END