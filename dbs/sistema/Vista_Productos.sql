CREATE OR ALTER VIEW Productos AS
SELECT ap.idProducto, ap.nombre, SUM(ap.cantidad) as [cantidad], ap.descripcion, ap.peso, ap.idTipoProducto, dfp.idDefaultFoto
FROM (
	SELECT idProducto, nombre, cantidad, descripcion, peso, idTipoProducto FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos
	UNION ALL
	SELECT idProducto, nombre, cantidad, descripcion, peso, idTipoProducto FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos
	UNION ALL
	SELECT idProducto, nombre, cantidad, descripcion, peso, idTipoProducto FROM [25.36.158.76,1403].INV_SUR.dbo.Productos
) AS ap
INNER JOIN DefaultFotosXProductos dfp on ap.idProducto = dfp.idProducto
GROUP BY ap.idProducto, ap.nombre, ap.descripcion, ap.peso, ap.idTipoProducto, dfp.idDefaultFoto;