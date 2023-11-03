<!DOCTYPE html>
<html class="no-js" lang="es">

<head>

    <meta charset="utf-8">
    <title><?php  echo WEB_NAME . " | " .$data['TITLE'];?></title>

    <meta name="description" content="CLICKSHIP el mejor en e-commerce y logistica">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">

    <!-- Link of google fonts -->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet"> 
    <!-- Place favicon.ico in the root directory -->

    <!-- NORMALIZE -->
    <link rel="stylesheet" href="<?php echo URL_PATH; ?>public/css/normalize.css">
    <link rel="stylesheet" href="<?php echo URL_PATH; ?>public/css/main.css">

    <!-- Link para Font Awesome -->
    <link rel="stylesheet" href="<?php echo URL_PATH; ?>public/css/fontawesome-free-6.2.1-web/css/all.min.css">

    <meta name="theme-color" content="#fafafa">

</head>
<body id="<?php echo $data['ID'];?>" data-url="<?php echo URL_PATH; ?>">

<header class="web_header">
    <div class="fixed_bar">
        <div class="container">
            <a href="home">
                <div class="logo">
                    <img src="public/img/LogoBlack.png" alt="CLICKSHIP Logo">
                </div>
            </a>
            <nav class="navigation">
                <ul>
                    <li><a href="signup" class="btn btn_yellow"><i class="fa-solid fa-user-plus"></i> <span class="hide_medium"> Registro </span></a></li>
                    <li><a href="javascript:void(0);" class="btn btn_blue" data-modal="login"><i class="fa-solid fa-right-to-bracket"></i> <span class="hide_medium">Iniciar Sesión</span></a></li>
                </ul>
            </nav>
        </div>
        
    </div>
    <div class="bar_space"></div>

</header>

<div class="notification_container" id="notification_container"></div>

<div class="modal_container" id="modal_container"></div>
 
