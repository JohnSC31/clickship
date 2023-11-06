<div class="admin_container">
    <div class="header_container">
        <nav class="admin_navigation">
            <div class="admin_logo">
                <img src="<?php echo URL_PATH; ?>public/img/LogoWhite.png" alt="CLICKSHIP Logo">
            </div>

            <ul id="admin_nav">
                <li class="active" data-admin-nav="sells"><i class="fa-solid fa-cart-shopping"></i> <span class="hide_medium"> Ventas</span></li>
                <li data-admin-nav="inventory" ><i class="fa-solid fa-box" ></i> <span class="hide_medium"> Inventario</span></li>
                <li data-admin-nav="human_resources" ><i class="fa-solid fa-person"></i></i> <span class="hide_medium"> Recursos humanos</span></li>
                <li data-admin-nav="client_service"><i class="fa-solid fa-phone"></i> <span class="hide_medium"> Servicio al cliente</span></li>
            </ul>

        </nav>
        <p class="header_rights hide_medium">Todos los derechos resevados 2023</p>
    </div>
    <div class="dashboard_container" id="dashboard_container">
        <!-- PAGINA DE VENTAS -->
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
        <!-- PAGINA DE INVENTARIO -->
        <div class="inventory_container" style="display:none;">
            <h1>Inventario</h1>
        </div>
        <!-- PAGINA DE RECURSOS HUMANOS -->
        <div class="human_resources_container" style="display:none;">
            <h1>Recursos humanos</h1>
        </div>
        <!-- PAGINA DE SERVICIO AL CLIENTE -->
        <div class="client_service_container" style="display:none;">
            <h1>Servicio al cliente</h1>
        </div>
    </div>
</div>

