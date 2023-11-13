<?php 
    // CONTROLLADOR PARA LAS PETICIONES AJAX Y CONECIONES CON LA BASE DE DATOS
    if (!$_SERVER['REQUEST_METHOD'] === 'POST') { // se verifica que sea una peticion autentica
	    die('Invalid Request');
    }

    require_once '../lib/Db.php';


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

        private function loadDataTableSells($REQUEST){
            // se realiza la consulta a la base de datos
            $btnDetail = "<button type='button' class='btn btn-warning btn-sm' data-modal='order' data-modal-data='{'idOrder': 2}'><i class='fa-solid fa-eye'></i></button>";

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


    }


    $initClass = new Ajax;

?>