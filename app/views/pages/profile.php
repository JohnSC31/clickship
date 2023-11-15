
<div class="container">
    <h1>Perfil</h1>
    <div class="profile_dashboard">

        <div class="user">
            <div class="picture_container">
                <div class="picture">
                    <i class="fa-solid fa-user"></i>
                </div>
            </div>
            <div class="profile_form_container">
                <form action="" method="post" id="profile_form">
                    <div class="field">
                        <label for="email">Correo electrónico</label>
                        <input type="email" name="email" id="email" value="<?php echo $_SESSION['CLIENT']['EMAIL']; ?>">
                    </div>
                    <div class="field">
                        <label for="name">Nombre</label>
                        <input type="text" name="name" id="name" value="<?php echo $_SESSION['CLIENT']['NAME']; ?>">
                    </div>
                    <div class="field">
                        <label for="lastnames">Apellidos</label>
                        <input type="text" name="lastnames" id="lastnames" value="<?php echo $_SESSION['CLIENT']['LASTNAME']; ?>">
                    </div>
                </form>
                <div class="logout_container">
                    <button class="btn btn_yellow" data-logout="true">Cerrar Sesion</button>
                </div>
            </div>
        </div>
        <div class="orders_container">
            <h3>Mis órdenes</h3>
            <div class="order_list" id="client_orders_container">
                
            </div>
        </div>
    </div>
</div>