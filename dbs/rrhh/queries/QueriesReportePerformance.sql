-- PERFORMANCE

declare @rol varchar(20)
set @rol = ''

declare @pais varchar(20)
set @pais = ''

declare @inicio date
set @inicio = null

declare @final date
set @final = null

SELECT s.empleadoID, e.nombre, e.apellidos, e.correo,  r.rol, p.nombre as Pais, s.horas, s.dia FROM [RRHH]...salidasempleadoslogs as s
INNER JOIN [RRHH]...empleados as e ON e.empleadoID = s.empleadoID
INNER JOIN [RRHH]...roles as r ON r.rolID = e.rolID AND (@rol = '' OR @rol = r.rol)
INNER JOIN [RRHH]...paises as p ON p.paisID = e.paisID AND (@pais = '' OR @pais = p.nombre)
WHERE s.dia > COALESCE(@inicio, CONVERT(DATE, '1800-01-01')) AND s.dia < COALESCE(@final, CONVERT(DATE, '2200-01-01'))
GROUP BY s.empleadoID, e.nombre, e.apellidos, e.correo,  r.rol, p.nombre, s.horas, s.dia











































CASE 
    WHEN @rol = FALSE AND @pais = FALSE
        THEN (BO.VALUE - BO.REFERENCELOWERLIMIT)
    WHEN @rol = TRUE AND @pais = FALSE
        THEN BO.VALUE
    WHEN @rol = FALSE AND @pais = TRUE
        THEN BO.VALUE
    ELSE  (BO.REFERENCEUPPERLIMIT - BO.VALUE)
END

-- Por rol
SELECT s.empleadoID, e.nombre, e.apellidos, e.correo,  r.rol, s.horas FROM [RRHH]...salidasempleadoslogs as s
INNER JOIN [RRHH]...empleados as e ON e.empleadoID = s.empleadoID
INNER JOIN [RRHH]...roles as r ON r.rolID = e.rolID
WHERE r.rol = ''
GROUP BY s.empleadoID

-- Por pais
SELECT s.empleadoID, e.nombre, e.apellidos, e.correo, SUM(horas) OVER() AS TotalHoras, AVG(horas) OVER() AS PromedioHoras, p.nombre FROM [RRHH]...salidasempleadoslogs as s
INNER JOIN [RRHH]...empleados as e ON e.empleadoID = s.empleadoID
INNER JOIN [RRHH]...paises as p ON p.paisID = e.paisID
WHERE p.nombre = ''
GROUP BY s.empleadoID

WHERE s.fecha between COALESCE('')

IF (@rol = 'True')
SELECT s.empleadoID, e.nombre, e.apellidos, e.correo, r.rol
FROM   RRHH...salidasempleadoslogs AS s INNER JOIN
             RRHH...empleados AS e ON e.empleadoID = s.empleadoID INNER JOIN
             RRHH...roles AS r ON r.rolID = e.rolID