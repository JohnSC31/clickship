CREATE OR ALTER VIEW TiposProductos AS
SELECT atp.idTipoProducto, atp.tipoProducto, [enabled]
FROM (
	SELECT idTipoProducto, tipoProducto, [enabled] FROM [25.36.158.76,1401].INV_NORTE.dbo.TiposProductos
	UNION ALL
	SELECT idTipoProducto, tipoProducto, [enabled] FROM [25.36.158.76,1402].INV_CARIBE.dbo.TiposProductos
	UNION ALL
	SELECT idTipoProducto, tipoProducto, [enabled] FROM [25.36.158.76,1403].INV_SUR.dbo.TiposProductos
) AS atp
GROUP BY atp.idTipoProducto, atp.tipoProducto, atp.[enabled];