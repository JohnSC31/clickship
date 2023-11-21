CREATE OR ALTER PROCEDURE dbo.Clickship_editPais
    @pPais INT = NULL,
    @pNewPais VARCHAR(40),
    @pNewMoneda INT = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pPais, -1)=-1)
	BEGIN
		SELECT 'El país no puede ser nulo' 'Error';
		RETURN
	END
    
    IF (ISNULL(@pNewPais, '')='')
	BEGIN
		SELECT 'El nuevo país no puede ser nulo' 'Error';
		RETURN
	END

    IF (ISNULL(@pNewMoneda, -1)=-1)
	BEGIN
		SELECT 'La nueva moneda no puede ser nula' 'Error';
		RETURN
	END

    -- Validate if the country exists 
	IF (SELECT COUNT (paisID) FROM [RRHH]...paises WHERE paisID = @pPais) = 0
	BEGIN
		SELECT 'El país no existe' 'Error';
		RETURN
	END

    -- Validate if the coin exists
    IF (SELECT COUNT (monedaID) FROM [RRHH]...monedas WHERE monedaID = @pNewMoneda) = 0
	BEGIN
		SELECT 'La moneda no existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Update country RRHH
		DECLARE @idnuevo int = 15;
		DECLARE @rolnuevo VARCHAR(40) = 'Gerente'
		DECLARE @query NVARCHAR(90) = CONCAT('CALL updatePais(', @pPais, ', "', @pNewPais, '", ', @pNewMoneda,')')
		EXEC(@query) AT [RRHH]

        --Update country Ventas
        UPDATE [25.36.158.76,1400].DepartamentoVentas.dbo.Paises SET Nombre = @pNewPais WHERE PaisID = @pPais
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END
