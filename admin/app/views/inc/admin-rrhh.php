<div class="human_resources_container" style="display:none;">
    <h1>Recursos humanos</h1>

    <div class="add_product_form_container">
        <p class="form_title">Agrega un empleado</p>
        <form action="" method="post" id="add_employee">
            <div class="col_2">
                <div class="form_column">
                    <div class="field">
                        <label for="name">Nombre</label>
                        <input type="text" name="name" id="name" require>
                    </div>
                    <div class="field">
                        <label for="lastname">Apellido</label>
                        <input type="text" name="lastname" id="lastname" require>
                    </div>
                    <div class="field">
                        <label for="email">Correo electronico</label>
                        <input type="email" name="email" id="email" require>
                    </div>

                    <div class="field">
                        <label for="country">Pais</label>
                        <select name="country" id="country" require>
                            <option value="">Categorias</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>
                    
                </div>
                <div class="form_column">

                    <div class="field">
                        <label for="rol">Rol</label>
                        <select name="rol" id="rol" require>
                            <option value="">Categorias</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="department">Departamento</label>
                        <select name="department" id="department" require>
                            <option value="">Categorias</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="salary">Salario</label>
                        <input type="text" name="salary" id="salary" require>
                    </div>
                    <div class="field">
                        <label for="currency">Moneda</label>
                        <select name="currency" id="currency" require>
                            <option value="">Categorias</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>

                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
            </div>
        </form>
    </div>

    <div class="table-rrhh-container datatable-container">
        <table id="rrhh-table" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                    <th width="25%">Nombre Completo</th>
                    <th width="20%">Correo</th>
                    <th width="15%">Pais</th>
                    <th width="15%">Rol</th>
                    <th width="15%">Departamento</th>
                    <th width="5%">Acciones</th>
                </tr>
            </thead>
        </table>
    </div>

</div>