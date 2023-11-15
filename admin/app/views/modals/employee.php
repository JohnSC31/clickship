
<?php  
    // se obtiene los datos de la orden con el id de la orden
    // datos del cliente
    // detalle de la factura
?>

<div class="myModal modal_employee" >

    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>

    <div class="modal-content">
       <div class="employee_card_container">
            <div class="employee_photo">
                <i class="fa-solid fa-user"></i>
            </div>
            <p class="name_and_email">Nombre del empleado - <span>jostsace05@gmail.com</span></p>
            <p class="country">Costa Rica</p>
            <p class="department">Departamento</p>
            <p class="hours">Horas Trabajadas: <span id="worked_hours">10</span></p>
       </div>

        <div class="employee_salary_container">
            <p>Agregar horas trabajadas</p>
            <form action="" method="post" id="add_hours">
                <div class="col_2">
                    <div class="field">
                        <label for="salary">Horas</label>
                        <input type="text" name="salary" id="salary" require data-mask="00000000">
                    </div>
                    <div class="field">
                        <label for="Day">Día</label>
                        <select name="Day" id="Day" require>
                            <option value="">Días</option>
                            <option value="1">Lunes</option>
                            <option value="2">Martes</option>
                            <option value="3">Miercoles</option>
                            <option value="4">Jueves</option>
                            <option value="5">Viernes</option>
                            <option value="6">Sábado</option>
                            <option value="7">Domingo</option>
                        </select>
                    </div>

                </div>
                <div class="submit">
                    <input type="submit" class="btn btn_yellow" value="Agregar">
                </div>
            </form>
       </div>

       <div class="calculate_paid">
            <p>Pago: <span id="calc_paid">120000</span></p>
            <button class="btn btn_blue">Calcular Pago</button>
       </div>
        
    </div><!-- .modal-content -->
</div>