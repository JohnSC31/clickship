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
            $this->db->query("{ CALL Clickship_registerClient(?, ?, ?, ?, ?) }");

            $this->db->bind(1, $client['email']);
            $this->db->bind(2, $client['pass']);
            $this->db->bind(3, $client['name']);
            $this->db->bind(4, $client['lastname1']);
            $this->db->bind(5, $client['lastname2']);

            $result = $this->db->result();

            if($this->isErrorInResult($result)){
                $this->ajaxRequestResult(false, $result['Error']);
              
            }else{
                // INICIAR LA SESION DEL CLIENTE
                $this->clientLogin($client);
                
            }

           
        }

        // INICIO DE SESION DEL CLIENTE
        private function clientLogin($client){

            // se validan las credenciales
            $this->db->query("{ CALL Clickship_loginClient(?, ?) }");
            // obtener el nombre, apellidos e email para el perfil
            $this->db->bind(1, $client['email']);
            $this->db->bind(2, $client['pass']);
            // se inicia sesion y el carrito

            $loggedClient = $this->db->result();

            if($this->isErrorInResult($loggedClient)){
                $this->ajaxRequestResult(false, $loggedClient['Error']);
            }else{
                $clientSession = array(
                    'SESSION' => TRUE,
                    'CID' => $loggedClient['idCliente'],
                    'EMAIL' => $loggedClient['correo'],
                    'NAME' => $loggedClient['nombre'],
                    'LASTNAME1' => $loggedClient['apellido1'],
                    'LASTNAME2' => $loggedClient['apellido2'],
                    'CART' => array() // arreglo para el carrito
                );
    
                $_SESSION['CLIENT'] = $clientSession;
    
                if(isset($_SESSION['CLIENT'])){
                    $this->ajaxRequestResult(true, "Se ha iniciado sesion");
                }else{
                    $this->ajaxRequestResult(false, "Error al iniciar sesion");
                }
            }
            
            
        }

        // CERRAR SESION PARA UN USUARIO
        private function clientLogout($data){
            unset($_SESSION['CLIENT']); 

            if(!isset($_SESSION['CLIENT'])){
              
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

                    if($cartItem['idCurrency'] !== intval($product['idCurrency'])){
                        $this->ajaxRequestResult(false, "Escoge productos de la misma moneda");
                        return;
                    }
                }
                // si no esta se agrega
                $_SESSION['CLIENT']['CART'][] = array(
                    'id' => $product['id'],
                    'name' => $product['name'],
                    'price' => floatval($product['price']),
                    'symbol' => $product['symbol'],
                    'idCurrency' => intval($product['idCurrency']),
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
                                <p class="product_price"> <?php echo $cartItem['symbol'] ." ". $cartItem['price']; ?></p>
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
            $symbolCart = NULL;

            foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {

                $total += $_SESSION['CLIENT']['CART'][$key]['amount'] * $_SESSION['CLIENT']['CART'][$key]['price'];
                $symbolCart = $_SESSION['CLIENT']['CART'][$key]['symbol'];
            }

            echo (!is_null($symbolCart)) ? $symbolCart ." ". $total : $total;

        }

        // retorna el numero del total del carrito
        private function calcTotalCostCart(){
            $total = 0;

            if($_SESSION['CLIENT']){

                foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {

                    $total += $_SESSION['CLIENT']['CART'][$key]['amount'] * $_SESSION['CLIENT']['CART'][$key]['price'];
                }
            }

            return $total;
        }

        // retorna el id de la moneda del carrito
        private function getCartIdCurrency(){

            foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {

                return $_SESSION['CLIENT']['CART'][$key]['idCurrency'];
            }

            return NULL;
        }


        // METODO PARA CARGAR LOS PRODUCTOS DE LA BASE DE DATOS
        private function loadProducts($filters){
            $search = isset($filters['search']) ? $filters['search'] : NULL;
            $idCategorie = isset($filters['idCategorie']) ? intval($filters['idCategorie']) : NULL;
            $idCurrency = isset($filters['idCurrency']) ? intval($filters['idCurrency']) : NULL;

            // se realiza la consulta de los productos en base a estos filtros
            
            $this->db->query("{ CALL Clickship_getProductos(?, ?, ?) }");
            // NULLOS PORQUE TRAEN TODOS LOS RESULTADOS
            $this->db->bind(1, $search);
            $this->db->bind(2, $idCategorie);
            $this->db->bind(3, $idCurrency);

            $products = $this->db->results(); // se obtienen de la base de datos

            // var_dump($search, $idCategorie);

            // se carga el html de los productos
            if(count($products) > 0){
                foreach($products as $key => $product){
                    $product = get_object_vars($product); ?>

                    <div class="product_item" data-item="<?php echo $product['idProducto']; ?>">
                        <div class="img_product">
                            <?php if($product['foto'] !== null) { ?>
                                <img src="data:image/png;base64,<?php echo base64_encode($product['foto']); ?>" alt="productImage">
                            <?php } else { ?>
                                <img src="<?php echo URL_PATH . "public/img/default.jpg"?>" alt="producto">
                            <?php } ?>
                        </div>
                        <div class="product_detail">
                            <p><?php echo $product['nombre']." - ".$product['tipoProducto']; ?></p>
                            <p class="price"><?php echo $product['simbolo']." ". round(floatval($product['precio']), 2); ?></p>

                            <div class="product_action">
                                <a href="javascript:void(0);" class="btn btn_yellow <?php echo !isset($_SESSION['CLIENT']) ? "disabled" : ""; ?>" 
                                data-cart="add" data-id="<?php echo $product['idProducto']; ?>" data-name="<?php echo $product['nombre']; ?>" data-price="<?php echo round(floatval($product['precio']), 2); ?>" 
                                data-symbol="<?php echo $product['simbolo']; ?>" data-id-currency="<?php echo $product['monedaid']; ?>"> 
                                <i class="fa-solid fa-plus"></i> Agregar</a>
                            </div>
                        </div>
                    </div>
                <?php } 
            }else{
                ?>
                    <div class="no_items_in_list">
                        <p>No hay productos para tu busqueda </p>
                    </div>
                
                <?php
            }
        }
        
        // METODO PARA CREAR UNA ORDEN DEL CLIENTE CON LO QUE TIENE EN EL CARRITO
        private function clientMakeOrder($order){

            // se valida la sesion
            if(!isset($_SESSION['CLIENT'])){
                $this->ajaxRequestResult(false, "Debe iniciar sesion");
            }else{
                // se crea la orden
                $this->db->query("{ CALL Clickship_postOrder(?, ?, ?, ?, ?, ?) }");

                $this->db->bind(1, $_SESSION['CLIENT']['CID']);
                $this->db->bind(2, $this->calcTotalCostCart());
                $this->db->bind(3, $order['lat']);
                $this->db->bind(4, $order['lng']);
                $this->db->bind(5, $order['address']);
                $this->db->bind(6, intval($this->getCartIdCurrency()));

                $orderResult = $this->db->result();

                if($this->isErrorInResult($orderResult)){
                    $this->ajaxRequestResult(false, "Orden: ".$orderResult['Error']);
                
                }else{

                    // procesar los productos del carrito
                    foreach ($_SESSION['CLIENT']['CART'] as $key => $cartItem) {
                        
                        $this->db->query("{ CALL Clickship_postOrderProduct(?, ?, ?) }");

                        $this->db->bind(1, $orderResult['ordenid']);
                        $this->db->bind(2, $_SESSION['CLIENT']['CART'][$key]['id']);
                        $this->db->bind(3, $_SESSION['CLIENT']['CART'][$key]['amount']);

                        $orderProductResult = $this->db->result();

                        if($this->isErrorInResult($orderProductResult)){
                            $this->ajaxRequestResult(false, "Producto:". $orderProductResult['Error']);
                            return;
                        }

                                
                    }
                    
                    
                    // limpiar el carrito
                    $_SESSION['CLIENT']['CART'] = array();
                    
                    // retorna el mensaje
                    $this->ajaxRequestResult(true, "Se ha realizado la orden");
                }

            }
            
        }

        // METODO PARA CARGAR LOS SELECT DEL FRONTEND
        private function loadSelectOptions($select){
            // se cargan las categorias
            if($select['idSelect'] ===  "select_categorie"){
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

            // se cargan las monedas
            if($select['idSelect'] === "select_currency"){
                
                $this->db->query("{ CALL Clickship_getMonedas()}");
                $currencies = $this->db->results(); // se obtienen de la base de datos
                // var_dump($currencies);

                if(count($currencies) > 0){ ?>
                    <option value="" selected >Monedas</option>
                    <?php foreach($currencies as $key => $currency) { ?>
                        <option value="<?php echo $currency->monedaID ?>"> <?php echo $currency->simbolo." ".$currency->nombre; ?> </option>
                    <?php }
                }else{ ?>
                    <option value="">No hay Monedas</option>
                <?php }
            }
        }

        // METODO PARA CARGAR LAS ORDENES DE UN CLIENTE EN EL PERFIL
        private function loadClientOrders($data){
            
            $this->db->query("{ CALL Clickship_getCLientOrders(?) }");
            $this->db->bind(1, $_SESSION['CLIENT']['CID']);
            $orders = $this->db->results(); //obtienen en base de datos con el id del cliente 

            if(count($orders) > 0){
                foreach($orders as $key => $order){
                    $order = get_object_vars($order); ?>
                    <div class="order">
                        <p><?php echo $order['estado']; ?></p>
                        <p><?php echo date('j-n-Y', strtotime($order['fecha'])); ?></p>
                        <p><?php echo $order['simbolo'] ." ". round(floatval($order['costoTotal']), 2); ?> </p>
                        <a href="javascript:void(0);" class="btn btn_blue" data-modal="order" data-modal-data='{"idOrder": <?php echo $order['ordenID']; ?>}' >Ver</a>
                        
                    </div>
                <?php } 
            }else{ ?>
                <div class="no_items_in_list">
                    <p>No hay ordenes qún</p>
                </div>
            <?php }
            
        }

        // METODO PARA VALIDAR LOS MENSAJES DE ERRORES DE LOS SP (TRUE SI HAY ERROR, FALSE SI NO)
        private function isErrorInResult($result){
            return (isset($result['Error']) && $result['Error'] != "");
        }

    }


    $initClass = new Ajax;

?>