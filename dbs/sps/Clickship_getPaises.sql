CREATE OR ALTER PROC dbo.Clickship_getPaises
AS
BEGIN
	SET NOCOUNT ON
	--Selects all the names of the countries in the system
	BEGIN TRY
		SELECT p.paisID, p.nombre, m.nombre as moneda, m.simbolo, m.monedaid from [RRHH]...paises p
		INNER JOIN [RRHH]...Monedas m on p.MonedaID = m.MonedaID;
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error al seleccionar los paises' 'Error'
	END CATCH
END