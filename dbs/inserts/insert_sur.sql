--insert for tiposProductos
INSERT INTO  tiposProductos (tipoProducto)
VALUES
  ('Smartphones'),
  ('Laptops'),
  ('Tabletas'),
  ('Auriculares'),
  ('Cámaras'),
  ('Accesorios Tecnológicos');
  

--insert for productos
INSERT INTO productos (nombre, idTipoProducto, cantidad, peso, descripcion)
VALUES
  ('Teléfono', 1, 50, 0.2, 'Teléfono móvil básico'),
  ('Laptop', 2, 30, 2.0, 'Computadora portátil simple'),
  ('Tableta', 3, 20, 0.5, 'Tableta estándar'),
  ('Auriculares', 4, 40, 0.3, 'Auriculares convencionales'),
  ('Cámara', 5, 15, 2.5, 'Cámara digital compacta'),
  ('Reloj Inteligente', 6, 25, 0.1, 'Reloj con funciones básicas'),
  ('Ratón Inalámbrico', 6, 30, 0.15, 'Ratón básico para computadora'),
  ('Dron', 6, 10, 0.7, 'Dron de uso recreativo'),
  ('Auriculares Inalámbricos', 4, 35, 0.05, 'Auriculares simples sin cables'),
  ('Batería Externa', 6, 40, 0.5, 'Batería portátil para dispositivos');
