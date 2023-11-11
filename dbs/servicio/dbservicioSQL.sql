-- tabla clientes
CREATE TABLE clientes (
  idCliente SERIAL PRIMARY KEY,
  nombreCliente VARCHAR(255) NOT NULL,
  direccion TEXT
);

-- tabla ordenes
CREATE TABLE ordenes (
  idOrden SERIAL PRIMARY KEY,
  clienteID INT REFERENCES clientes(idCliente),
  fecha_hora TIMESTAMP NOT NULL,
  descripcion TEXT
);

-- tabla tipo pregunta
CREATE TABLE tiposPregunta (
  	idTipoLlamada SERIAL PRIMARY KEY,
	descripcion VARCHAR(255)
);


--  tabla llamadas con referencia a empleado
CREATE TABLE llamadas (
  idLlamada SERIAL PRIMARY KEY,
  empleadoID INT, 						-- referencia al empleado
  fecha_hora TIMESTAMP NOT NULL,
  clienteID INT REFERENCES clientes(idCliente),
  descripcion TEXT,
  idTipoPregunta INT REFERENCES tiposPregunta(idTipoLlamada)
);

-- tabla tipos de pregunta
CREATE TABLE roles (
  	idRol SERIAL PRIMARY KEY,
	descripcion VARCHAR(50)
);

-- tabla usuarios
CREATE TABLE usuarios (
  idUsuario SERIAL PRIMARY KEY,
	rol int REFERENCES roles(idRol),
	nickname VARCHAR(50)
	--empleadoID int --Referencia a un empleado.
);
