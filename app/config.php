<?php 
    // CONTIENE LAS CONFIGURACIONES GENERALES DEL PROYECTO

    //config de acceso de la base de datos
    // define('DB_HOST', 'localhost');
    // define('DB_USER', 'root');
    // define('DB_PASS', '');
    // define('DB_NAME', 'clickship');

    //Ruta de la app
    define('APP_PATH', dirname(dirname(__FILE__))); 
    //Ruta de url
    //Ejemplo: http://localhost/website/
    //define('URL_PATH', 'https://asedocr.com/'); 
    define('URL_PATH', 'http://localhost/clickship/');
    define('URL_ADMIN_PATH', 'http://localhost/clickship/admin/');

    define('WEB_NAME', 'CLICKSHIP');

    //DEFINICION DE LA ZONA HORARIA
    date_default_timezone_set('America/Costa_Rica');

    //  INICIALIZAR LAS SESIONES
    session_start();


?>