insert into [RRHH]...salidasempleadoslogs (empleadoID, dia, horas, estaEnCapacitacion)
values (1, '2022-11-09', 5, 0),
	   (2, '2022-11-09', 7, 0),
	   (1, '2022-11-10', 8, 0),
	   (2, '2022-11-10', 3, 0),
	   (1, '2023-01-20', 9, 0),
	   (2, '2023-01-20', 10, 0),
	   (1, '2023-01-21', 1, 0),
	   (2, '2023-01-21', 2, 0)

insert into [RRHH]...quincenaslogs (empleadoID, fecha, inicioQuincena, finalQuincena, paisID, montoBruto, cargos, montoNeto, horasTrabajadas, monedaID)
values (1, '2022-11-01', '2022-11-15', '2022-11-16', 1, 1000, 100, 900, 120, 1),
	   (2, '2022-11-01', '2022-11-15', '2022-11-16', 2, 600000, 25000, 575000, 130, 2),
	   (1, '2022-02-01', '2022-02-15', '2022-02-16', 1, 850, 50, 800, 100, 1),
	   (2, '2022-02-01', '2022-02-15', '2022-02-16', 2, 400000, 20000, 480000, 70, 2)