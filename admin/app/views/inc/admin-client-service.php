<div class="client_service_container" style="display:none;">
    <h1>Servicio al cliente</h1>

    <div class="add_call_form_container">
        <p>Agregar llamada</p>
        <form action="" method="post" id="add_call">
            <div class="col_2">
                <div class="form_column">
                    <div class="field">
                        <label for="idOrder">Id de la orden</label>
                        <input type="text" name="idOrder" id="idOrder" require data-mask="000000000">
                    </div>
                    <div class="field">
                        <label for="questionType">Tipo de Pregunta</label>
                        <select name="questionType" id="questionType" require>
                            <option value="">Tipos</option>
                            <option value="1">Categoria 1</option>
                            <option value="2">Categoria 2</option>
                            <option value="3">Categoria 3</option>
                        </select>
                    </div>    
                </div>
                <div class="form_column">
                    <div class="field">
                        <label for="country">Descripcion</label>
                        <textarea name="description" id="call_detail" cols="30" rows="6" require></textarea>
                    </div>
                </div>
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_yellow" value="Agregar">
            </div>
        </form>
    </div>

    <div class="table-service-container datatable-container">
        <table id="service-table" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                    <th width="25%">Cliente</th>
                    <th width="10%">Tipo</th>
                    <th width="25%">Empleado</th>
                    <th width="20%">Fecha</th>
                    <th width="10%">Id de Orden</th>
                    <th width="10%">Acciones</th>
                </tr>
            </thead>
        </table>
    </div>
    
</div>