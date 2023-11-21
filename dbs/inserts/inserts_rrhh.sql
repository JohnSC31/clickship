INSERT INTO [RRHH]...Monedas (nombre, acronimo, monedaBase,simbolo) values
('Dolar', 'USD', 1, '$'),
('Colon', 'CRC', 0, '₡'),
('Euro', 'EUR', 0, '€'),
('Peso Dominicano', 'DOP', 0, 'RD$'),
('Peso Argentino', 'ARS', 0, 'AR$');

INSERT INTO [RRHH]...Paises (nombre, monedaID)
VALUES ('Estados Unidos', 1),
	   ('Costa Rica', 2),
	   ('Argentina', 5),
	   ('Republica Dominicana', 4);

INSERT INTO [RRHH]...Departamentos (nombre)
VALUES ('Ventas'), ('Inventario'), ('RRHH'), ('Servicio al cliente');

INSERT INTO [RRHH]...Roles (rol) 
VALUES ('Jefe RRHH'),('Jefe Inventario'), ('Jefe Ventas'), ('Jefe Servicio al Cliente'),
	   ('Trabajador RRHH'), ('Bodeguista'), ('Manager de Ventas'), ('Asistente Callcenter');

INSERT INTO [RRHH]...TiposDeCambio (precioCambio,monedaID) VALUES
(530.73, 2), (0.92, 3), (56.88, 4), (353.5, 5);


INSERT INTO [RRHH]...CargosXPaises (paisID, porcentaje) VALUES (1, 0.05), (2, 0.13), (3, 0.16), (4, 0.9);



INSERT INTO [RRHH]...Empleados (nombre, apellidos, correo, rolID, paisID, departamentoID) VALUES ('Luis', 'Navarro Todd', 'luiscatodd@gmail.com', 1, 2, 3)
INSERT INTO [RRHH]...Empleados (nombre, apellidos, correo, rolID, paisID, departamentoID) VALUES ('Juan', 'Rodriguez Brenes', 'juan@gmail.com', 6, 1, 2)


INSERT INTO [RRHH]...SalariosLogs (empleadoID, salario, monedaID, rolID) VALUES
(1, 5130000, 2, 1),
(2, 1500, 1, 6);

--SELECT * FROM [RRHH]...Empleados;
--SELECT * FROM [RRHH]...Roles;
--SELECT * FROM [RRHH]...Paises;
--SELECT * FROM [RRHH]...Departamentos;