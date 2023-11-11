-- Base de datos para las Islas del Caribe

-- Tabla de productos
CREATE TABLE tipoProducto (
	idTipoProducto INT PRIMARY KEY,
	descripcion varchar(255)
);

-- tabla de productos
CREATE TABLE productos_islas (
  idProducto INT PRIMARY KEY,
  nombreProducto VARCHAR(255) UNIQUE NOT NULL,
  tipoProductoID int references tipoProducto(idTipoProducto),
  afinidad VARCHAR(255) NOT NULL
);

-- tabla de bodegas
CREATE TABLE bodegas_islas (
  idBodagaIslas INT PRIMARY KEY,
  nombre VARCHAR(255) UNIQUE NOT NULL,
  direccion TEXT
);

-- tabla de inventario
CREATE TABLE inventario_islas (
  idInventarioNor INT PRIMARY KEY,
  bodegaID INT REFERENCES bodegas_islas(idBodagaIslas),
  productoID INT REFERENCES productos_islas(idProducto),
  cantidadProducto INT
);

-- Tabla de empleados en Norteamérica sin referencia
CREATE TABLE empleados_sur(
  idEmpleado INT PRIMARY KEY
);
