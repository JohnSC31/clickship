<?php 
    /*
    Mapear al url ingresada en el navegador
    0-controlador
    1-metodo
    2-parametro
    Ejemplo:  /paginas/profile/userid
    */
    class Core {
        private $controller = 'Views';
        private $controllerMethod = 'home'; // por defecto
        private $params;

        //constructor
        public function __construct(){
            $url = $this->getUrl();
            $this->verifyUserSession();

            //requirir el controlador
            require_once '../app/controllers/' . $this->controller . '.php';
            $this->controller = new $this->controller; // instancia

            //verify la segunda parte de la url el metodo
            if(isset($url[0])){ // si se paso un metodo
                if(method_exists($this->controller, $url[0])){
                    //chequemos el metodo
                    $this->controllerMethod = $url[0];
                    unset($url[0]);
                }
            }
            
            //obtener los posibles params
            $this->params = $url ? array_values($url) : [];

            //llamar callback con paramtros array
            call_user_func_array([$this->controller, $this->controllerMethod], $this->params);
        }

        public function getUrl(){
            if (isset($_GET['url'])) { // si hay url la mapea y la retorna
                $url = rtrim($_GET['url'], '/');
                $url = filter_var($url, FILTER_SANITIZE_URL);
                $url = explode('/', $url); //0 = pagina y 1 = params
                return $url;
            }
        }

        //metodo para verificar la session del usuario
        public function verifyUserSession(){
            
        }
    }
?>