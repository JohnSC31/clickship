--BD 1  dolares

--insert for Monedas
INSERT INTO Monedas (nombre, acronimo, monedaBase,simbolo) values
('Dolar', 'USD', 1, '$'),
('Colon', 'CRC', 0, '₡'),
('Euro', 'EUR', 0, '€'),
('Peso Dominicano', 'DOP', 0, 'RD$'),
('Peso Argentino', 'ARS', 0, 'AR$');

--insert for tipoDeCambio
INSERT INTO TipoDeCambio (precioCambio,idMoneda) VALUES
(530.73, 2), (0.92, 3), (56.88, 4), (353.5, 5);

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
-- Insertar 10 productos básicos
INSERT INTO productos (nombre, idTipoProducto, cantidad, estado, peso, descripcion)
VALUES
  ('Teléfono', 1, 50, 1, 0.2, 'Teléfono móvil básico'),
  ('Laptop', 2, 30, 1, 2.0, 'Computadora portátil simple'),
  ('Tableta', 3, 20, 1, 0.5, 'Tableta estándar'),
  ('Auriculares', 4, 40, 1, 0.3, 'Auriculares convencionales'),
  ('Cámara', 5, 15, 1, 2.5, 'Cámara digital compacta'),
  ('Reloj Inteligente', 6, 25, 1, 0.1, 'Reloj con funciones básicas'),
  ('Ratón Inalámbrico', 6, 30, 1, 0.15, 'Ratón básico para computadora'),
  ('Dron', 6, 10, 1, 0.7, 'Dron de uso recreativo'),
  ('Auriculares Inalámbricos', 4, 35, 1, 0.05, 'Auriculares simples sin cables'),
  ('Batería Externa', 6, 40, 1, 0.5, 'Batería portátil para dispositivos');


  -- Insertar precios históricos para una moneda y un tipo de cambio  BD 1
INSERT INTO preciosHistoricos (idProducto, precio, idMoneda, idTipoDeCambio)
VALUES
  (1, 500, 1, 1),
  (2, 530, 1, 1),
  (3, 503.99, 1, 1),
  (4, 549.99, 1, 1),
  (5, 495.99, 1, 1),
  (6, 459.99, 1, 1),
  (7, 1099.99, 1, 1),
  (8, 1249.99, 1, 1),
  (9, 1199.99, 1, 1),
  (10, 1299.99, 1, 1);



select * from Monedas
select * from TipoDeCambio
select * from tiposProductos 
select * from productos where estado = 1 or estado = 0
select * from preciosHistoricos