<?php
    $sellsRollsAccess = ['Admin', 'Jefe Ventas', 'Manager de Ventas','Jefe Servicio al Cliente', 'Asistente Callcenter', 'Gerente General'];
    $inventoryRollsAccess = ['Gerente General', 'Admin', 'Jefe Inventario', 'Bodeguista'];
    $rrhhRollsAccess = ['Gerente General', 'Admin', 'Jefe RRHH', 'Trabajador RRHH', 'Entrevistador de RRHH'];
    $servicesRollsAccess = ['Gerente General', 'Admin', 'Jefe Servicio al Cliente', 'Asistente Callcenter'];
    $configRollsAccess = ['Gerente General', 'Admin'];
?>
<div class="admin_container">
    <div class="header_container">
        <nav class="admin_navigation">
            <div class="admin_logo">
                <img src="<?php echo URL_PATH; ?>public/img/LogoWhite.png" alt="CLICKSHIP Logo">
            </div>

            <ul id="admin_nav">
                <?php if(($rolKey = array_search($_SESSION['ADMIN']['ROLE'], $sellsRollsAccess)) !== false){ ?>
                    <li data-admin-nav="sells"><i class="fa-solid fa-cart-shopping"></i> <span class="hide_medium"> Ventas</span></li>
                <?php } 
                if(($rolKey = array_search($_SESSION['ADMIN']['ROLE'], $inventoryRollsAccess)) !== false){ ?>
                    <li data-admin-nav="inventory" ><i class="fa-solid fa-box" ></i> <span class="hide_medium"> Inventario</span></li>
                <?php } 
                if(($rolKey = array_search($_SESSION['ADMIN']['ROLE'], $rrhhRollsAccess)) !== false){ ?>
                    <li data-admin-nav="human_resources" ><i class="fa-solid fa-person"></i></i> <span class="hide_medium"> Recursos humanos</span></li>
                <?php } 
                if(($rolKey = array_search($_SESSION['ADMIN']['ROLE'], $servicesRollsAccess)) !== false){ ?>
                    <li data-admin-nav="client_service"><i class="fa-solid fa-phone"></i> <span class="hide_medium"> Servicio al cliente</span></li>
                <?php } 
                if(($rolKey = array_search($_SESSION['ADMIN']['ROLE'], $configRollsAccess)) !== false){ ?>
                    <li data-admin-nav="settings"><i class="fa-solid fa-gear"></i> <span class="hide_medium"> Configuración</span></li>
                <?php } ?>
            </ul>

            <div class="logout_btn_container">
                <button class="btn btn_white" data-admin-logout="true">Cerrar Sesión</button>
            </div>

        </nav>
        <p class="header_rights hide_medium">Todos los derechos resevados 2023</p>
    </div>
    <div class="dashboard_container" id="dashboard_container">
        <!-- PAGINA DE VENTAS -->
        <?php require_once '../app/views/inc/admin-sells.php'; ?>
        <!-- PAGINA DE INVENTARIO -->
        <?php require_once '../app/views/inc/admin-inventory.php'; ?>
        <!-- PAGINA DE RECURSOS HUMANOS -->
        <?php require_once '../app/views/inc/admin-rrhh.php'; ?>
        <!-- PAGINA DE SERVICIO AL CLIENTE -->
        <?php require_once '../app/views/inc/admin-client-service.php'; ?>
        <!-- PAGINA DE CONFIGURACIONES -->
        <?php require_once '../app/views/inc/admin-settings.php'; ?>
        
    </div>
</div>

