-- Store procedure get one orden by a client
CREATE OR ALTER PROCEDURE Clickship_getOrdersByClient
  @clienteID INT
AS
BEGIN
	BEGIN TRY
	  SELECT *
	  FROM Ordenes o
	  INNER JOIN Estados e ON o.EstadoActualID = e.EstadoID
	  INNER JOIN Moneda m ON o.MonedaID = m.MonedaID
	  INNER JOIN Paises p ON o.PaisID = p.PaisID
	  WHERE o.ClienteID = @clienteID;
	END TRY
	BEGIN CATCH 
		SELECT 'Ocurrió un error al seleccionar las ordenes del cliente' 'Error'
	END CATCH
END;

exec Clickship_getOrdersByClient 1