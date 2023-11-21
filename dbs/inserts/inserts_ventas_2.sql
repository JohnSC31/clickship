INSERT INTO Monedas (nombre, acronimo, monedaBase,simbolo) values
('Dolar', 'USD', 1, '$'),
('Colon', 'CRC', 0, '₡'),
('Euro', 'EUR', 0, '€'),
('Peso Dominicano', 'DOP', 0, 'RD$'),
('Peso Argentino', 'ARS', 0, 'AR$');

INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.Moneda (nombre, acronimo, monedaBase,simbolo) values
('Peso Dominicano', 'DOP', 0, 'RD$'),
('Peso Argentino', 'ARS', 0, 'AR$');

INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.TiposDeCambio (precioCambio,monedaid, inicioVigencia) VALUES
(530.73, 2, CURRENT_TIMESTAMP), (0.92, 3, CURRENT_TIMESTAMP), (56.88, 4, CURRENT_TIMESTAMP), (353.5, 5, CURRENT_TIMESTAMP);
  
  -- insert for preciosHistóricos one moneda and a tipoDeCambio  BD 1
INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.precioshistoricos (productoid, precio, MonedaID, TipoDeCambioID, inicioVigencia)
VALUES
  (1, 500, 1, 1, CURRENT_TIMESTAMP),
  (2, 530, 1, 1, CURRENT_TIMESTAMP),
  (3, 503.99, 1, 1, CURRENT_TIMESTAMP),
  (4, 549.99, 1, 1, CURRENT_TIMESTAMP),
  (5, 495.99, 1, 1, CURRENT_TIMESTAMP),
  (6, 459.99, 1, 1, CURRENT_TIMESTAMP),
  (7, 1099.99, 1, 1, CURRENT_TIMESTAMP),
  (8, 1249.99, 1, 1, CURRENT_TIMESTAMP),
  (9, 1199.99, 1, 1, CURRENT_TIMESTAMP),
  (10, 1299.99, 1, 1, CURRENT_TIMESTAMP);


UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden SET PrecioHistoricoID = 1 WHERE ProductoXOrdenID = 1;
UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden SET PrecioHistoricoID = 1 WHERE ProductoXOrdenID = 3;

UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden SET PrecioHistoricoID = 2 WHERE ProductoXOrdenID = 2;
UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden SET PrecioHistoricoID = 2 WHERE ProductoXOrdenID = 4;

UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes SET CostoTotal = 430+530*7, MonedaID=1 WHERE ordenID = 1;
UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes SET CostoTotal = 2*500, MonedaID=1 WHERE ordenID = 2;
UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes SET CostoTotal = 530*2, MonedaID=1 WHERE ordenID = 3;