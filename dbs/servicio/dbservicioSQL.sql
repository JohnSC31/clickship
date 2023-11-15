-- Crear la tabla "ordenes"
CREATE TABLE ordenes (
  idOrden SERIAL PRIMARY KEY,
  clienteID INT,					-- referencia al cliente
  fecha_hora TIMESTAMP NOT NULL,
  descripcion TEXT
);

-- Crear la tabla tipo pregunta
CREATE TABLE tiposPregunta (
  	idTipoLlamada SERIAL PRIMARY KEY,
	descripcion VARCHAR(255)
);


-- Crear la tabla "llamadas" con referencia a empleado y cliente
CREATE TABLE llamadas (
  idLlamada SERIAL PRIMARY KEY,
  empleadoID INT, 						-- referencia al empleado
  fecha_hora TIMESTAMP NOT NULL,
  clienteID INT,						-- referencia al cliente
  descripcion TEXT,
  idTipoPregunta INT REFERENCES tiposPregunta(idTipoLlamada),
  ordenID int references ordenes(idOrden)
);