
<?php  
    // se obtiene los datos de la orden con el id de la orden

    // se obtiene los datos de la orden
    $this->db->query("{ CALL Clickship_getOrderById(?) }");
    $this->db->bind(1, $data['data']['idOrder']);

    $order = $this->db->result();
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
                <?php for($i = 0; $i < 5; $i++) { ?>
                    <div class="bill_detail">
                        <div class="detail_product">
                            <p class="numProduct" id="numProduct"><?php echo "3"; ?></p>
                            <p><?php echo "Nombre del producto"; ?></p>
                        </div>
                        <div class="price_product_detail">
                            <p class="product_price">$ <?php echo "15" ?></p>
                            <p class="product_total_price">$<?php echo "35" ?></p>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
        <div class="order_summary">
            <div class="total">
                <p>Total</p>
                <p class="totalNum"><?php echo $order['simbolo']." ".$order['costoTotal']; ?></p>
            </div>
            <div class="address_detail">
                <p> <b>Dirección de envío:</b> <span><?php echo $order['direccion']; ?></span></p>
            </div>
        </div>
        <div class="order_action_container">
            <!-- manejo de los estados -->
            <button class="btn btn_blue" data-update-order-status="idStatus" data-id-order="<?php echo $order['ordenID']; ?>">Finalizar</button>
        </div>
        
    </div><!-- .modal-content -->
</div>