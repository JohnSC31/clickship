<?php 
    // CONTIENE LAS CONFIGURACIONES GENERALES DEL PROYECTO

    //config de acceso de la base de datos
    define('DB_HOST', '25.7.162.170');
    define('DB_USER', 'sa');
    define('DB_PASS', 'Ship567!');
    define('DB_NAME', 'Clickship');
    define('DB_PORT', 1433); // puerto

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