
<!-- SEARCH BAR -->
<section class="search_product">
    <div class="container">
        <div class="search_bar">
            <input type="text" id="product_search" name="product_search" placeholder="Buscar">
            <a href="javascript:void(0);"> <i class="fa-solid fa-magnifying-glass"></i> </a>
            
        </div>
    </div>
</section>

<section class="filters container">
    <p>Filtros</p>
    <div class="filters_container">
        <select name="categories" id="select_categorie">
            <!-- se cargan las categorias de la base de datos -->
            <option value="" selected>Categorias</option>
        </select>

        <select name="currencies" id="select_currency">
            <!-- se cargan las monedas de la base de datos -->
            <option value="" selected >Monedas</option>
        </select>
    </div>

</section>
<section class="product_list container" id="product_list">

</section>