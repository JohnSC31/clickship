<?php 
    // CONTROLLADOR PARA LAS PETICIONES AJAX Y CONECIONES CON LA BASE DE DATOS
    if (!$_SERVER['REQUEST_METHOD'] === 'POST') { // se verifica que sea una peticion autentica
	    die('Invalid Request');
    }

    require_once '../config.php';
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

            if(isset($_SESSION['CLIENT'])){
                $this->ajaxRequestResult(true, "Inicia sesion ". $client['email']);
            }else{
                $this->ajaxRequestResult(false, "Error al iniciar sesion");
            }


            
        }

        // CERRAR SESION PARA UN USUARIO
        private function clientLogout($data){
            unset($_SESSION['CLIENT']); 

            if(session_destroy()){
              
                $this->ajaxRequestResult(true, "Se ha cerrado sesion");
            }else{ 
                $this->ajaxRequestResult(false, "Error al cerrar sesion");
            }
        }

        // FUNCIONALIDAD DEL CARRITO
        private function clientCart($product){
            if($product['action'] === 'add'){
                // se agrega un item al carrito
                foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {
                    if ($cartItem['id'] === $product['id']) {
                        $this->ajaxRequestResult(false, "Ya esta en el carrito");
                        return;
                    }
                }
                // si no esta se agrega
                $_SESSION['CLIENT']['CART'][] = array(
                    'id' => $product['id'],
                    'name' => $product['name'],
                    'price' => intval($product['price']),
                    'amount' => 1,
                );

                $this->ajaxRequestResult(true, "Se agrega al carrito");
            }

            if($product['action'] === 'plus'){
                // aumenta cantidad de un item en el carrito
                foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {
                    if ($cartItem['id'] === $product['id']) {
                        $_SESSION['CLIENT']['CART'][$key]['amount'] += 1;
                        $this->ajaxRequestResult(true, "Se ha aumentado la cantidad");
                    }
                }
            }
            
            if($product['action'] === 'minus'){
                // resta una cantidad del carrito
                // aumenta cantidad de un item en el carrito
                foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {
                    if ($cartItem['id'] === $product['id']) {
                        $_SESSION['CLIENT']['CART'][$key]['amount'] -= 1;

                        if($_SESSION['CLIENT']['CART'][$key]['amount'] == 0){
                            $product['action'] = 'delete';
                        }else{
                            $this->ajaxRequestResult(true, "Se ha disminuido la cantidad");
                        }
                    }


                }
            }

            if($product['action'] === 'delete'){
                // se elimina un item del carrito
                foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {
                    if ($cartItem['id'] === $product['id']) {
                        unset($_SESSION['CLIENT']['CART'][$key]);
                        $this->ajaxRequestResult(true, "Se ha eliminado del carrito");
                    }
                }
            }
        }

        // METODO PARA CARGAR EL CARRITO EN LA PAGINA DE CHECKOUT
        private function loadClientCart($data){
            if(count($_SESSION['CLIENT']['CART']) > 0){ 
                foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) { ?>
                        <div class="bill_detail">
                            <div class="detail_product">
                                <button class="btn_minus_product" data-cart="minus" data-id="<?php echo $cartItem['id'];?>"><i class="fa-solid fa-minus"></i></button>
                                <p class="numProduct" id="numProduct"><?php echo $cartItem['amount']?></p>
                                <button class="btn_add_product" data-cart="plus" data-id="<?php echo $cartItem['id']; ?>"><i class="fa-solid fa-plus"></i></button>
                                <p><?php echo $cartItem['name']; ?></p>
                            </div>
                            <div class="price_product_detail">
                                <p class="product_price">$ <?php echo $cartItem['price']; ?></p>
                                <button class="btn_detele_product" data-cart="delete" data-id="<?php echo $cartItem['id']; ?>"><i class="fa-solid fa-xmark"></i></button>
                            </div>
                        </div>
                <?php }
            }else{ ?>
                <div class="no_items_cart">
                    <p>Agrega productos al carrito</p>
                </div>
            <?php }
        }

        // METODO PARA CALCULAR Y MOSTRAR EL TOTAL DEL CARRITO
        private function getTotalClientCart($data){
            $total = 0;
            foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {

                $total += $_SESSION['CLIENT']['CART'][$key]['amount'] * $_SESSION['CLIENT']['CART'][$key]['price'];
            }

            echo $total;

        }


        // METODO PARA CARGAR LOS PRODUCTOS DE LA BASE DE DATOS
        private function loadProducts($filters){
            $search = isset($filters['search']) ? $filters['search'] : NULL;
            $idCategorie = isset($filters['idCategorie']) ? $filters['idCategorie'] : NULL;

            // se realiza la consulta de los productos en base a estos filtros
            
            // se carga el html de los productos
            for($i = 0; $i < 8; $i++){ ?>
                <div class="product_item" data-item="<?php echo $i; ?>">
                    <div class="img_product" style="background-image: url(<?php echo URL_PATH; ?>public/img/product.jpeg)"></div>
                    <div class="product_detail">
                        <p>Nombre de producto</p>
                        <p class="price">$30</p>
                        <div class="product_action">
                            <a href="javascript:void(0);" class="btn btn_yellow <?php echo !isset($_SESSION['CLIENT']) ? "disabled" : ""; ?>" 
                            data-cart="add" data-id="<?php echo $i; ?>" data-name="Producto <?php echo $i; ?>" data-price="15"> <i class="fa-solid fa-plus"></i> Agregar</a>
                        </div>
                    </div>
                </div>
            <?php } 
        }
        
        // METODO PARA CREAR UNA ORDEN DEL CLIENTE CON LO QUE TIENE EN EL CARRITO
        private function clientMakeOrder($order){
            // obtiene los detalles de la orden
            // se crea la order
            // se le agregan los productos
            // sacar todos los productos del carrito de compras
            
            // retorna el mensaje
            $this->ajaxRequestResult(true, "Se ha realizado la orden");
        }

    }


    $initClass = new Ajax;

?>