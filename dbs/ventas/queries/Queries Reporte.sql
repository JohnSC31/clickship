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