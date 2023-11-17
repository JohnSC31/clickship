CREATE OR ALTER PROCEDURE dbo.Clickship_agregarEmpleado
    @pName VARCHAR(20) = NULL, 
    @pSurnames VARCHAR(30) = NULL,
    @pEmail VARCHAR(50) = NULL, 
    @pRol INT = NULL,
    @pCountry INT = NULL,
	@pDepartment INT = NULL,
	@pSalario DECIMAL(18,6) = NULL,
	@pMoneda INT = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pName, '')='')
	BEGIN
		SELECT 'El nombre no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pSurnames, '')='')
	BEGIN
		SELECT 'Los apellidos no pueden ser nulos' 'Error';
		RETURN
	END
	IF (ISNULL(@pEmail, '')='')
	BEGIN
		SELECT 'El correo no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pRol, -1)=-1)
	BEGIN
		SELECT 'El rol no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pCountry, -1)=-1)
	BEGIN
		SELECT 'El país no puede ser nulo' 'Error';
		RETURN
	END
    IF (ISNULL(@pDepartment, -1)=-1)
	BEGIN
		SELECT 'El departamento no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pSalario, '')='')
	BEGIN
		SELECT 'El salario no puede ser nulo' 'Error';
		RETURN
	END
	IF (ISNULL(@pMoneda, -1)=-1)
	BEGIN
		SELECT 'La moneda no puede ser nula' 'Error';
		RETURN
	END

	-- Validate if the employee already exists
	DECLARE @existentEmployee INT
	SET @existentEmployee = (SELECT empleadoID FROM [RRHH]...empleados WHERE nombre = @pName AND apellidos = @pSurnames)
	IF (ISNULL(@existentEmployee, -1)!=-1)
	BEGIN
		SELECT 'El funcionario ya está registrado' 'Error';
		RETURN
	END

    -- Validate if the rol exists 
	IF (SELECT COUNT (rolID) FROM [RRHH]...roles WHERE rolID = @pRol) = 0
	BEGIN
		SELECT 'El rol no existe' 'Error';
		RETURN
	END

    -- Validate if the country exists
	IF (SELECT COUNT (paisID) FROM [RRHH]...paises WHERE paisID = @pCountry) = 0
	BEGIN
		SELECT 'El país no existe' 'Error';
		RETURN
	END

    -- Validate if the department exists
	IF (SELECT COUNT (departamentoID) FROM [RRHH]...departamentos WHERE departamentoID = @pDepartment) = 0
	BEGIN
		SELECT 'El departamento no existe' 'Error';
		RETURN
	END

	-- Validate if the coin exists
	IF (SELECT COUNT (monedaID) FROM [RRHH]...monedas WHERE monedaID = @pMoneda) = 0
	BEGIN
		SELECT 'La moneda no existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert employee
        INSERT INTO [RRHH]...empleados (nombre, apellidos, correo, rolID, paisID, departamentoID)
        VALUES (@pName, @pSurnames, @pEmail, @pRol, @pCountry, @pDepartment)

		DECLARE @newEmployeeID INT
		SET @newEmployeeID = SCOPE_IDENTITY()

		INSERT INTO [RRHH]...salarioslogs (empleadoID, inicioVigencia, salario, monedaID, rolID)
		VALUES (@newEmployeeID, GETDATE(), @pSalario, @pMoneda, @pRol)

		RETURN @newEmployeeID
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END