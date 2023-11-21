CREATE OR ALTER PROCEDURE dbo.Clickship_editRol
    @pMoneda INT = NULL,
    @pNuevaMoneda VARCHAR(30) = NULL,
    @pNuevoAcronimo VARCHAR(5) = NULL,
    @pNuevoSimbolo NCHAR(3) = NULL
AS
BEGIN
	-- Validate none of the params are null
	IF (ISNULL(@pMoneda, -1)=-1)
	BEGIN
		SELECT 'La moneda no puede ser nula' 'Error';
		RETURN
	END
IF (ISNULL(@pNuevaMoneda, '')='')
	BEGIN
		SELECT 'La nueva moneda no puede ser nula' 'Error';
		RETURN
	END
    IF (ISNULL(@pNuevoAcronimo, '')='')
    BEGIN
        SELECT 'El acrónimo de la nueva moneda no puede ser nulo' 'Error';
        RETURN
    END
    IF (ISNULL(@pNuevoSimbolo, '')='')
    BEGIN
        SELECT 'El símbolo de la nueva moneda no puede ser nulo' 'Error';
        RETURN
    END

    -- Validate if the coin exists 
	IF (SELECT COUNT (monedaID) FROM [RRHH]...monedas WHERE monedaID = @pMoneda) = 0
	BEGIN
		SELECT 'La moneda no existe' 'Error';
		RETURN
	END
	SET NOCOUNT ON
    BEGIN TRY
		UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.Monedas 
		SET nombre = @pNuevaMoneda, acronimo = @pNuevoAcronimo, simbolo = @pNuevoSimbolo 
		WHERE monedaID = @pMoneda

		--Update rol
		DECLARE @query NVARCHAR(90) = CONCAT('UPDATE [RRHH]...monedas SET nombre = ', @pNuevaMoneda, ', acronimo = ', @pNuevoAcronimo, ', simbolo = ', @pNuevoSimbolo, ' WHERE monedaID = @pMoneda')
		EXEC(@query) AT [RRHH]
		SELECT '' 'Error'
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END
