<?php 
    // CONTROLLADOR PARA LAS PETICIONES AJAX Y CONECIONES CON LA BASE DE DATOS
    if (!$_SERVER['REQUEST_METHOD'] === 'POST') { // se verifica que sea una peticion autentica
	    die('Invalid Request');
    }

    require_once '../../../app/config.php';
    require_once '../../../app/lib/Db.php';
    


    class Ajax {
        private $controller = "Ajax";
        private $ajaxMethod;
        private $data;
        private $db;

        public function __construct(){
            $this->db = new Db;
            $this->ajaxMethod = isset($_POST['ajaxMethod']) ? $_POST['ajaxMethod'] : NULL ;
            unset($_POST['ajaxMethod']);

            $this->data = [$_POST];

            if(method_exists($this->controller, $this->ajaxMethod)){
                call_user_func_array([$this->controller, $this->ajaxMethod], $this->data);
            }else{
                $this->ajaxRequestResult(false, "Metodo inexistente");
            }
        }

        //E: bool, str
        //S: none
        // Metodo para enviar las respuestas de ajax al js mediante un echo
        private function ajaxRequestResult($success = false, $message = 'Error desconocido', $dataResult = NULL){
            $result = array(
                'Success' => $success,
                'Message' => $message,
                'Data'    => $dataResult
            );
            echo json_encode($result);
        }

        // Metodo para la carga de los modals
        private function loadModal($data){
            require_once '../views/modals/'. $data['modal'] . '.php';
        }


        // Metodo de prueba
        private function foo($data){
            $this->ajaxRequestResult(true, $data['message']);
        }
        
        // --------------------------- SESSION DEL ADMINISTRADOR -------------------------------------------
        private function adminLogin($admin){

            // se validan las credenciales
            $this->db->query("{ CALL Clickship_loginEmployee(?, ?) }");

            $this->db->bind(1, $admin['email']);
            $this->db->bind(2, $admin['pass']);

            $loggedEmployee = $this->db->result();

            if($this->isErrorInResult($loggedEmployee)){
                $this->ajaxRequestResult(false, $loggedEmployee['Error']);

            }else{

                // se inicia sesion de administrador
                $adminSession = array(
                    'SESSION' => TRUE,
                    'ID' => $loggedEmployee['empleadoID'],
                    'EMIAL' => $loggedEmployee['correo'],
                    'NAME' => $loggedEmployee['apellidos'],
                    'ROLE' => $loggedEmployee['rol'],
                    // 'ROLE' => 'Gerente General'
                );

                $_SESSION['ADMIN'] = $adminSession;

                if(isset($_SESSION['ADMIN'])){
                    $this->ajaxRequestResult(true, "Se ha iniciados sesion");
                }else{
                    $this->ajaxRequestResult(false, "Error al iniciar sesion");
                }
            }

        }

        private function adminLogout($admin){
            unset($_SESSION['ADMIN']); 

            if(!isset($_SESSION['ADMIN'])){
              
                $this->ajaxRequestResult(true, "Se ha cerrado sesion");
            }else{ 
                $this->ajaxRequestResult(false, "Error al cerrar sesion");
            }
        }

        // --------------------------- SECCION DE VENTAS -------------------------------------------
        // metodo para cargar las data table de ventas
        private function loadDataTableSells($REQUEST){
            // se realiza la consulta a la base de datos
            $this->db->query("{ CALL Clickship_getVentas() }");
            // NULLOS PORQUE TRAEN TODOS LOS RESULTADOS

            $sells = $this->db->results(); // se obtienen de la base de datos
            $totalRecords = count($sells);

            // var_dump($employees);

            $dataTableArray = array();

            foreach($sells as $key => $row){
                $row = get_object_vars($row);
                $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='order' data-modal-data='{\"idOrder\": ".$row['ordenID']."}'><i class='fa-solid fa-eye'></i></button>";

                $sub_array = array();
                $sub_array['idSell'] = $row['ordenID'];
                $sub_array['clientName'] = $row['nombreCliente'];
                $sub_array['status'] = $row['estado'];
                $sub_array['date'] = date('j-n-Y', strtotime($row['fecha']));
                $sub_array['actions'] = $btnDetail;
                $dataTableArray[] = $sub_array;
            }

            echo $this->dataTableOutput(intval($REQUEST['draw']), $totalRecords, $totalRecords, $dataTableArray);

        }

        //METODO PARA CAMBIAR EL ESTADO DE UNA ORDEN CON FORME SE PROCESA
        private function changeOrderStatus($order){

            // se cambia el estado en la base de datos

            $this->db->query("{ CALL Clickship_postCambioEstado(?, ?) }");
            $this->db->bind(1, $order['id']);
            $this->db->bind(2, $order['idStatus']);

            $changeStatusResult = $this->db->result(); // se obtienen de la base de datos

            if($this->isErrorInResult($changeStatusResult)){
                $this->ajaxRequestResult(false, $changeStatusResult['Error']);
                return;
            }

            $this->ajaxRequestResult(true, "Se ha cambiado el estado", $order);
        }
        // --------------------------- SECCION DE INVENTARIO ---------------------------------------
        // metodo para cargas la datatable de inventario
        private function loadDataTableInventory($REQUEST){
            // se realiza la consulta a la base de datos

            $this->db->query("{ CALL Clickship_getProductos(?, ?) }");
            // NULLOS PORQUE TRAEN TODOS LOS RESULTADOS
            $this->db->bind(1, NULL);
            $this->db->bind(2, NULL);

            $products = $this->db->results(); // se obtienen de la base de datos
            $totalRecords = count($products);

            // var_dump($products);

            $dataTableArray = array();

            foreach($products as $key => $row){
                $row = get_object_vars($row);
                $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='product' data-modal-data='{\"idProduct\": ".$row['idProducto']."}'><i class='fa-solid fa-pen'></i></button>";
                $btnDelete = "<button type='button' class='btn btn-danger btn-sm' data-delete-product='".$row['idProducto']."'><i class='fa-solid fa-trash'></i></button>";

                $sub_array = array();
                $sub_array['id'] = $row['idProducto'];
                $sub_array['name'] = $row['nombre'];
                $sub_array['categorie'] = $row['tipoProducto'];
                $sub_array['price'] = $row['simbolo']." ".round(floatval($row['precio']), 2);
                $sub_array['amount'] = $row['cantidad'];
                $sub_array['actions'] = $btnDetail . $btnDelete;
                $dataTableArray[] = $sub_array;
            }

            echo $this->dataTableOutput(intval($REQUEST['draw']), $totalRecords, $totalRecords, $dataTableArray);
        }

        // metodo para eliminar un producto de la base de datos
        
        private function adminProducts($product){

            if($product['action'] === "add"){
                    
                $this->db->query("{ CALL Clickship_postProduct(?,?,?,?,?,?,?,?)}");
                $this->db->bind(1, $product['name']);
                $this->db->bind(2, intval($product['amountStore1']));
                $this->db->bind(3, intval($product['amountStore2']));
                $this->db->bind(4, intval($product['amountStore3']));
                $this->db->bind(5, $product['detail']);
                $this->db->bind(6, floatval($product['weight']));
                $this->db->bind(7, intval($product['idCategorie']));
                $this->db->bind(8, floatval($product['price']));
                

                $addedProductResult = $this->db->result();

                if($this->isErrorInResult($addedProductResult)){
                    $this->ajaxRequestResult(false, "Error al agregar: ". $addedProductResult['Error']);
                    return;
                }else{
                    // se insertan las imagenes

                    if(count($_FILES) > 0){
                        foreach($_FILES as $key => $image){

                            $this->db->query("{ CALL Clickship_postProductImage(?,?)}");
                            $this->db->bind(1, $addedProductResult['productoID']);
                            $this->db->bind(2, base64_encode(file_get_contents($_FILES[$key]['tmp_name'])));
                            // $this->db->bind(2, iconv('','UTF-8', $fp), PDO::PARAM_LOB);
                            $imageResult = $this->db->result();
                            if($this->isErrorInResult($imageResult)){
                                $this->ajaxRequestResult(false, "Agregado img " . $imageResult['Error']);
                                return;
                            }
                        }
                        $this->ajaxRequestResult(true, "Se ha creado el producto correctamente");
                        
                    }else{
                        // no hay imagenes para insertar
                        $this->ajaxRequestResult(true, "Se ha creado producto");
                    }
                    
                }

            }

            if($product['action'] === "edit"){

                $this->db->query("{ CALL Clickship_patchProduct(?,?,?,?,?,?,?,?,?)}");
                $this->db->bind(1, intval($product["id"]));
                $this->db->bind(2, $product['name']);
                $this->db->bind(3, intval($product['amountStore1']));
                $this->db->bind(4, intval($product['amountStore2']));
                $this->db->bind(5, intval($product['amountStore3']));
                $this->db->bind(6, $product['detail']);
                $this->db->bind(7, floatval($product['weight']));
                $this->db->bind(8, intval($product['idCategorie']));
                $this->db->bind(9, floatval($product['price']));

                $editedProductResult = $this->db->result();

                if($this->isErrorInResult($editedProductResult)){
                    $this->ajaxRequestResult(false, "Error al editar: ". $editedProductResult['Error'], $product);
                    return;
                }else{

                    if(count($_FILES) > 0){

                        // se eliminan las imagenes que existen para insertar las nuevas
                        $this->db->query("{ CALL Clickship_deleteFotosProducto(?)}");
                        $this->db->bind(1, $product["id"]);

                        $deletedPhotosProductResult = $this->db->result();

                        if($this->isErrorInResult($deletedPhotosProductResult)){
                            $this->ajaxRequestResult(true, $deletedPhotosProductResult['Error']);

                        }else{
                            $imageResult;
                            foreach($_FILES as $key => $image){

                                $this->db->query("{ CALL Clickship_postProductImage(?,?)}");
                                $this->db->bind(1, $product["id"]);
                                $this->db->bind(2, base64_encode(file_get_contents($_FILES[$key]['tmp_name'])));
        
                                $imageResult = $this->db->result();
                                if($this->isErrorInResult($imageResult)){
                                    $this->ajaxRequestResult(false, "Agregado img " . $imageResult['Error'], $_FILES[$key]['name']);
                                    return;
                                }
                            }
                            $this->ajaxRequestResult(true, "Se ha editado el producto correctamente");
                        }


                        
                    }else{
                        // no hay imagenes para insertar
                        $this->ajaxRequestResult(true, "Se ha editado el producto correctamente");
                    }
                }
                
            }

            if($product['action'] === "delete"){
                // se realiza la eliminacion del producto con el id dado
                
                $this->db->query("{ CALL Clickship_deleteProducto(?)}");
                $this->db->bind(1, $product["id"]);

                $deletedProductResult = $this->db->result();


                if($this->isErrorInResult($deletedProductResult)){
                    $this->ajaxRequestResult(true, $deletedProductResult['Error']);

                }else{
                    $this->ajaxRequestResult(true, "Se ha eliminado el producto");
                }
            }

        }

        // --------------------------- SECCION DE RECURSOS HUMANOS ---------------------------------------
        // metodo para cargas la datatable de recursos humanos
        private function loadDataTableRrhh($REQUEST){
            // se realiza la consulta a la base de datos
            
            $this->db->query("{ CALL Clickship_getEmpleados()}");
            $employees = $this->db->results(); // se obtienen de la base de datos
            $totalRecords = count($employees);

            // var_dump($employees);

            $dataTableArray = array();

            foreach($employees as $key => $row){
                $row = get_object_vars($row);
                $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='employee' data-modal-data='{\"idEmployee\": ".$row["empleadoID"]."}'><i class='fa-solid fa-pen'></i></button>";

                $sub_array = array();
                $sub_array['name'] = $row['nombre'] ." ". $row['apellidos'];
                $sub_array['email'] = $row['correo'];
                $sub_array['country'] = $row['pais'];
                $sub_array['rol'] = $row['rol'];
                $sub_array['department'] = $row['departamento'];
                $sub_array['actions'] = $btnDetail;
                $dataTableArray[] = $sub_array;
            }

            echo $this->dataTableOutput(intval($REQUEST['draw']), $totalRecords, $totalRecords, $dataTableArray);
        }

        // se agrega un empleado a la base de datos
        private function addEmployee($employee){

            $this->db->query("{ CALL Clickship_agregarEmpleado(?,?,?,?,?,?,?,?,?)}");
            $this->db->bind(1, $employee['name']);
            $this->db->bind(2, $employee['lastnames']);
            $this->db->bind(3, $employee['email']);
            $this->db->bind(4, $employee['pass']);
            $this->db->bind(5, intval($employee['idRol']));
            $this->db->bind(6, intval($employee['idCountry']));
            $this->db->bind(7, intval($employee['idDepartment']));
            $this->db->bind(8, intval($employee['salary']));
            $this->db->bind(9, intval($employee['idCurrency']));

            $addEmployeeResult = $this->db->result();

            if($this->isErrorInResult($addEmployeeResult)){
                $this->ajaxRequestResult(false, $addEmployeeResult['Error']);
                return;
            }
            // se agrega el empleado a la base de datos
            $this->ajaxRequestResult(true, "Se ha agregado un empleado");

        }

        // se agregan las horas a la base de datos
        private function addHoursEmployee($employee){
            
            // se realiza la inseccion en la base de datos
            
            $this->db->query("{ CALL Clickship_setHorasEmpleado(?, ?, ?, ?)}");
            $this->db->bind(1, intval($employee['idEmployee']));
            $this->db->bind(2, $employee['date']); // va en string con formato anno-mes-dia
            $this->db->bind(3, intval($employee['hours']));
            $this->db->bind(4, boolval($employee['training']));


            $hoursResult = $this->db->result(); // se obtienen de la base de datos

            if($this->isErrorInResult($hoursResult)){
                $this->ajaxRequestResult(false, $hoursResult['Error'], $employee);
                return;
            }

            $this->ajaxRequestResult(true, "Se ha agregado las horas");

        }

        // se calcula el pago 
        private function calcEmployeePaid($employee){

            $this->db->query("{ CALL Clickship_calcularSalarioEmpleado(?)}");
            $this->db->bind(1, intval($employee['idEmployee']));


            $paidResult = $this->db->result(); // se obtienen de la base de datos

            if($this->isErrorInResult($paidResult)){
                $this->ajaxRequestResult(false, $paidResult['Error'], $employee);
                return;
            }

            $this->ajaxRequestResult(true, "Se ha realizado el pago");
        }

        // se carga el historial de pagos de un empleado
        private function loadModalEmployeePaids($employee){

            $this->db->query("{ CALL Clickship_getHistorialEmpleado(?)}");
            $this->db->bind(1, intval($employee['idEmployee']));

            $paids = $this->db->results(); // se obtienen de la base de datos

            if(count($paids) > 0){
                foreach($paids as $key => $paid){ 
                    $paid = get_object_vars($paid); ?>
                    <div class="paid">
                        <p>Fecha: <?php echo date('j-n-Y', strtotime($paid['fecha'])); ?></p>
                        <p>Horas: <?php echo intval($paid['horasTrabajadas']);?></p>
                        <p>Pago: <?php echo $paid['simbolo'] ." ". round(floatval($paid['montoNeto']), 2);?></p>
                    </div>
    
                <?php }
            }else{ ?>
                <div class="paid no_paids">
                    <p>No hay pagos</p>
                </div>
            <?php }

        }


        // --------------------------- SECCION DE SERVICIO AL CLIENTE ---------------------------------------
        private function loadDataTableService($REQUEST){

            $this->db->query("{ CALL Clickship_getLlamadas()}");
            $calls = $this->db->results(); // se obtienen de la base de datos
            $totalRecords = count($calls);

            // var_dump($calls);

            $dataTableArray = array();

            foreach($calls as $key => $row){
                $row = get_object_vars($row);
                $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='call' data-modal-data='{\"idCall\": ".$row['idLlamada']."}'><i class='fa-solid fa-eye'></i></button>";

                $sub_array = array();
                $sub_array['client'] = $row['cliente'];
                $sub_array['type'] = $row['tipoPregunta'];
                $sub_array['employee'] = $row['empleado'];
                $sub_array['date'] = date('j-n-Y', strtotime($row['fecha']));
                $sub_array['idOrder'] = $row['idOrden'];
                $sub_array['actions'] = $btnDetail;
                $dataTableArray[] = $sub_array;
            }

            echo $this->dataTableOutput(intval($REQUEST['draw']), $totalRecords, $totalRecords, $dataTableArray);
        }

        // metodo para agregar una llamada
        private function addCall($call){
            
            $this->db->query("{ CALL Clickship_postLlamada(?,?,?,?)}");
            $this->db->bind(1, $_SESSION['ADMIN']['ID']);
            $this->db->bind(2, $call['detail']);
            $this->db->bind(3, $call['idQuestionType']);
            $this->db->bind(4, $call['idOrder']);
    

            $adCallResult = $this->db->result();

            if($this->isErrorInResult($adCallResult)){
                $this->ajaxRequestResult(false, $adCallResult['Error']);
                return;
            }

            $this->ajaxRequestResult(true, "Se ha agregado la llamada");
        }

        private function loadSelectOptions($select){

            // se cargan las categorias
            if($select['idSelect'] ===  "catProduct"){
                // carga categorias de home
                $this->db->query("{ CALL Clickship_getCategories()}");
                $categories = $this->db->results(); // se obtienen de la base de datos

                if(count($categories) > 0){ ?>
                    <option value="" selected >Categorias</option>
                    <?php foreach($categories as $categorie) { ?>
                        <option value="<?php echo $categorie->idTipoProducto ?>"> <?php echo $categorie->tipoProducto; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Categorias</option>
                <?php }
            }

            // se cargan los paises
            if($select['idSelect'] ===  "country"){
                // carga paises
                $this->db->query("{ CALL Clickship_getPaises()}");
                $countries = $this->db->results(); // se obtienen de la base de datos
                // var_dump($countries);

                if(count($countries) > 0){ ?>
                    <option value="" selected >Paises</option>
                    <?php foreach($countries as $country) { ?>
                        <option value="<?php echo $country->paisID ?>"> <?php echo $country->nombre; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Paises</option>
                <?php }
            }

            // se cargan los roles
            if($select['idSelect'] ===  "rol"){
                
                $this->db->query("{ CALL Clickship_getRoles()}");
                $rols = $this->db->results(); // se obtienen de la base de datos
                // var_dump($rols);

                if(count($rols) > 0){ ?>
                    <option value="" selected >Roles</option>
                    <?php foreach($rols as $rol) { ?>
                        <option value="<?php echo $rol->rolID ?>"> <?php echo $rol->rol; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Roles</option>
                <?php }
            }

            // se cargan los departamentos
            if($select['idSelect'] ===  "department"){
                // carga categorias de home
                $this->db->query("{ CALL Clickship_getDepartamentos()}");
                $departments = $this->db->results(); // se obtienen de la base de datos
                // var_dump($departments);

                if(count($departments) > 0){ ?>
                    <option value="" selected >Departamentos</option>
                    <?php foreach($departments as $department) { ?>
                        <option value="<?php echo $department->departamentoID ?>"> <?php echo $department->nombre; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Departamentos</option>
                <?php }
            }

            // se cargan las monedas
            if($select['idSelect'] ===  "currency" || $select['idSelect'] ===  "currency_country"){
                
                $this->db->query("{ CALL Clickship_getMonedas()}");
                $currencies = $this->db->results(); // se obtienen de la base de datos
                // var_dump($currencies);

                if(count($currencies) > 0){ ?>
                    <option value="" selected >Monedas</option>
                    <?php foreach($currencies as $currency) { ?>
                        <option value="<?php echo $currency->monedaID ?>"> <?php echo $currency->simbolo." ".$currency->nombre; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Monedas</option>
                <?php }
            }

            // se cargan los tipos de preguntas
            if($select['idSelect'] ===  "questionType"){
                
                $this->db->query("{ CALL Clickship_getCallTypes()}");
                $types = $this->db->results(); // se obtienen de la base de datos
                // var_dump($types);

                if(count($types) > 0){ ?>
                    <option value="" selected >Tipos de preguntas</option>
                    <?php foreach($types as $type) { ?>
                        <option value="<?php echo $type->idtipollamada; ?>"> <?php echo $type->descripcion; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Tipos de preguntas</option>
                <?php }
            }
        }

        // --------------------------- SECCION DE CONFIGURACIONES -------------------------------------------
        private function loadConfigs($data){
            // se cargan los roles para las configuraciones
            if($data['config'] === 'roll'){
                // se cargan los roles
                $this->db->query("{ CALL Clickship_getRoles()}");
                $rolls = $this->db->results(); // se obtienen de la base de datos

                foreach($rolls as $key => $rol){ ?>
                    <div class="config_item">
                        <p><?php echo $rol->rolID ?></p>
                        <p><?php echo $rol->rol; ?></p>
                        <div class="config_actions">
                            <button class="btn btn_edit_config" data-edit-config="roll" data-config='{"rolID":<?php echo $rol->rolID?>, "roll": "<?php echo $rol->rol; ?>"}'><i class="fa-solid fa-pen"></i></button>
                            <!-- <button class="btn btn_delete_config" data-delete-config="roll" data-config='{"idConfig":<?php echo $rol->rolID?>}'><i class="fa-solid fa-trash"></i></button> -->
                        </div>
                    </div>
                <?php }
            }

            if($data['config'] === 'currency'){
                // se cargan las monedas
                $this->db->query("{ CALL Clickship_getMonedas()}");
                $currencies = $this->db->results(); // se obtienen de la base de datos

                foreach($currencies as $key => $currency){ ?>
                    <div class="config_item">
                        <p><?php echo $currency->monedaID; ?></p>
                        <p><?php echo $currency->simbolo ." ".$currency->nombre ." (".$currency->acronimo .")"; ?></p>
                        <div class="config_actions">
                            <button class="btn btn_edit_config" data-edit-config="currency" data-config='<?php echo json_encode($currency); ?>'>
                            <i class="fa-solid fa-pen"></i></button>
                            <!-- <button class="btn btn_delete_config" data-delete-config="currency" data-config='{"idConfig":<?php echo $currency->monedaID; ?>}'><i class="fa-solid fa-trash"></i></button> -->
                        </div>
                    </div>
                <?php }
            }

            if($data['config'] === 'country'){
                // se cargan las monedas
                $this->db->query("{ CALL Clickship_getPaises()}");
                $countries = $this->db->results(); // se obtienen de la base de datos

                foreach($countries as $key => $country){ ?>
                    <div class="config_item">
                        <p><?php echo $country->paisID; ?></p>
                        <p><?php echo $country->nombre ?></p>
                        <p><?php echo $country->simbolo ." ".$country->moneda; ?></p>
                        <div class="config_actions">
                            <button class="btn btn_edit_config" data-edit-config="country" data-config='<?php echo json_encode($country); ?>'>
                            <i class="fa-solid fa-pen"></i></button>
                            <!-- <button class="btn btn_delete_config" data-delete-config="country" data-config='{"idConfig":<?php echo $country->paisID; ?>}'><i class="fa-solid fa-trash"></i></button> -->
                        </div>
                    </div>
                <?php }
            }

            if($data['config'] === 'categorie'){
                // se cargan las monedas
                $this->db->query("{ CALL Clickship_getCategories()}");
                $categories = $this->db->results(); // se obtienen de la base de datos

                foreach($categories as $key => $categorie){ ?>
                    <div class="config_item">
                        <p><?php echo $categorie->idTipoProducto; ?></p>
                        <p><?php echo $categorie->tipoProducto; ?></p>
                        <div class="config_actions">
                            <button class="btn btn_edit_config" data-edit-config="categorie" data-config='<?php echo json_encode($categorie); ?>'>
                            <i class="fa-solid fa-pen"></i></button>
                            <!-- <button class="btn btn_delete_config" data-delete-config="categorie" data-config='{"idConfig":<?php echo $categorie->idTipoProducto; ?>}'><i class="fa-solid fa-trash"></i></button> -->
                        </div>
                    </div>
                <?php }
            }
        }

        // Metodo para adminitrar las configuraciones, eliminar, editar o agregar
        private function adminConfigs($config){
            // adminsitracion de roles
            if($config['config'] === 'roll'){
                if($config['action'] === 'add'){
                    
                    $this->db->query("{ CALL Clickship_addRol(?)}");
                    $this->db->bind(1, $config['rol']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al insertar un rol");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha agregado un rol");
                    }

                    
                }
                if($config['action'] === 'edit'){

                    $this->db->query("{ CALL Clickship_editRol(?, ?) }");
                    $this->db->bind(1, intval($config['rolID']));
                    $this->db->bind(2, $config['rol']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al editar el rol");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha editado el rol");
                    }

                }
                if($config['action'] === 'delete'){

                    $this->db->query("{ CALL Clickship_deleteRol(?)}");
                    $this->db->bind(1, $config['idConfig']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al eliminar el rol");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha eliminado el rol");
                    }
                }
                
            }

            // adminsitracion de monedas
            if($config['config'] === 'currency'){

                if($config['action'] === 'add'){
                    
                    $this->db->query("{ CALL Clickship_addMoneda(?, ?, ?, ?)}");
                    $this->db->bind(1, $config['currency']);
                    $this->db->bind(2, $config['acronym']);
                    $this->db->bind(3, $config['symbol']);
                    $this->db->bind(4, floatval($config['changeDolar']));
                    
                    $currencyResult = $this->db->result();
                    if($this->isErrorInResult($currencyResult)){
                        $this->ajaxRequestResult(false, $currencyResult['Error'], $config);
                    }else{
                        $this->ajaxRequestResult(true, "Se ha agregado la moneda");
                    }

                }
                if($config['action'] === 'edit'){

                    
                    $this->db->query("{ CALL Clickship_editMoneda(?, ?, ?, ?, ?)}");
                    
                    $this->db->bind(1, intval($config['currencyID']));
                    $this->db->bind(2, $config['currency']);
                    $this->db->bind(3, $config['acronym']);
                    $this->db->bind(4, $config['symbol']);
                    $this->db->bind(5, floatval($config['changeDolar']));
                    

                    $currencyResult = $this->db->result();

                    if($this->isErrorInResult($currencyResult)){
                        $this->ajaxRequestResult(false, $currencyResult['Error'], $config);
                    }else{
                        $this->ajaxRequestResult(true, "Se ha editado la moneda");
                    }

                }
                if($config['action'] === 'delete'){
                    $this->ajaxRequestResult(true, "Se ha eliminado una moneda");

                }
                
            }

            // adminsitracion de paises
            if($config['config'] === 'country'){
                if($config['action'] === 'add'){

                    $this->db->query("{ CALL Clickship_addPais(?, ?)}");
                    $this->db->bind(1, $config['country']);
                    $this->db->bind(2, $config['idCurrency']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al insertar un pais");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha agregado el pais");
                    }
                }
                if($config['action'] === 'edit'){

                    $this->db->query("{ CALL Clickship_editPais(?, ?, ?)}");
                    $this->db->bind(1, intval($config['countryID']));
                    $this->db->bind(2, $config['country']);
                    $this->db->bind(3, intval($config['idCurrency']));

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al editar el pais");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha editado el pais");
                    }

                }
                if($config['action'] === 'delete'){

                    $this->db->query("{ CALL Clickship_deletePais(?)}");
                    $this->db->bind(1, $config['idConfig']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al eliminar un pais");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha eliminado un pais");
                    }

                }
                
            }

            // adminsitracion de categorias
            if($config['config'] === 'categorie'){
                if($config['action'] === 'add'){
                    
                    $this->db->query("{ CALL Clickship_postTipoProducto(?)}");
                    $this->db->bind(1, $config['categorie']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al agregar una categoria de producto");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha agregado la categoria de producto");
                    }
                }
                if($config['action'] === 'edit'){
                    $this->db->query("{ CALL Clickship_patchTipoProducto(?, ?)}");
                    $this->db->bind(1, intval($config['categorieID']));
                    $this->db->bind(2, $config['categorie']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al editar la categoria de producto");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha editado la categoria de producto", $config);
                    }

                }
                if($config['action'] === 'delete'){
                    $this->db->query("{ CALL Clickship_deleteTipoProducto(?)}");
                    $this->db->bind(1, $config['idConfig']);

                    if(!$this->db->execute()){
                        $this->ajaxRequestResult(false, "Error al eliminar la categoria");
                    }else{
                        $this->ajaxRequestResult(true, "Se ha eliminado la categoria");
                    }

                }
                
            }
        }

        //Params: Draw, TotalFiltrados, TotalRecords, Datos
        //Result: un array codificado en formato json
        //Prepara los datos de la consulta hecha y los ordena para ser leidos por las dataTables
        public function dataTableOutput($draw, $totalFiltered, $totalRecords, $data){
            // $output = array();
            $output = array(
                "draw"				=>	$draw,
                "recordsTotal"      =>  $totalFiltered,  // total number of records
                "recordsFiltered"   =>  $totalRecords, // total number of records after searching, if there is no searching then totalFiltered = totalData
                "data"				=>  $data
            );
        
            return json_encode($output);
        }

        // METODO PARA VALIDAR LOS MENSAJES DE ERRORES DE LOS SP (TRUE SI HAY ERROR, FALSE SI NO)
        private function isErrorInResult($result){
            return (isset($result['Error']) && $result['Error'] != "");
        }


    }


    $initClass = new Ajax;

?>