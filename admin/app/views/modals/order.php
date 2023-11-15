
<?php  
    // se obtiene los datos de la orden con el id de la orden
    $idOrder = $data['data']['idOrder'];
    // datos del cliente
    // detalle de la factura
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
                <p>John Sánchez Cespedes</p>
                <P>jostsace05@gmail.com</P>
            </div>
        </div>
        <div class="order_detail_container">
            <p>Orden: ID23445</p>
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
                <p class="totalNum">45</p>
            </div>
            <div class="address_detail">
                <p> <b>Dirección de envío:</b> <span>San isidro del general, Costa Rica</span></p>
            </div>
        </div>
        <div class="order_action_container">
            <button class="btn btn_blue" data-update-order-status="idStatus" data-id-order="idOrder">Finalizar</button>
        </div>
        
    </div><!-- .modal-content -->
</div>