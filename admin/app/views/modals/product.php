
<?php  
    // se obtiene los datos de la orden con el id de la orden
    // datos del cliente
    // detalle de la factura
    $idProduct = $data['data']['idProduct'];
?>

<div class="myModal modal_product" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">
        <?php $maxImages = 3; ?>
        <div class="product_imgs_container carrousel_container" id="carrousel-product">
            <?php for($i = 0; $i < $maxImages; $i++) { ?>
                <div class="img img-<?php echo $i; ?>" <?php echo $i !== 0 ? "style='display: none;'" : ""; ?> >
                    <img src="<?php echo URL_PATH; ?>public/img/product2.jpeg" alt="Product Image">
                </div>   
            <?php } ?> 

            <div class="carrousel-btns-container" >
                <button data-carrousel-pass="left" data-carrousel-id="carrousel-product" class="btn btn_yellow"><i class="fa-solid fa-chevron-left"></i></button>
                <button data-carrousel-pass="right" data-carrousel-id="carrousel-product" class="btn btn_yellow"><i class="fa-solid fa-chevron-right"></i></button>
                <input type="hidden" id="input-carrousel-product" data-current-image="1" data-max-image="<?php echo $maxImages-1; ?>">
            </div>   
        </div>
        <form action="" method="post" id="edit_product">
            <div class="col_2">
                <div class="form_column">
                    <div class="field">
                        <label for="name">Nombre del Producto</label>
                        <input type="text" name="name" id="name" require>
                    </div>
                    <div class="field">
                        <label for="catProduct">Categoria Producto</label>
                        <select name="catProduct" id="catProduct" require>
                            <option value="">Categorias</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="store3">Precio</label>
                        <input type="text" name="store3" id="price" data-mask="0000000000000" require>
                    </div>
                    <div class="field">
                        <label for="country">Detalle</label>
                        <textarea name="description" id="detail" cols="30" rows="5" require></textarea>
                    </div>
                    
                </div>
                <div class="form_column">
                    <div class="field">
                        <label for="store1">Cantidad bodega 1</label>
                        <input type="text" name="store1" id="amountStore1" data-mask="00000000" require>
                    </div>
                    <div class="field">
                        <label for="store2">Cantidad bodega 2</label>
                        <input type="text" name="store2" id="amountStore2" data-mask="00000000" require>
                    </div>
                    <div class="field">
                        <label for="store3">Cantidad bodega 3</label>
                        <input type="text" name="store3" id="amountStore3" data-mask="00000000" require>
                    </div>

                    <div class="field">
                        <label for="images">Imagenes (Reemplazar)</label>
                        <input name="images" id="product_images" type="file"  accept="image/*" multiple require>
                    </div>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Editar">
                <input type="hidden" id="idProduct" data-id="<?php echo $idProduct; ?>">
            </div>
        </form>
        
    </div><!-- .modal-content -->
</div>

<!-- JQUERY  -->
<script src="<?php echo URL_PATH; ?>public/js/jquery.mask.js"></script>