INSERT INTO Moneda (Nombre, Acronimo, MonedaBase, Simbolo)
VALUES ('Dolar', 'USD', 1, '$'),
	   ('Colon', 'CRC', 0, '₡'),
	   ('Euro', 'EUR', 0, '€')


INSERT INTO Paises (Nombre)
VALUES ('Estados Unidos'),
	   ('Costa Rica'),
	   ('Argentina')


INSERT INTO Estados (Estado)
VALUES ('Recibido'),
	   ('En progreso'),
	   ('Finalizado'),
	   ('En revision')

INSERT INTO Ordenes (ClienteID, Fecha, CostoTotal, EstadoActualID, PaisID, Ubicacion, Direccion, MonedaID)
VALUES (1, '2023-11-13 21:10:05', 45000, 1, 2, geography::STGeomFromText('POLYGON((-122.358 47.653 , -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326), '', 2),
	   (2, '2023-11-14 09:23:45', 10, 1, 1, geography::STGeomFromText('POLYGON((-22.358 47.653 , -22.348 47.649, -22.348 47.658, -22.358 47.658, -22.358 47.653))', 4326), '', 1),
	   (1, '2023-11-15 12:57:32', 5000, 1, 2, geography::STGeomFromText('POLYGON((-122.358 47.653 , -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326), '', 2)


INSERT INTO ProductosXOrden (OrdenID, ProductoID, Cantidad)
VALUES (1, 1, 5),
	   (1, 2, 7),
	   (2, 1, 2),
	   (3, 2, 2)


INSERT INTO BitacoraOrdenes (OrdenID, EstadoID, Fecha)
VALUES (1, 1, '2023-11-13 21:10:05'),
	   (2, 1, '2023-11-14 09:23:45'),
	   (3, 1, '2023-11-15 12:57:32')


INSERT INTO Traslados (BodegaOrigenID, FechaSalida, BodegaDestinoID, FechaLlegada, ProductoID, OrdenID)
VALUES (3, '2023-11-13 23:10:05', 1, '2023-11-14 04:21:52', 1, 1),
	   (1, '2023-11-15 14:57:32', 2, '2023-11-16 12:34:02', 1, 1)