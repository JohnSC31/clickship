-- la base de datos para Norteamérica

-- Tabla de productos
CREATE TABLE tipoProducto (
	idTipoProducto INT PRIMARY KEY,
	descripcion varchar(255)
)

-- Tabla de productos
CREATE TABLE productos_nor (
  idProducto INT PRIMARY KEY,
  nombreProducto VARCHAR(255) UNIQUE NOT NULL,
  tipoProductoID int references tipoProducto(idTipoProducto),
  afinidad VARCHAR(255) NOT NULL
);

-- Tabla de bodegas
CREATE TABLE bodegas_nor (
  idBodagaNor INT PRIMARY KEY,
  nombre VARCHAR(255) UNIQUE NOT NULL,
  direccion TEXT
);

-- Tabla de inventario
CREATE TABLE inventario_nor (
  idInventarioNor INT PRIMARY KEY,
  bodegaID INT REFERENCES bodegas_nor(idBodagaNor),
  productoID INT REFERENCES productos_nor(idProducto),
  cantidadProducto INT
);

-- Tabla de empleados en Norteamérica sin referencia
CREATE TABLE empleados_nor(
  idEmpleado INT PRIMARY KEY
);
