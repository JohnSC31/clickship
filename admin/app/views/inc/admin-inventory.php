<div class="inventory_container" style="display:none;">
    <h1>Inventario</h1>

    <div class="add_product_from_container">
        <form action="" method="post" id="add_product">
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
            <label for="country">Detalle</label>
            <textarea name="description" id="detail" cols="30" rows="10" require></textarea>
        </div>

        <div class="field">
            <label for="store">Bodega</label>
            <select name="store" id="store">
                <option value="">Bodega 1</option>
                <option value="">Bodega 2</option>
                <option value="">Bodega 3</option>
            </select>
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
                    <th>Venta</th>
                    <th>Cliente</th>
                    <th>Estado</th>
                    <th>Bodega</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Tiger Nixon</td>
                    <td>System Architect</td>
                    <td>Edinburgh</td>
                    <td>61</td>
                    <td>$320,800</td>
                </tr>
                <tr>
                    <td>Garrett Winters</td>
                    <td>Accountant</td>
                    <td>Tokyo</td>
                    <td>63</td>
                    <td>$170,750</td>
                </tr>
                <tr>
                    <td>Ashton Cox</td>
                    <td>Junior Technical Author</td>
                    <td>San Francisco</td>
                    <td>66</td>
                    <td>$86,000</td>
                </tr>
                <tr>
                    <td>Cedric Kelly</td>
                    <td>Senior Javascript Developer</td>
                    <td>Edinburgh</td>
                    <td>22</td>
                    <td>$433,060</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>