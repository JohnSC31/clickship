INSERT INTO [SERVICIO]...tipospregunta (descripcion) VALUES ('Consulta'),('Queja');

INSERT INTO [SERVICIO]...llamadas (empleadoid, fecha_hora, clienteid, descripcion, idtipopregunta, ordenid)
VALUES (1, CURRENT_TIMESTAMP, 1, 'El cliente esta molesto por no recibir su pedido', 2, 1),
(2, CURRENT_TIMESTAMP, 2, 'El cliente queria consultar su pedido', 1, 2);