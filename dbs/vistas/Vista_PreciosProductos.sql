CREATE OR ALTER VIEW PreciosProductos AS
SELECT ap.idProducto, ph.precio*(COALESCE(tp.precioCambio, 1)) as precio, m.simbolo, m.monedaid, ph.inicioVigencia, ph.finalVigencia
FROM (
	SELECT  n.idProducto
	FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos n
	UNION ALL
	SELECT c.idProducto
	FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos c
	UNION ALL
	SELECT s.idProducto
	FROM [25.36.158.76,1403].INV_SUR.dbo.Productos s
) AS ap
INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.PreciosHistoricos ph on ph.ProductoID = ap.idProducto
RIGHT JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.Moneda m on 1=1
LEFT JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.TiposDeCambio tp on m.MonedaID = tp.MonedaID 
GROUP BY ap.idProducto, ph.precio, tp.precioCambio, m.simbolo, m.monedaid, ph.inicioVigencia, ph.finalVigencia;