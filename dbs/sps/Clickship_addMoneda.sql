CREATE OR ALTER PROCEDURE dbo.Clickship_addPais
    @pMoneda VARCHAR(30) = NULL,
    @pAcronimo VARCHAR(5) = NULL,
    @pSimbolo NCHAR(3) = NULL
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

    -- Validate if the country exists 
	IF (SELECT COUNT (monedaID) FROM [RRHH]...monedas WHERE monedaID = @pMoneda) != 0
	BEGIN
		SELECT 'La moneda ya existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert coin into RRHH
        INSERT INTO [RRHH]...monedas (nombre, acronimo, simbolo)
        VALUES (@pMoneda, @pAcronimo, @pSimbolo)

        --Insert coin into Ventas
        INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.Monedas (Nombre, Acronimo, Simbolo)
        VALUES (@pMoneda, @pAcronimo, @pSimbolo)
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END