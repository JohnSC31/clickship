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
            // obtener el nombre, apellido, id, role, departamento

            // se inicia sesion de administrador
            $adminSession = array(
                'SESSION' => TRUE,
                'ID' => "0",
                'EMIAL' => $admin['email'],
                'NAME' => "John Sanchez",
                'ROLE' => "Admin",
            );

            $_SESSION['ADMIN'] = $adminSession;

            if(isset($_SESSION['ADMIN'])){
                $this->ajaxRequestResult(true, "Inicia sesion ". $admin['email']);
            }else{
                $this->ajaxRequestResult(false, "Error al iniciar sesion");
            }
        }

        private function adminLogout($admin){
            unset($_SESSION['ADMIN']); 

            if(session_destroy()){
              
                $this->ajaxRequestResult(true, "Se ha cerrado sesion");
            }else{ 
                $this->ajaxRequestResult(false, "Error al cerrar sesion");
            }
        }

        // --------------------------- SECCION DE VENTAS -------------------------------------------
        // metodo para cargar las data table de ventas
        private function loadDataTableSells($REQUEST){
            // se realiza la consulta a la base de datos
            $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='order' data-modal-data='{\"idOrder\": 2}'><i class='fa-solid fa-eye'></i></button>";
            $queryResults = array(
                array(
                    'idSell' => 1,
                    'clientName' => "Jose luis",
                    'status' => "Progreso",
                    'store' => 1,
                    'actions' => $btnDetail,
                ),
                array(
                    'idSell' => 2,
                    'clientName' => "Miguel de los angeles",
                    'status' => "Finalizado",
                    'store' => 2,
                    'actions' => $btnDetail,
                ),
            );

            echo $this->dataTableOutput($REQUEST['draw'], 2, 2, $queryResults);

        }

        //METODO PARA CAMBIAR EL ESTADO DE UNA ORDEN CON FORME SE PROCESA
        private function changeOrderStatus($order){

            // se cambia el estado en la base de datos

            $this->ajaxRequestResult(true, "Se ha cambiado el estado");
        }
        // --------------------------- SECCION DE INVENTARIO ---------------------------------------
        // metodo para cargas la datatable de inventario
        private function loadDataTableInventory($REQUEST){
            // se realiza la consulta a la base de datos
            $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='product' data-modal-data='{\"idProduct\": 2}'><i class='fa-solid fa-pen'></i></button>";
            $btnDelete = "<button type='button' class='btn btn-danger btn-sm' data-delete-product='idproduct'><i class='fa-solid fa-trash'></i></button>";

            $queryResults = array(
                array(
                    'id' => 1,
                    'name' => "Nombre de producto",
                    'categorie' => "Categoria",
                    'price' => 1300,
                    'amount' => 145,
                    'actions' => $btnDetail . $btnDelete,
                ),
                array(
                    'id' => 1,
                    'name' => "Nombre de producto",
                    'categorie' => "Categoria",
                    'price' => 1300,
                    'amount' => 145,
                    'actions' => $btnDetail . $btnDelete,
                )
            );

            echo $this->dataTableOutput($REQUEST['draw'], 2, 2, $queryResults);
        }

        // metodo para eliminar un producto de la base de datos
        
        private function adminProducts($product){

            if($product['action'] === "add" || $product['action'] === "edit"){
                $msj = "";
                $product['name'];
                $product['idCategorie'];
                $product['price'];
                $product['detail'];
                $product['amountStore1'];
                $product['amountStore2'];
                $product['amountStore3'];

                if($product['action'] === "add"){
                    // se agrega a la base de datos
                    $msj = "Se ha agregado un producto";
                }else{
                    // se actualiza en la base de datos
                    $msj = "Se ha editado un producto";
                }

                // se agregan o se actualizan las imagenes
                $imagesName = "";
                if(count($_FILES) > 0){
                    foreach($_FILES as $key => $image){
                        // se agregan las imagenes a la base de datos
                        $imagesName .= $image["tmp_name"];
                        $imagesName .= ", ";
                    }
                }else{
                    $imagesName = "No images";
                }

                
                $this->ajaxRequestResult(true, $msj);
            }

            if($product['action'] === "delete"){
                $idProduct = $product["idProduct"];
                // se realiza la eliminacion del producto con el id dado
                $this->ajaxRequestResult(true, "Se ha eliminado el producto");
            }

        }

        // --------------------------- SECCION DE RECURSOS HUMANOS ---------------------------------------
        // metodo para cargas la datatable de recursos humanos
        private function loadDataTableRrhh($REQUEST){
            // se realiza la consulta a la base de datos
            $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='employee' data-modal-data='{\"idEmployee\": 2}'><i class='fa-solid fa-pen'></i></button>";

            $queryResults = array(
                array(
                    'name' => "Nombre del empleado",
                    'email' => "email@gmail.com",
                    'country' => "Pais",
                    'rol' => "Rol",
                    'department' => "Departamento",
                    'actions' => $btnDetail,
                ),
                array(
                    'name' => "Nombre del empleado",
                    'email' => "email@gmail.com",
                    'country' => "Pais",
                    'rol' => "Rol",
                    'department' => "Departamento",
                    'actions' => $btnDetail,
                )
            );

            echo $this->dataTableOutput($REQUEST['draw'], 2, 2, $queryResults);
        }

        // se agrega un empleado a la base de datos
        private function addEmployee($employee){
            $employee['name'];
            $employee['lastname'];
            $employee['email'];
            $employee['idCountry'];
            $employee['idRol'];
            $employee['idDepartment'];
            $employee['salary'];
            $employee['idCurrency'];

            // se agrega el empleado a la base de datos
            $this->ajaxRequestResult(true, "Se ha agregado un empleado");

        }

        // se agregan las horas a la base de datos
        private function addHoursEmployee($employee){
            $employee['hours'];
            $employee['idDay'];
            $employee['idEmployee'];
            
            // se realiza la inseccion en la base de datos

            $this->ajaxRequestResult(true, "Se ha agregado las horas");

        }

        // se calcula el pago 
        private function calcEmployeePaid($employee){
            $employee['idEmployee'];

            $this->ajaxRequestResult(true, "Se ha calculado el pago", 250000);
        }


        // --------------------------- SECCION DE SERVICIO AL CLIENTE ---------------------------------------
        private function loadDataTableService($REQUEST){
            $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='call' data-modal-data='{\"idCall\": 2}'><i class='fa-solid fa-eye'></i></button>";

            $queryResults = array(
                array(
                    'id' => "1",
                    'employee' => "Nombre del empleado",
                    'idOrder' => "123",
                    'date' => "12/3/23",
                    'actions' => $btnDetail,
                ),
                array(
                    'id' => "2",
                    'employee' => "Nombre del empleado",
                    'idOrder' => "123",
                    'date' => "12/3/23",
                    'actions' => $btnDetail,
                ),
            );

            echo $this->dataTableOutput($REQUEST['draw'], 2, 2, $queryResults);
        }

        // metodo para agregar una llamada
        private function addCall($call){
            $call['idOrder'];
            $call['idQuestionType'];
            $call['detail'];
            $this->ajaxRequestResult(true, "Se ha agregado la llamada");
        }

        private function loadSelectOptions($select){

            // se cargan las categorias
            if($select['idSelect'] ===  "catProduct"){
                // carga categorias de home
                $categories = []; // se obtienen de la base de datos

                if(count($categories) > 0){ ?>
                    <option value="" selected >Categorias</option>
                    <?php foreach($categories as $categorie) { ?>
                        <option value="<?php echo $categorie->idTipoProducto ?>"> <?php echo $categorie->descripcion; ?> </option>
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
                        <option value="<?php echo $country->id ?>"> <?php echo $country->nombre; ?> </option>
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
                        <option value="<?php echo $rol->id ?>"> <?php echo $rol->rol; ?> </option>
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
            if($select['idSelect'] ===  "currency"){
                
                $this->db->query("{ CALL Clickship_getMonedas()}");
                $currencies = $this->db->results(); // se obtienen de la base de datos
                // var_dump($currencies);

                if(count($currencies) > 0){ ?>
                    <option value="" selected >Monedas</option>
                    <?php foreach($currencies as $currency) { ?>
                        <option value="<?php echo $currency->id ?>"> <?php echo $currency->simbolo." ".$currency->nombre; ?> </option>
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
                        <option value="<?php echo $type->preguntaID ?>"> <?php echo $type->pregunta; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Tipos de preguntas</option>
                <?php }
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