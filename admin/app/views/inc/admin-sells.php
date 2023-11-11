<div class="sells_container">
    <h1>Ventas</h1>
    <div class="sell_report_container">
        <form action="" method="post" id="sells_report">
            <div class="field">
                <label for="catProduct">Categoria Producto</label>
                <select name="catProduct" id="catProduct">
                    <option value="">Categoria 1</option>
                    <option value="">Categoria 2</option>
                    <option value="">Categoria 3</option>
                </select>
            </div>
            <div class="field">
                <label for="product">Producto</label>
                <select name="product" id="product">
                    <option value="">Producto 1</option>
                    <option value="">Producto 2</option>
                    <option value="">Producto 3</option>
                </select>
            </div>
            <div class="field">
                <label for="country">Pais</label>
                <select name="country" id="country">
                    <option value="">Pais 1</option>
                    <option value="">Pais 2</option>
                    <option value="">Pais 3</option>
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
            <div class="field">
                <label for="startDate">Fechas</label>
                <input type="date" name="startDate" id="startDate">
            </div>
            <div class="field">
                <input type="date" name="endDate" id="endDate">
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Consultar">
            </div>
        </form>

        <div class="report_result">
            <p>Total ventas: <span class="sells_result">6356688</span></p>
        </div>
    </div>
</div>