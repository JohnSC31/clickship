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

    <!-- DATATABLTES AND BOOSTRAP STYLES-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">


    <!-- NORMALIZE -->
    <link rel="stylesheet" href="<?php echo URL_PATH; ?>public/css/normalize.css">
    <!-- CSS de la zona cliente para user sus atributos  -->
    <link rel="stylesheet" href="<?php echo URL_PATH; ?>public/css/main.css"> 
    <!-- CSS exclusivo del admin area -->
    <link rel="stylesheet" href="<?php echo URL_ADMIN_PATH; ?>public/css/main.css">

    <!-- Link para Font Awesome -->
    <link rel="stylesheet" href="<?php echo URL_PATH; ?>public/css/fontawesome-free-6.2.1-web/css/all.min.css">

    <meta name="theme-color" content="#fafafa">

</head>
<body id="<?php echo $data['ID'];?>" data-url="<?php echo URL_ADMIN_PATH; ?>">

    <div class="notification_container" id="notification_container"></div>

    <div class="modal_container" id="modal_container"></div>
 
