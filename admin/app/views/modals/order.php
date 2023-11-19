
<?php  
    // se obtiene los datos de la orden con el id de la orden
    // se obtiene los datos de la orden
    $this->db->query("{ CALL Clickship_getOrderById(?) }");
    $this->db->bind(1, $data['data']['idOrder']);

    $orderxProduct = $this->db->results();
    $order = get_object_vars($orderxProduct[0]); // se obtiene la orden
    // detalles
    $details = array();

    foreach($orderxProduct as $key => $detailProduct){

        $detail = array();
        $detail['nombre'] = $detailProduct->nombre;
        $detail['cantidad'] = $detailProduct->cantidad;
        $detail['precioProducto'] = $detailProduct->precioProducto;
        $detail['productoEnEnvio'] = boolval($detailProduct->productoEnEnvio);
        $details[] = $detail;
    }

?>

<div class="myModal modal_order" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">
        <div class="order_client_container">
            <div class="picture">
                <i class="fa-solid fa-user-circle"></i>
            </div>
            <div>
                <p><?php echo $order['nombreCliente']; ?></p>
                <p><?php echo $order['correo']; ?></p>
            </div>
        </div>
        <div class="order_detail_container">
            <p>Orden: <?php echo $order['ordenID']; ?></p>

            <div class="bill_detail_container">
                <?php for($i = 0; $i < count($details); $i++) { ?>
                    <div class="bill_detail">
                        <div class="detail_product">
                            <p class="numProduct" id="numProduct"><?php echo $details[$i]['cantidad']; ?></p>
                            <p><?php echo $details[$i]['nombre']; 
                            echo ($details[$i]['productoEnEnvio']) ? '<i class="fa-solid fa-truck-fast"></i>' : ""; ?>
                            </p>
                        </div>
                        <div class="price_product_detail">
                            <p class="product_price"><?php echo $order['simbolo'] ." ". round(floatval($details[$i]['precioProducto']), 2); ?></p>
                            <p class="product_total_price">
                                <?php echo $order['simbolo'] ." ". (floatval($details[$i]['precioProducto']) * intval($details[$i]['cantidad'])) ; ?>
                            </p>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
        <div class="order_summary">
            <div class="total">
                <p>Total</p>
                <p class="totalNum"><?php echo $order['simbolo']." ". round(floatval($order['costoTotal']), 2); ?></p>
            </div>
            <div class="address_detail">
                <p> <b>Dirección de envío:</b> <span><?php echo $order['direccion']; ?></span></p>
            </div>
        </div>
        <div class="order_action_container">
            <!-- manejo de los estados -->
            <?php
                $btnActionData = array(
                    1 => [2, "Procesar"],
                    2 => [3, "Finalizar"],
                    3 => [4, "Revisar"],
                );
            ?>
            <button class="btn btn_blue" data-update-order-status="<?php echo $btnActionData[$order['estadoID']][0]; ?>" data-id-order="<?php echo $order['ordenID']; ?>"> <?php echo $btnActionData[$order['estadoID']][1];  ?></button>
        </div>
        
    </div><!-- .modal-content -->
</div>