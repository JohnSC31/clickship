CREATE OR ALTER PROCEDURE dbo.Clickship_addPais
    @pPais VARCHAR(40) = NULL,
    @pMoneda INT = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pPais, '')='')
	BEGIN
		SELECT 'El país no puede ser nulo' 'Error';
		RETURN
	END

    IF (ISNULL(@pMoneda, -1)=-1)
	BEGIN
		SELECT 'La moneda no puede ser nula' 'Error';
		RETURN
	END

    -- Validate if the country exists 
	IF (SELECT COUNT (paisID) FROM [RRHH]...paises WHERE nombre = @pPais) != 0
	BEGIN
		SELECT 'El país ya existe' 'Error';
		RETURN
	END

    -- Validate if the coin exists
    IF (SELECT COUNT (monedaID) FROM [RRHH]...monedas WHERE monedaID = @pMoneda) = 0
	BEGIN
		SELECT 'La moneda no existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Insert country into RRHH
        INSERT INTO [RRHH]...paises (nombre, monedaID)
        VALUES (@pPais, @pMoneda)

        --Insert country into Ventas
        INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.Paises (Nombre)
        VALUES (@pPais)
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END