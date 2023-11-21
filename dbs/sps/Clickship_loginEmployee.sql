CREATE OR ALTER PROCEDURE dbo.Clickship_loginEmployee
    @pLogin NVARCHAR(90) = NULL, 
    @pPassword NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON
	BEGIN TRY
		-- Validate none of the params are null
		IF (ISNULL(@pLogin, '')='')
		BEGIN
			SELECT 'El correo no puede ser nulo' 'Error';
			RETURN
		END
		IF (ISNULL(@pPassword, '')='')
		BEGIN
			SELECT 'La contraseña no puede ser nula' 'Error';
			RETURN
		END

		DECLARE @idEmployee INT
		SET @idEmployee = (SELECT idEmpleado FROM Empleados WHERE correo = @pLogin AND contrasena = HASHBYTES('SHA2_512', @pPassword))
		IF(ISNULL(@idEmployee, -1)=-1)
		BEGIN
			SELECT 'El correo o la contraseña son incorrectos' 'Error';
			RETURN
		END
		ELSE
		BEGIN
			SELECT e.empleadoID, e.nombre, e.apellidos, e.correo, r.rol, e.rolid, e.paisid, p.nombre as [pais], e.departamentoid, d.nombre as [departamento]
			FROM [RRHH]...Empleados e
			INNER JOIN [RRHH]...Roles r on e.rolid = r.rolid
			INNER JOIN [RRHH]...Paises p on p.paisid = e.paisid
			INNER JOIN [RRHH]...Departamentos d on e.departamentoid = d.departamentoid
			WHERE e.empleadoID = @idEmployee
			RETURN;
		END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error';
    END CATCH

END