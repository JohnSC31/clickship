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


        // Metodo de prueba
        private function foo($data){
            $this->ajaxRequestResult(true, $data['message']);
        }

        // Metodo para la carga de los modals
        private function loadModal($data){
            require_once '../views/modals/'. $data['modal'] . '.php';
        }

        // REGISTRO DEL CLIENTE
        private function clientSignup($client){

            // REALIZAR LA INSERCCION EN LA BASE DE DATOS

            // INICIAR LA SESION DEL CLIENTE
            $this->ajaxRequestResult(true, "Se registra". $client['name']);
        }

        // INICIO DE SESION DEL CLIENTE
        private function clientLogin($client){
            
            // se validan las credenciales
            // obtener el nombre, apellidos e email para el perfil

            // se inicia sesion y el carrito
            $clientSession = array(
                'SESSION' => TRUE,
                'CID' => "idClient",
                'CART' => array() // arreglo para el carrito
            );

            $_SESSION['CLIENT'] = $clientSession;

            if(isset($_SESSION['USER'])){
                $this->ajaxRequestResult(true, "Inicia sesion ". $client['email']);
            }else{
                $this->ajaxRequestResult(false, "Error al iniciar sesion");
            }


            
        }
       

    }


    $initClass = new Ajax;

?>