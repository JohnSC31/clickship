-- la base de datos para Islas

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


-- Tabla de productos
CREATE TABLE productos (
  idProducto INT PRIMARY KEY IDENTITY(1,1),
  nombreProducto VARCHAR(255) UNIQUE NOT NULL,
  tipoProductoID int REFERENCES tipoProducto(idTipoProducto),
  cantidadProducto INT,
  estado BIT NOT NULL DEFAULT 1 
);

-- Tabla de inventario
CREATE TABLE inventario_islas (
  idInventarioIsla INT PRIMARY KEY IDENTITY(1,1),
  productoID INT REFERENCES productos(idProducto)
);

-- Tabla detalles de productos
CREATE TABLE detallesProducto (
  idDetalleProducto INT PRIMARY KEY IDENTITY(1,1),
  productoID INT REFERENCES productos(idProducto),
  peso DECIMAL(10, 2),
  dimensiones VARCHAR(255),
  descripcion TEXT,
);

-- Tabla precios históricos
CREATE TABLE preciosHistoricos (
  idPrecioHistorico INT PRIMARY KEY IDENTITY(1,1),
  detalleProductoID INT REFERENCES detallesProducto(idDetalleProducto),
  fechaInicio DATETIME NOT NULL,
  fechaFin DATETIME,
  precio DECIMAL(10, 2) NOT NULL,
  monedaID smallint REFERENCES monedas(monedaID),
  tipoDeCambioID INT REFERENCES tipoDeCambio(tipoDeCambioID)
);


