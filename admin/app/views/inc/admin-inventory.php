<div class="inventory_container" style="display:none;">
    <h1>Inventario</h1>

    <div class="add_product_form_container">
        <p class="form_title">Agrega un producto</p>
        <form action="" method="post" id="add_product">
            <div class="col_2">
                <div class="">
                    <div class="field">
                        <label for="name">Nombre del Producto</label>
                        <input type="text" name="name" id="name">
                    </div>
                    <div class="field">
                        <label for="catProduct">Categoria Producto</label>
                        <select name="catProduct" id="catProduct">
                            <option value="">Categorias</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="store">Bodega</label>
                        <select name="store" id="store">
                            <option value="">Bodegas</option>
                            <option value="1">Bodega 1</option>
                            <option value="2">Bodega 2</option>
                            <option value="3">Bodega 3</option>
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
                        <input name="images" id="product_images" type="file"  accept="image/*"/>
                    </div>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
            </div>
        </form>
    </div>

    <div class="table-inventory-container datatable-container">
        <table id="inventory-table" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                    <th width="5%">Id</th>
                    <th width="25%">Producto</th>
                    <th width="20%">Categoria</th>
                    <th width="10%">Precio</th>
                    <th width="15%">Cantidad</th>
                    <th width="15%">Acciones</th>
                </tr>
            </thead>
        </table>
    </div>
</div>