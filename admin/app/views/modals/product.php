
<?php  

    // obtener las categorias de los productos
    $this->db->query("{ CALL Clickship_getCategories()}");
    $categories = $this->db->results(); // se obtienen de la base de datos

    $this->db->query("{ CALL Clickship_getProductoById(?) }");
    // obtener el nombre, apellidos e email para el perfil
    $this->db->bind(1, $data['data']['idProduct']);
    $productsAndImg = $this->db->results();
    // var_dump($productsAndImg[0]);
    $product = get_object_vars($productsAndImg[0]); // se obtiene el producto
    // Imagenes
    $images = array();
    foreach($productsAndImg as $key => $productImg){
        if($productImg->foto != NULL){
            $images[] = $productImg->foto;
        }

    }
    $maxImages = count($images) !== 0 ? count($images) : 1;

?>

<div class="myModal modal_product" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">
        <div class="product_imgs_container carrousel_container" id="carrousel-product">
        <?php if(count($images) > 0){

            for($i = 1; $i <= $maxImages; $i++) { ?>
                <div class="img img-<?php echo $i; ?>" <?php echo $i !== 1 ? "style='display: none;'" : ""; ?> >
                    <img src="data:image/png;base64,<?php echo base64_encode($images[$i - 1]); ?>" alt="productImage">
                </div>   
            <?php } 

        }else{ ?>

            <div class="img img-1">
                    <img src="<?php echo URL_PATH; ?>public/img/default.jpg" alt="Product Image">
            </div> 

        <?php } ?> 

            <div class="carrousel-btns-container" >
                <button data-carrousel-pass="left" data-carrousel-id="carrousel-product" class="btn btn_yellow"><i class="fa-solid fa-chevron-left"></i></button>
                <button data-carrousel-pass="right" data-carrousel-id="carrousel-product" class="btn btn_yellow"><i class="fa-solid fa-chevron-right"></i></button>
                <input type="hidden" id="input-carrousel-product" data-current-image="1" data-max-image="<?php echo $maxImages; ?>">
            </div>   
        </div>

        <form action="" method="post" id="edit_product">
            <div class="col_2">
                <div class="form_column">
                    <div class="field">
                        <label for="name">Nombre del Producto</label>
                        <input type="text" name="name" id="name" require value="<?php echo $product['nombre'];?>">
                    </div>
                    <div class="field">
                        <label for="catProduct">Categoria Producto</label>
                        <select name="catProduct" id="catProduct" require>
                            <?php foreach($categories as $categorie) { ?>
                                <option value="<?php echo $categorie->idTipoProducto ?>" <?php echo $product['idTipoProducto'] === $categorie->idTipoProducto ? "selected" : "" ?> > 
                                <?php echo $categorie->tipoProducto; ?> </option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="field">
                        <label for="store3">Precio</label>
                        <input type="text" name="store3" id="price" require value="<?php echo round(floatval($product['precio']),2);?>">
                    </div>
                    <div class="field">
                        <label for="country">Detalle</label>
                        <textarea name="description" id="detail" cols="30" rows="5" require><?php echo $product['descripcion']; ?></textarea>
                    </div>
                    
                </div>
                <div class="form_column">
                    <div class="field">
                        <label for="weight">Peso</label>
                        <input type="text" name="weight" id="weight" require value="<?php echo $product['peso'];?>">
                    </div>
                    <div class="field">
                        <label for="store1">Bodega Norte</label>
                        <input type="text" name="store1" id="amountStore1" data-mask="00000000" require value="<?php echo $product['cantidadNorte'];?>">
                    </div>
                    <div class="field">
                        <label for="store2">Bodega Caribe</label>
                        <input type="text" name="store2" id="amountStore2" data-mask="00000000" require value="<?php echo $product['cantidadCaribe'];?>">
                    </div>
                    <div class="field">
                        <label for="store3">Bodega Sur</label>
                        <input type="text" name="store3" id="amountStore3" data-mask="00000000" require value="<?php echo $product['cantidadSur'];?>">
                    </div>

                    <div class="field">
                        <label for="images">Imagenes (Reemplazar)</label>
                        <input name="images" id="product_images" type="file"  accept="image/*" multiple require>
                    </div>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Editar">
                <input type="hidden" id="idProduct" data-id="<?php echo $product['idProducto']; ?>">
            </div>
        </form>
        
    </div><!-- .modal-content -->
</div>

<!-- JQUERY  -->
<script src="<?php echo URL_PATH; ?>public/js/jquery.mask.js"></script>