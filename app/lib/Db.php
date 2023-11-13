<?php 

    //clase para conectase a la base de datos y ejecutar consultas con PDO

    class Db{
        private $host = DB_HOST;
        private $port = DB_PORT;
        private $user = DB_USER;
        private $pass = DB_PASS;
        private $name = DB_NAME;

        private $dbh; // database handler
        private $stmt;
        private $error;

        //Se crea la conexion con la base de datos
        public function __construct(){
            //config la coo
            $dsn = "sqlsrv:Server=$this->host, $this->port; Database=$this->name";
            // $dsn = "mssql:host=$this->host, $this->port; dbname=$this->name";
            $opc = array(
                PDO::ATTR_PERSISTENT => true,
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
            ); 

            //instancia del PDO
            try {
                $this->dbh = new PDO($dsn, $this->user, $this->pass);
                // $this->dbh->exec('set names utf8'); // soluciona problemas de caracteres especiales
            } catch (PDOException $e) {
                $this->error = $e->getMessage();
                echo $this->error;
            }
        }
        //preparamos la consulta
        public function query($sql){
            $this->stmt = $this->dbh->prepare($sql); // recibimos y preparamos la consulta sql
        }
        //vinculamos la consulta con bind
        public function bind($param, $val, $type = null){
            if(is_null($type)){
                switch(true){
                    case is_int($val):
                        $type = PDO::PARAM_INT;
                    break; 
                    case is_bool($val):
                        $type = PDO::PARAM_BOOL;
                    break; 
                    case is_null($val):
                        $type = PDO::PARAM_NULL;
                    break; 
                    default:
                        $type = PDO::PARAM_STR;
                }
            }
            $this->stmt->bindValue($param, $val, $type);
        }
                
        public function getStmt(){
            return $this->stmt;
        }
        public function getDbh(){
            return $this->dbh;
        }
        //ejecuta la consulta
        public function execute(){
            return $this->stmt->execute();
        }
        //obtenemos varios registros de la base de datos
        public function results(){
            $this->execute();
            return $this->stmt->fetchAll(PDO::FETCH_OBJ);
        }
        //obtenemos un registro de la base de datos
        public function result(){
            $this->execute();
            return get_object_vars($this->stmt->fetch(PDO::FETCH_OBJ));
        }
        //obtenemos cantidad de filas de una consulta
        public function countRows(){
            $this->execute();
            return $this->stmt->rowCount();
        }
        //obtener el id del ultimo insertado
        public function inserted_id(){
            return $this->dbh->lastInsertId();
        }
        //cerrar la conexion con la base de datos
        public function dbClose(){
            $this->stmt = null; // obligado para cerrar la conexión
            $this->dbh = null;
        }
    }