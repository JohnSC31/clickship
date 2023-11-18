
<?php


    $this->db->query("{ CALL Clickship_getProductoById(?) }");
    // obtener el nombre, apellidos e email para el perfil
    $this->db->bind(1, $data['idProduct']);
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

<div class="product_container">

    <div class="product_item" data_item="<?php echo $product['idProducto']; ?>">
        <!-- <div class="img_product" style="background-image: url(<?php echo URL_PATH; ?>public/img/product.jpeg)"></div> -->

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

        <div class="product_detail">
            <p><?php echo $product['nombre']; ?></p>
            <p class="price"><?php echo $product['simbolo']." ". round(floatval($product['precio']), 2); ?></p>
            <p class="detail">
                <?php echo $product['descripcion']; ?>            
            </p>
            <div class="product_action">
                <a href="javascript:void(0);" class="btn btn_yellow <?php echo !isset($_SESSION['CLIENT']) ? "disabled" : ""; ?>" 
                data-cart="add" data-id="<?php echo $product['idProducto']; ?>" data-name="<?php echo $product['nombre']; ?>" data-price="<?php echo round(floatval($product['precio']), 2);?>"> <i class="fa-solid fa-plus"></i> Agregar</a>
            </div>
        </div>
    </div>
</div>