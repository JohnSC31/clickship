SELECT o.OrdenID, c.Nombre as Cliente, Fecha, CostoTotal, Completa, p.Nombre as Pais FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes as o
INNER JOIN Clientes as c ON c.ClienteID = o.ClienteID
INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.Paises as p ON p.PaisID = o.PaisID
INNER JOIN [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden as pxo ON pxo.OrdenID = o.OrdenID
INNER JOIN [25.36.158.76,1401].InventarioNorte.dbo.Productos as prod ON prod.ProductoID = pxo.ProductoID
INNER JOIN [25.36.158.76,1401].InventarioNorte.dbo.TipoProducto as tp ON tp.TipoProductoID = prod.TipoProductoID
INNER JOIN [25.36.158.76,1402].InventarioSur.dbo.Productos as prod ON prod.ProductoID = pxo.ProductoID
INNER JOIN [25.36.158.76,1402].InventarioSur.dbo.TipoProducto as tp ON tp.TipoProductoID = prod.TipoProductoID
INNER JOIN [25.36.158.76,1403].InventarioIslas.dbo.Productos as prod ON prod.ProductoID = pxo.ProductoID
INNER JOIN [25.36.158.76,1403].InventarioIslas.dbo.TipoProducto as tp ON tp.TipoProductoID = prod.TipoProductoID
WHERE tp.Tipo = '' OR prod.Nombre = '' OR p.Nombre = '' OR o.Fecha = ''


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