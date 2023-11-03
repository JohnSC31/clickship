<?php

    class Views{
        
        public function __construct(){

        }

        // METODO PARA CARGAR LAS VISTAS GENERALES
        private function loadView($viewName, $data = []){
            // chequea si la vista existe
            if(!file_exists('../app/views/'. $viewName . '.php')){
                die('la vista no existe');

            }else{
                // lo requerimos
                require_once '../app/views/inc/header.php';
                require_once '../app/views/'. $viewName . '.php';
                require_once '../app/views/inc/footer.php';
            }
        }

        // METODO PARA CARGAR LOS MODALS
        private function loadModal($modalName, $data = false){
            require_once '../views/'. $modalName . '.php';
        }

        // METODO PARA OBTENER LOS ATRIBUTOS DE LAS PAGINAS
        private function getPageData($id, $title){
            $data = array(
                'TITLE' => $title,
                'ID' => $id
            ); 
            return $data;
        }


        // METODOS PARA CARGAR LAS VISTAS

        // CARGA DEL HOME
        public function home(){
            $data = $this->getPageData('home','Encuentra todos tus productos en CLICKSHIP');
            $this->loadView('pages/home', $data); // se carga la vista necesaria
        }

        // CARGA DE REGISTRO
        public function signup(){
            $data = $this->getPageData('signup','Registro de CLICKSHIP');
            $this->loadView('pages/signup', $data); // se carga la vista necesaria
        }

        // CARGA DE PERFIL
        public function profile(){
            $data = $this->getPageData('profile','Perfil de CLICKSHIP');
            $this->loadView('pages/profile', $data); // se carga la vista necesaria
        }

        // CARGA DE CARRITO DE COMPRAS
        public function checkout(){
            $data = $this->getPageData('checkout','Carrito de compras de CLICKSHIP');
            $this->loadView('pages/checkout', $data); // se carga la vista necesaria
        }

        // CARGA DE PRODCUTO
        public function product($idProduct = NULL){
            if(is_null($idProduct)) exit(header('Location:'.URL_PATH. 'home'));

            $data = $this->getPageData('product','Producto de CLICKSHIP');
            $data['idProduct'] = $idProduct;
            $this->loadView('pages/product', $data); // se carga la vista necesaria
        }
    }



?>