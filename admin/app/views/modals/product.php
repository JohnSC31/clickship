
<?php  
    // se obtiene los datos de la orden con el id de la orden
    // datos del cliente
    // detalle de la factura
?>

<div class="myModal modal_product" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">
        <div class="product_imgs_container">
            <div class="img">
                <img src="<?php echo URL_PATH; ?>public/img/product2.jpeg" alt="Product Image">
            </div>       
        </div>
        <form action="" method="post" id="edit_product">
            <div class="col_2">
                <div class="">
                    <div class="field">
                        <label for="name">Nombre del Producto</label>
                        <input type="text" name="name" id="name">
                    </div>
                    <div class="field">
                        <label for="catProduct">Categoria Producto</label>
                        <select name="catProduct" id="catProduct">
                            <option value="">Categoria 1</option>
                            <option value="">Categoria 2</option>
                            <option value="">Categoria 3</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="store">Bodega</label>
                        <select name="store" id="store">
                            <option value="">Bodega 1</option>
                            <option value="">Bodega 2</option>
                            <option value="">Bodega 3</option>
                        </select>
                    </div>
                </div>
                <div class="">
                    <div class="field">
                        <label for="country">Detalle</label>
                        <textarea name="description" id="detail" cols="30" rows="10" require></textarea>
                    </div>
                    <div class="field">
                        <label for="images">Imagenes</label>
                        <input type="file">
                    </div>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Editar">
            </div>
        </form>
        
    </div><!-- .modal-content -->
</div>