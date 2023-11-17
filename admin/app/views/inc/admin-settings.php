<div class="settings_container" style="display:none;">
    <h1>Configuraciones</h1>
    <!-- PARA ROLES -->
    <div class="config_container">
        <h3>Roles</h3>
        
        <form action="" method="post" id="config_roll">
            <div class="col_2">
                <div class="field">
                    <label for="rol">Rol</label>
                    <input type="text" name="rol" id="rol" require>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
                <input type="hidden" id="rolID" value="">
                <input type="hidden" id="action" value="add">
            </div>
        </form>
        <p>Roles</p>
        <div class="config_list_container" id="config_roll_list">

            <!-- ROLES -->

        </div>
    </div>

    <!-- PARA MONEDAS -->
    <div class="config_container">
        <h3>Monedas</h3>
        
        <form action="" method="post" id="config_currency">
            <div class="field">
                <label for="rol">Nombre</label>
                <input type="text" name="rol" id="currency" require>
            </div>
            <div class="col_2">
                <div class="field">
                    <label for="rol">Acronimo</label>
                    <input type="text" name="rol" id="acronym" require>
                </div>
                <div class="field">
                    <label for="rol">Simbolo</label>
                    <input type="text" name="rol" id="symbol" require>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
                <input type="hidden" id="currencyID" value="">
                <input type="hidden" id="action" value="add">
            </div>
        </form>
        <p>Monedas</p>
        <div class="config_list_container" id="config_currency_list">

            <!-- MONEDAS -->

        </div>
    </div>

    <!-- PARA PAISES -->
    <div class="config_container">
        <h3>Paises</h3>
        
        <form action="" method="post" id="config_country">
            <div class="field">
                <label for="rol">Nombre</label>
                <input type="text" name="rol" id="country" require>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
                <input type="hidden" id="countryID" value="">
                <input type="hidden" id="action" value="add">
            </div>
        </form>
        <p>Paises</p>
        <div class="config_list_container" id="config_country_list">

            <!-- PAISES -->

        </div>
    </div>

    <!-- PARA Categorias Productos -->
    <div class="config_container">
        <h3>Categorias Productos</h3>
        
        <form action="" method="post" id="config_categorie">
            <div class="field">
                <label for="rol">Categoria</label>
                <input type="text" name="rol" id="categorie" require>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
                <input type="hidden" id="categorieID" value="">
                <input type="hidden" id="action" value="add">
            </div>
        </form>
        <p>Categorias Productos</p>
        <div class="config_list_container" id="config_categorie_list">

            <!-- Categorias Productos -->

        </div>
    </div>
    
</div>