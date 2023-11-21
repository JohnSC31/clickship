CREATE OR ALTER PROC dbo.Clickship_postOrderProduct
	@pOrdenID INT = NULL,
	@pProductoID INT = NULL,
	@pCantidad INT = NULL
AS
BEGIN
	IF (@pOrdenID IS NULL)
	BEGIN
		SELECT 'No se puede insertar un producto en una orden nula' 'Error'
		RETURN;
	END
	IF (@pProductoID IS NULL)
	BEGIN
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Traslados WHERE OrdenID = @pOrdenID;
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden WHERE OrdenID = @pOrdenID;
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes WHERE OrdenID = @pOrdenID;
		SELECT 'No se puede insertar un producto nulo' 'Error'
		RETURN;
	END
	IF (@pCantidad IS NULL OR @pCantidad <= 0)
	BEGIN
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Traslados WHERE OrdenID = @pOrdenID;
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden WHERE OrdenID = @pOrdenID;
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes WHERE OrdenID = @pOrdenID;
		SELECT 'No se puede insertar insertar 0 del producto o cantidad nula' 'Error'
		RETURN;
	END
	SET NOCOUNT ON;
	BEGIN TRY
		
		DECLARE @cantidadPorVender INT = @pCantidad;
		DECLARE @total INT = (SELECT cantidad FROM Productos WHERE idproducto = 1 AND Monedaid = 1)
		
		--Validate if theres enough of the product in all three inventories, else delete the order
		IF (@cantidadPorVender > @total)
		BEGIN
			DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Traslados WHERE OrdenID = @pOrdenID;
			DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden WHERE OrdenID = @pOrdenID;
			DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes WHERE OrdenID = @pOrdenID;
			SELECT 'No se tiene suficiente de uno de los productos' 'Error';
			RETURN;
		END

		DECLARE @invCercano INT = (SELECT InventarioID FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes WHERE OrdenID=@pOrdenID)
		DECLARE @cantidadMasCercana INT;
		
		-- Set cantidad of the nearest inv to a variable
		IF @invCercano=1
			SET @cantidadMasCercana = (COALESCE((SELECT p.cantidad FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos p WHERE p.idProducto = @pProductoID), 0))
		IF @invCercano=2
			SET @cantidadMasCercana = (COALESCE((SELECT p.cantidad FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos p WHERE p.idProducto = @pProductoID), 0))
		IF @invCercano=3
			SET @cantidadMasCercana = (COALESCE((SELECT p.cantidad FROM [25.36.158.76,1403].INV_SUR.dbo.Productos p WHERE p.idProducto = @pProductoID), 0))
		
		-- Updates all the quantities of the nearest inv
		IF  @cantidadMasCercana >= @cantidadPorVender
		BEGIN
			IF @invCercano=1
				UPDATE [25.36.158.76,1401].INV_NORTE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadPorVender) WHERE idProducto = @pProductoID
			IF @invCercano=2
				UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadPorVender) WHERE idProducto = @pProductoID
			IF @invCercano=3
				UPDATE [25.36.158.76,1403].INV_SUR.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadPorVender) WHERE idProducto = @pProductoID
		END
		ELSE
		BEGIN
			IF @invCercano=1
				UPDATE [25.36.158.76,1401].INV_NORTE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadMasCercana) WHERE idProducto = @pProductoID
			IF @invCercano=2
				UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadMasCercana) WHERE idProducto = @pProductoID
			IF @invCercano=3
				UPDATE [25.36.158.76,1403].INV_SUR.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadMasCercana) WHERE idProducto = @pProductoID
			SET @cantidadPorVender = @cantidadPorVender - @cantidadMasCercana
		END
		-- Get the remaining products from the other invs and generate the delivery order(s)
		IF @cantidadPorVender > 0
		BEGIN
			DECLARE @nearestUbi GEOGRAPHY;
			SET @nearestUbi = (SELECT Ubicacion FROM Inventarios WHERE idInventario=@invCercano)
			DECLARE @secondNearestInv INT = (SELECT TOP 1 idInventario FROM Inventarios  WHERE idInventario != @invCercano ORDER BY @nearestUbi.STDistance(ubicacion) ASC)
			-- DECLARE @thirdNearestInv INT = (SELECT TOP 1 idInventario FROM Inventarios WHERE idInventario NOT IN (@invCercano,@secondNearestInv))
			DECLARE @thirdNearestInv INT = 6 - (@invCercano+@secondNearestInv)
			DECLARE @invDestino INT = @invCercano;
			SET @invCercano = @secondNearestInv
			DECLARE @COUNTER INT = 0
			-- While to get from other two
			WHILE (@COUNTER < 2 AND @cantidadPorVender > 0)
			BEGIN
				DECLARE @date DATETIME = CURRENT_TIMESTAMP;
				IF @invCercano=1
					SET @cantidadMasCercana = (COALESCE((SELECT p.cantidad FROM [25.36.158.76,1401].INV_NORTE.dbo.Productos p WHERE p.idProducto = @pProductoID), 0))
				IF @invCercano=2
					SET @cantidadMasCercana = (COALESCE((SELECT p.cantidad FROM [25.36.158.76,1402].INV_CARIBE.dbo.Productos p WHERE p.idProducto = @pProductoID), 0))
				IF @invCercano=3
					SET @cantidadMasCercana = (COALESCE((SELECT p.cantidad FROM [25.36.158.76,1403].INV_SUR.dbo.Productos p WHERE p.idProducto = @pProductoID), 0))

				IF  @cantidadMasCercana >= @cantidadPorVender
				BEGIN
					IF @invCercano=1
						UPDATE [25.36.158.76,1401].INV_NORTE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadPorVender) WHERE idProducto = @pProductoID
					IF @invCercano=2
						UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadPorVender) WHERE idProducto = @pProductoID
					IF @invCercano=3
						UPDATE [25.36.158.76,1403].INV_SUR.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadPorVender) WHERE idProducto = @pProductoID
				
					SET @cantidadPorVender = 0;
				END
				ELSE
				BEGIN
					IF @invCercano=1
						UPDATE [25.36.158.76,1401].INV_NORTE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadMasCercana) WHERE idProducto = @pProductoID
					IF @invCercano=2
						UPDATE [25.36.158.76,1402].INV_CARIBE.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadMasCercana) WHERE idProducto = @pProductoID
					IF @invCercano=3
						UPDATE [25.36.158.76,1403].INV_SUR.dbo.Productos SET cantidad=(@cantidadMasCercana-@cantidadMasCercana) WHERE idProducto = @pProductoID
					SET @cantidadPorVender = @cantidadPorVender - @cantidadMasCercana
				END
				INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.Traslados (BodegaOrigenID, FechaSalida, BodegaDestinoID, FechaLlegada, ProductoID, OrdenID) VALUES (@invCercano, @date, @invDestino, DATEADD(DAY, 7, @date), @pProductoID, @pOrdenID)
				SET @invCercano = @thirdNearestInv
				SET @COUNTER = @COUNTER + 1;
			END
		END;


		DECLARE @precioID BIGINT = (SELECT s.PrecioHistoricoID FROM(
		SELECT PrecioHistoricoID, MAX(InicioVigencia) as iv FROM [25.36.158.76,1400].DepartamentoVentas.dbo.PreciosHistoricos WHERE ProductoID = @pProductoID GROUP BY PrecioHistoricoID) as s)
		
		INSERT INTO [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden (OrdenID, ProductoID, Cantidad, precioHistoricoID)
		VALUES (@pOrdenID, @pProductoID, @pCantidad, @precioID);
		SELECT '' 'Error'
	END TRY
	BEGIN CATCH
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Traslados WHERE OrdenID = @pOrdenID;
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.ProductosXOrden WHERE OrdenID = @pOrdenID;
		DELETE FROM [25.36.158.76,1400].DepartamentoVentas.dbo.Ordenes WHERE OrdenID = @pOrdenID;
		SELECT ERROR_MESSAGE() 'Error'
	END CATCH
END;