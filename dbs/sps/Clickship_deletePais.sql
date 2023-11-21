CREATE OR ALTER PROCEDURE dbo.Clickship_deletePais
    @pPais INT = NULL
AS
BEGIN
    SET NOCOUNT ON

	-- Validate none of the params are null
	IF (ISNULL(@pPais, -1)=-1)
	BEGIN
		SELECT 'El país no puede ser nulo' 'Error';
		RETURN
	END

    -- Validate if the country exists 
	IF (SELECT COUNT (paisID) FROM [RRHH]...paises WHERE paisID = @pPais) = 0
	BEGIN
		SELECT 'El país no existe' 'Error';
		RETURN
	END

    BEGIN TRY
		--Delete country RRHH
        DELETE [RRHH]...paises WHERE paisID = @pPais

        --Delete country Ventas
        DELETE [25.36.158.76,1400].DepartamentoVentas.dbo.Paises WHERE PaisID = @pPais
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() 'Error' 
    END CATCH
END