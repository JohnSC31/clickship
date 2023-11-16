-- Store procedure get one orden by a ordenId
CREATE OR ALTER PROCEDURE Clickship_getOrderById
  @ordenID INT
AS
BEGIN
  SELECT *
  FROM Ordenes o
  INNER JOIN Estados e ON o.EstadoActualID = e.EstadoID
  INNER JOIN Moneda m ON o.MonedaID = m.MonedaID
  INNER JOIN Paises p ON o.PaisID = p.PaisID
  WHERE o.OrdenID = @ordenID;
END;
