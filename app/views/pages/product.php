
<?php
    $product = []; // se obtiene desde la base
    $data['idProduct'];
    
    $images = ['image1', 'image2', 'image3'];
    $maxImages = count($images);
?>

<div class="product_container">
    <div class="product_item">
        <!-- <div class="img_product" style="background-image: url(<?php echo URL_PATH; ?>public/img/product.jpeg)"></div> -->

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

        <div class="product_detail">
            <p>Nombre de producto</p>
            <p class="price">$30</p>
            <p class="detail">
                Detalle del producto en el que el cliente esta interesado, con todas las caracteristicas y funcionalidad de ser necesario.
            </p>
            <div class="product_action">
                <a href="javascript:void(0);" class="btn btn_yellow" 
                data-cart="add" data-id="<?php echo $data['idProduct']; ?>" data-name="Producto <?php echo $data['idProduct']; ?>" data-price="15"> <i class="fa-solid fa-plus"></i> Agregar</a>
            </div>
        </div>
    </div>
</div>