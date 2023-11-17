DECLARE @producto varchar(20)
SET @producto = ''

DECLARE @tipoProducto varchar(20)
SET @tipoProducto = ''

DECLARE @inventario varchar(20)
SET @inventario = ''

DECLARE @pais varchar(20)
SET @pais = ''

DECLARE @inicio datetime
SET @inicio = null

DECLARE @final datetime
SET @final = null

SELECT o.OrdenID, c.nombre as Cliente, p.Nombre as Pais, i.nombre as Inventario, o.Fecha, prod.nombre as Producto, prod.tipoProducto as TipoProducto, pxo.Cantidad as CantidadProducto, prod.precio as PrecioUnitarioProducto, pxo.Cantidad*prod.precio as TotalProductoXOrden
FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes as o
INNER JOIN Clientes as c ON c.idCliente = o.ClienteID
INNER JOIN Inventarios as i ON i.idInventario = o.InventarioID AND (@inventario = '' OR @inventario = i.nombre)
INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.Paises as p ON p.PaisID = o.PaisID AND (@pais = '' OR @pais = p.nombre)
INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden as pxo ON pxo.OrdenID = o.OrdenID
INNER JOIN Productos as prod ON prod.idProducto = pxo.ProductoID AND prod.simbolo = '$'
AND (@producto = '' OR @producto = prod.nombre) AND (@tipoProducto = '' OR @tipoProducto = prod.tipoProducto)
WHERE o.EstadoActualID = 3 AND (o.Fecha > COALESCE(@inicio, CONVERT(DATE, '1800-01-01')) AND o.Fecha < COALESCE(@final, CONVERT(DATE, '2200-01-01')))
GROUP BY o.OrdenID, c.nombre, p.Nombre, i.nombre, o.Fecha, prod.nombre, prod.tipoProducto, pxo.Cantidad, prod.precio, pxo.Cantidad*prod.precio


-- Por tipo de producto
SELECT o.OrdenID, c.Nombre as Cliente, Fecha, CostoTotal, Completa, p.Nombre as Pais FROM Ordenes as o
INNER JOIN Clientes as c ON c.ClienteID = o.ClienteID
INNER JOIN Paises as p ON p.PaisID = o.PaisID
INNER JOIN ProductosXOrden as pxo ON pxo.OrdenID = o.OrdenID
INNER JOIN Productos as prod ON prod.ProductoID = pxo.ProductoID
INNER JOIN TipoProducto as tp ON tp.TipoProductoID = prod.TipoProductoID
WHERE tp.Tipo = ''

-- Por producto
SELECT o.OrdenID, c.Nombre as Cliente, Fecha, CostoTotal, Completa, p.Nombre as Pais FROM Ordenes as o
INNER JOIN Clientes as c ON c.ClienteID = o.ClienteID
INNER JOIN Paises as p ON p.PaisID = o.PaisID
INNER JOIN ProductosXOrden as pxo ON pxo.OrdenID = o.OrdenID
INNER JOIN Productos as prod ON prod.ProductoID = pxo.ProductoID
WHERE prod.Nombre = ''

-- Por pais
SELECT o.OrdenID, c.Nombre as Cliente, Fecha, CostoTotal, Completa, p.Nombre as Pais FROM Ordenes as o
INNER JOIN Clientes as c ON c.ClienteID = o.ClienteID
INNER JOIN Paises as p ON p.PaisID = o.PaisID
WHERE p.Nombre = ''

-- Por fecha
SELECT o.OrdenID, c.Nombre as Cliente, Fecha, CostoTotal, Completa, p.Nombre as Pais FROM Ordenes as o
INNER JOIN Clientes as c ON c.ClienteID = o.ClienteID
INNER JOIN Paises as p ON p.PaisID = o.PaisID
WHERE o.Fecha = ''