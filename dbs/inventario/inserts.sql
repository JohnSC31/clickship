--insert tipo producto
INSERT INTO tipoProducto (idTipoProducto, descripcion) VALUES
  (1, 'Electrónicos'),
  (2, 'Ropa'),
  (3, 'Alimentos'),
  (4, 'Hogar'),
  (5, 'Juguetes'),
  (6, 'Electrodomésticos'),
  (7, 'Calzado'),
  (8, 'Libros'),
  (9, 'Joyas'),
  (10, 'Herramientas');

-- insert productos
INSERT INTO productos_islas (idProducto, nombreProducto, tipoProductoID, afinidad, imagen) VALUES
  (1, 'Teléfono', 1, 'Electrónicos',null),
  (2, 'Camisa', 2, 'Ropa',null),
  (3, 'Arroz', 3, 'Alimentos',null),
  (4, 'Sartén', 4, 'Hogar',null),
  (5, 'Pelota', 5, 'Juguetes', null),
  (6, 'Licuadora', 6, 'Electrodomésticos', null),
  (7, 'Zapatillas', 7, 'Calzado', null),
  (8, 'Novela', 8, 'Libros', null),
  (9, 'Anillo', 9, 'Joyas', null),
  (10, 'Destornillador', 10, 'Herramientas', null),
  (11, 'Tablet', 5, 'Electrónicos', null),
  (12, 'Pantalón', 7, 'Ropa', null),
  (13, 'Pasta', 9, 'Alimentos', null),
  (14, 'Olla', 10, 'Hogar', null),
  (15, 'Videojuego', 5, 'Juguetes', null),
  (16, 'Aspiradora', 6, 'Electrodomésticos', null),
  (17, 'Botas', 7, 'Calzado', null),
  (18, 'Historia', 8, 'Libros', null),
  (19, 'Collar', 9, 'Joyas',null),
  (20, 'Martillo', 10, 'Herramientas', null);

 -- insert bodegas
INSERT INTO bodegas_islas (idBodagaIslas, nombre, direccion) VALUES
  (1, 'Bodega A', 'Dirección A'),
  (2, 'Bodega B', 'Dirección B'),
  (3, 'Bodega C', 'Dirección C'),
  (4, 'Bodega D', 'Dirección D');



INSERT INTO inventario_islas (idInventarioNor, bodegaID, productoID, cantidadProducto) VALUES
  (1, 1, 1, 50),
  (2, 2, 2, 30),
  (3, 3, 3, 100),
  (4, 4, 4, 20);


INSERT INTO empleados_sur (idEmpleado) VALUES
  (1),
  (2),
  (3),
  (4);



