CREATE OR ALTER PROC dbo.Clickship_postLlamada
	@empleadoID INT = NULL,
	@clienteID INT = NULL,
	@descripcion TEXT = NULL,
	@idTipoPregunta INT = NULL,
	@ordenID INT = NULL
AS
BEGIN
	IF (@empleadoID IS NULL)
	BEGIN
		SELECT 'La llamada no puede ser atendida por un empleado nulo' 'Error';
		RETURN;
	END;
	IF (@clienteID IS NULL)
	BEGIN
		SELECT 'La llamada no puede tener un cliente nulo' 'Error';
		RETURN;
	END;
	IF (@descripcion IS NULL)
	BEGIN
		SELECT 'La llamada no puede tener una descripcion nula' 'Error';
		RETURN;
	END;
	IF (@idTipoPregunta IS NULL)
	BEGIN
		SELECT 'El tipo de la pregunta debe ser valido, no puede ser nulo' 'Error';
		RETURN;
	END;
	IF (@ordenID IS NULL)
	BEGIN
		SELECT 'La llamada debe hacer referencia a una orden en especifico, la orden no puede ser nula' 'Error';
		RETURN;
	END;

	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @date DATETIME = CURRENT_TIMESTAMP
		INSERT INTO [SERVICIO]...llamadas (empleadoID, fecha_hora, clienteID, descripcion, idTipoPregunta, ordenID)
		VALUES (@empleadoID, @date, @clienteID, @descripcion, @idTipoPregunta, @ordenID);
		SELECT '' 'Error';
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al insertar la llamada' 'Error'
	END CATCH
END