
<?php  
    // se obtiene los datos de la orden con el id de la orden

    // se obtiene los datos de la orden
    $this->db->query("{ CALL Clickship_getEmployeeById(?) }");
    $this->db->bind(1, $data['data']['idEmployee']);

    $employee = $this->db->result();
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
            <p class="name_and_email"><?php echo $employee['nombre']." ".$employee['apellidos']; ?> - <span><?php echo $employee['correo']; ?></span></p>
            <p class="country">Salario: <?php echo $employee['simbolo'] ." ". round(floatval($employee['salario']) ,2); ?></p>
            <p class="department"><?php echo $employee['departamento']." - ".$employee['rol']; ?></p>
            <!-- <p class="hours">Horas Trabajadas en quincena: <span id="worked_hours"></span></p> -->
       </div>

        <div class="employee_salary_container">
            <p>Agregar horas trabajadas</p>
            <form action="" method="post" id="add_hours">
                <div class="col_2">
                    <div class="field">
                        <label for="workedHours">Horas</label>
                        <input type="text" name="workedHours" id="workedHours" require data-mask="00000000">
                    </div>
                    <div class="field">
                        <label for="Day">Día</label>
                        <input type="date" name="workedHours" id="date" require>
                    </div>
                </div>
                <div class="field checkbox">
                    <input type="checkbox" id="training" name="training" value="Bike">
                    <label for="training"> Esta en entrenamiento</label><br>
                </div>
                <div class="submit">
                    <input type="submit" class="btn btn_yellow" value="Agregar">
                    <input type="hidden" data-id-employee="" value="<?php echo $employee['empleadoID']; ?>">
                </div>
            </form>
       </div>

       <div class="calculate_paid">
            <!-- <p>Pago: <span id="calc_paid">120000</span></p> -->
            <button class="btn btn_blue" data-calc-paid="<?php echo $employee['empleadoID']; ?>">Realizar Pago</button>
       </div>

       <div class="paids_container">
        <p>Historial de pagos</p>

        <div class="paids_list" id="employee_history_paids">

        </div>
       </div>
        
    </div><!-- .modal-content -->
</div>