-- la base de datos para Norteamérica

-- Tabla de monedas
CREATE TABLE monedas (
  monedaID smallint PRIMARY KEY IDENTITY(1,1),
  nombre varchar(30),
  acronimo varchar(5),
  MonedaBase bit,
  Simbolo nchar(3)
);

-- Tabla de tipo de cambio
CREATE TABLE tipoDeCambio (
  tipoDeCambioID INT PRIMARY KEY IDENTITY(1,1),
  monedaID smallint REFERENCES monedas(monedaID),
  inicioVigencia datetime2(7),
  finVigencia datetime2(7),
  enabled bit,
  precioCambio DECIMAL(10, 2)
);

-- Tabla de productos
CREATE TABLE tipoProducto (
  idTipoProducto INT PRIMARY KEY IDENTITY(1,1),
  descripcion varchar(255)
);

-- Tabla de afinidad
CREATE TABLE afinidad (
  idAfinidad INT PRIMARY KEY IDENTITY(1,1),
  descripcion varchar(255) NOT NULL
);


-- Tabla de productos
CREATE TABLE productos (
  idProducto INT PRIMARY KEY IDENTITY(1,1),
  nombreProducto VARCHAR(255) UNIQUE NOT NULL,
  tipoProductoID int REFERENCES tipoProducto(idTipoProducto),
  afinidad int REFERENCES afinidad(idAfinidad),
  monedaID smallint REFERENCES monedas(monedaID)
);

-- Tabla de inventario
CREATE TABLE inventario_nor (
  idInventarioNor INT PRIMARY KEY IDENTITY(1,1),
  productoID INT REFERENCES productos(idProducto),
  cantidadProducto INT
);

-- Tabla detalles de productos
CREATE TABLE detallesProducto (
  idDetalleProducto INT PRIMARY KEY IDENTITY(1,1),
  productoID INT REFERENCES productos(idProducto),
  peso DECIMAL(10, 2),
  dimensiones VARCHAR(255),
  descripcion TEXT,
  monedaID smallint REFERENCES monedas(monedaID),
  tipoDeCambioID INT REFERENCES tipoDeCambio(tipoDeCambioID)
);

-- Tabla precios históricos
CREATE TABLE preciosHistoricos (
  idPrecioHistorico INT PRIMARY KEY IDENTITY(1,1),
  detalleProductoID INT REFERENCES detallesProducto(idDetalleProducto),
  fechaInicio DATETIME NOT NULL,
  fechaFin DATETIME,
  precio DECIMAL(10, 2) NOT NULL,
  tipoDeCambioID INT REFERENCES tipoDeCambio(tipoDeCambioID)
);
