CREATE OR ALTER PROCEDURE dbo.Clickship_calcularSalarioEmpleado
    @pEmpleado INT = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pEmpleado, -1)=-1)
	BEGIN
		SELECT 'El empleado no puede ser nulo' 'Error';
		RETURN
	END

	-- Validate if the employee already exists
	IF (SELECT COUNT (empleadoID) FROM [RRHH]...empleados WHERE empleadoID = @pEmpleado) = 0
	BEGIN
		SELECT 'El empleado no existe' 'Error';
		RETURN
	END

    BEGIN TRY
        DECLARE @moneda INT
        DECLARE @salario DECIMAL(18,6)
        DECLARE @horas DECIMAL(18,6)
        DECLARE @final DATETIME
        DECLARE @inicio DATETIME
        DECLARE @cantidad DECIMAL(18,6)
        DECLARE @montoBruto DECIMAL(18,6)
        DECLARE @cargos DECIMAL(18,6)
        DECLARE @montoNeto DECIMAL(18,6)
        DECLARE @fecha DATETIME
        DECLARE @fechaInicio DATETIME

		SELECT @inicio = MAX(inicioVigencia), @moneda = monedaID, @salario = salario FROM [RRHH]...salarioslogs
        WHERE  empleadoID = @pEmpleado
        GROUP BY moneda, salario, finalVigencia

        SELECT @final = MAX(finalQuincena) FROM [RRHH]...quincenaslogs
        WHERE empleadoID = @pEmpleado

        SELECT @horas = SUM(horas) FROM [RRHH]...salidasempleadoslogs
        WHERE empleadoID = @pEmpleado

        SELECT @cantidad = cxp.cantidad FROM [RRHH]...cargosxpaises as cxp
        INNER JOIN [RRHH]...empleados as e ON e.paisID = cxp.paisID
        WHERE empleadoID = @pEmpleado

        SET @montoBruto = (@salario/8*20)*@horas
        SET @cargos = @montoBruto*@cantidad
        SET @montoNeto = @montoBruto - @cargos

        SET @fecha = CURRENT_TIMESTAMP
        SET @fechaInicio = DATEADD(DAY, 1, @final)

        INSERT INTO [RRHH]...quincenaslogs (empleadoID, fecha, inicioQuincena, finalQuincena, montoBruto, cargos, montoNeto, horasTrabajadas, monedaID)
        VALUES (@pEmpleado, @fecha, @fechaInicio, @fecha, @montoBruto, @cargos, @montoNeto, @horas, @moneda)

        SELECT '' 'Error'
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END