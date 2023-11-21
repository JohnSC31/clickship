CREATE OR ALTER PROCEDURE dbo.Clickship_addMoneda
    @pMoneda VARCHAR(30) = NULL,
    @pAcronimo VARCHAR(5) = NULL,
    @pSimbolo NCHAR(3) = NULL,
    @pPrecioCambio DECIMAL(18,6) = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pMoneda, '')='')
	BEGIN
		SELECT 'La moneda no puede ser nula' 'Error';
		RETURN
	END
    IF (ISNULL(@pAcronimo, '')='')
    BEGIN
        SELECT 'El acrónimo de la moneda no puede ser nulo' 'Error';
        RETURN
    END
    IF (ISNULL(@pSimbolo, '')='')
    BEGIN
        SELECT 'El símbolo de la moneda no puede ser nulo' 'Error';
        RETURN
    END
    IF (ISNULL(@pPrecioCambio, '')='')
    BEGIN
        SELECT 'El precio de cambio de la moneda no puede ser nulo' 'Error';
        RETURN
    END

    -- Validate if the coin exists 
	IF (SELECT COUNT (monedaID) FROM [RRHH]...monedas WHERE monedaID = @pMoneda) != 0
	BEGIN
		SELECT 'La moneda ya existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert coin into RRHH
        INSERT INTO [RRHH]...monedas (nombre, acronimo, simbolo)
        VALUES (@pMoneda, @pAcronimo, @pSimbolo)

        DECLARE @monedaID INT
        SET @monedaID = (SELECT MAX(monedaID) FROM [RRHH]...monedas)

        DECLARE @fecha DATE
        SET @fecha = CURRENT_TIMESTAMP

        INSERT INTO [RRHH]...tiposdecambio (monedaID, inicioVigencia, finalVigencia, enabled, precioCambio)
        VALUES (@monedaID, @fecha, null, 1, @pPrecioCambio)

        --Insert coin into Ventas
        INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.Monedas (Nombre, Acronimo, Simbolo)
        VALUES (@pMoneda, @pAcronimo, @pSimbolo)

        INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.TiposDeCambio (monedaID, inicioVigencia, finalVigencia, enabled, precioCambio)
        VALUES (@monedaID, @fecha, null, 1, @pPrecioCambio)

        SELECT '' 'Error'
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END