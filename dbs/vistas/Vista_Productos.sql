CREATE OR ALTER VIEW Productos AS
SELECT ap.idProducto, ap.nombre, SUM(COALESCE(ap.cantidad, 0)) as [cantidad], ap.descripcion, ap.peso, tp.tipoProducto, tp.idTipoProducto, dfp.idDefaultFoto, pp.precio, pp.simbolo, pp.Monedaid, ap.[enabled]
FROM (
	SELECT  n.idProducto, n.nombre, n.cantidad, n.descripcion, n.peso, n.idTipoProducto, n.[enabled]
	FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos n
	UNION ALL
	SELECT c.idProducto, c.nombre, c.cantidad, c.descripcion, c.peso, c.idTipoProducto, c.[enabled]
	FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos c
	UNION ALL
	SELECT s.idProducto, s.nombre, s.cantidad, s.descripcion, s.peso, s.idTipoProducto, s.[enabled]
	FROM [25.36.158.76,1403].INV_SUR.dbo.Productos s
) AS ap
LEFT JOIN DefaultFotosXProductos dfp on ap.idProducto = dfp.idProducto
INNER JOIN TiposProductos tp on ap.idTipoProducto = tp.idTipoProducto
LEFT JOIN PreciosProductos pp on pp.idProducto = ap.idProducto AND CURRENT_TIMESTAMP BETWEEN pp.inicioVigencia AND COALESCE(pp.finalVigencia, CURRENT_TIMESTAMP)
GROUP BY ap.idProducto, ap.nombre, ap.descripcion, ap.peso, tp.tipoProducto, tp.idTipoProducto, dfp.idDefaultFoto, pp.precio, pp.simbolo, pp.monedaid, ap.[enabled];