-- Base de datos para Suramérica

-- Tabla de productos
CREATE TABLE tipoProducto (
	idTipoProducto INT PRIMARY KEY,
	descripcion varchar(255)
);

-- tabla de productos
CREATE TABLE productos_sur (
  idProducto INT PRIMARY KEY,
  nombreProducto VARCHAR(255) UNIQUE NOT NULL,
  tipoProductoID int references tipoProducto(idTipoProducto),
  afinidad VARCHAR(255) NOT NULL
);

-- tabla de bodegas
CREATE TABLE bodegas_sur (
  idBodagaNor INT PRIMARY KEY,
  nombre VARCHAR(255) UNIQUE NOT NULL,
  direccion TEXT
);

-- ttabla de inventario
CREATE TABLE inventario_sur (
  idInventarioNor INT PRIMARY KEY,
  bodegaID INT REFERENCES bodegas_sur(idBodagaNor),
  productoID INT REFERENCES productos_sur(idProducto),
  cantidadProducto INT
);

-- Tabla de empleados en Norteamérica sin referencia
CREATE TABLE empleados_sur(
  idEmpleado INT PRIMARY KEY
);
