
<?php  

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
        $details[] = $detail;
    }

?>

<div class="myModal modal_order" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">

        <div class="order_detail_container">
            <p>Orden: <?php echo $order['ordenID']; ?></p>
            <p>Fecha: <?php echo $order['fecha']; ?></p>

            <div class="bill_detail_container">
                <?php for($i = 0; $i < count($details); $i++) { ?>
                    <div class="bill_detail">
                        <div class="detail_product">
                            <p class="numProduct" id="numProduct"><?php echo $details[$i]['cantidad']; ?></p>
                            <p><?php echo $details[$i]['nombre']; ?></p>
                        </div>
                        <div class="price_product_detail">
                            <p class="product_price"> <?php echo $order['simbolo'] ." ". round(floatval($details[$i]['precioProducto']), 2); ?></p>
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
                <p class="totalNum"><?php echo round(floatval($order['costoTotal']), 2); ?></p>
            </div>
            <div class="address_detail">
                <p> <b>Dirección de envío:</b> <span><?php echo $order['direccion']; ?></span></p>
            </div>
        </div>
        <div class="order_status_container order_status_<?php echo $order['estadoID']; ?>">
            <p><?php echo $order['estado']; ?></p>
        </div>
        
    </div><!-- .modal-content -->
</div>