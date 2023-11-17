declare @apellidos varchar(20)
set @apellidos = ''

declare @pais varchar(20)
set @pais = ''

declare @rol varchar(20)
set @rol = ''

declare @departamento varchar(20)
set @departamento = ''

declare @inicio date
set @inicio = null

declare @final date
set @final = null

SELECT e.nombre, e.apellidos, d.nombre as departamento, r.rol, q.fecha, p.nombre as Pais, CONCAT(q.montoBruto*(1/COALESCE(tp.precioCambio, 1)), ' $') as monto, q.cargos, q.montoNeto, q.horasTrabajadas, m.simbolo FROM [RRHH]...quincenaslogs as q
INNER JOIN [RRHH]...empleados as e ON e.empleadoID = q.empleadoID AND (@apellidos = '' OR @apellidos = e.apellidos)
INNER JOIN [RRHH]...roles as r ON r.rolID = e.rolID AND (@rol = '' OR @rol = r.rol)
INNER JOIN [RRHH]...departamentos as d ON d.departamentoID = e.departamentoID AND (@departamento = '' OR @departamento = d.nombre)
INNER JOIN [RRHH]...paises as p ON p.paisID = e.paisID AND (@pais = '' OR @pais = p.nombre)
INNER JOIN [RRHH]...monedas as m ON m.monedaID = q.monedaID
LEFT JOIN [RRHH]...TiposDeCambio tp on m.monedaID = tp.monedaID
WHERE q.fecha > COALESCE(@inicio, CONVERT(DATE, '1800-01-01')) AND q.fecha < COALESCE(@final, CONVERT(DATE, '2200-01-01'))
GROUP BY e.nombre, e.apellidos, d.nombre, r.rol, q.fecha, p.nombre, q.montoBruto, q.cargos, q.montoNeto, q.horasTrabajadas, m.simbolo, tp.precioCambio