
<!-- SEARCH BAR -->
<section class="search_product">
    <div class="container">
        <div class="search_bar">
            <input type="text" id="producto_search" name="product_search" placeholder="Buscar">
            <a href="javascript:void(0);"> <i class="fa-solid fa-magnifying-glass"></i> </a>
            
        </div>
    </div>
</section>


<section class="product_list container" id="product_list">
    <?php for($i = 0; $i < 8; $i++){ ?>
        <div class="product_item" data-item="<?php echo $i; ?>">
            <div class="img_product" style="background-image: url(<?php echo URL_PATH; ?>public/img/product.jpeg)"></div>
            <div class="product_detail">
                <p>Nombre de producto</p>
                <p class="price">$30</p>
                <div class="product_action">
                    <a href="javascript:void(0);" class="btn btn_yellow <?php echo !isset($_SESSION['CLIENT']) ? "disabled" : ""; ?>" 
                    data-cart="add" data-id="<?php echo $i; ?>" data-name="Producto <?php echo $i; ?>" data-price="15"> <i class="fa-solid fa-plus"></i> Agregar</a>
                </div>
            </div>
        </div>
    <?php } ?>

</section>