
<?php  
    // se obtiene los datos de la orden con el id de la llamada
    
    $this->db->query("{ CALL Clickship_getLlamadaById(?) }");
    $this->db->bind(1, $data['data']['idCall']);

    $call = $this->db->result();
?>

<div class="myModal modal_call" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">

        <div class="order_client_container">
            <div class="picture">
                <i class="fa-solid fa-user-circle"></i>
            </div>
            <div>
                <p><?php echo $call['cliente']; ?></p>
                <p><?php echo $call['correo']; ?></p>
            </div>
        </div>

        <div class="order_call_summary order_status_<?php echo $call['EstadoActualID']; ?>">
            <p>Orden: <?php echo $call['idOrden']; ?></p>
            <p><?php echo $call['Estado']; ?></p>
        </div>
        <div class="detail_call_container">
            <p class="tags"><span><?php echo $call['tipoPregunta']; ?></span> -  <span><?php echo date('j-n-Y', strtotime($call['fecha'])); ?></span></p>
            <p class="description"><?php echo $call['descripcion']; ?></p>
        </div>
        
    </div><!-- .modal-content -->
</div>