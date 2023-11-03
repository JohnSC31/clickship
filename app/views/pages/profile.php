

<div class="container">
    <h1>Pefil</h1>
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
                        <input type="email" name="email" id="email" value="useremail@gmail.com">
                    </div>
                    <div class="field">
                        <label for="name">Nombre</label>
                        <input type="text" name="name" id="name" value="John">
                    </div>
                    <div class="field">
                        <label for="lastnames">Apellidos</label>
                        <input type="text" name="lastnames" id="lastnames" value="Sanchez">
                    </div>
                </form>
            </div>
        </div>
        <div class="orders_container">
            <h3>Mis órdenes</h3>
            <div class="order_list">
                <?php for($i = 0; $i < 10; $i++){ ?>
                <div class="order">
                    <p>Progreso</p>
                    <p>10/10/23</p>
                    <p>$45</p>
                    <a href="javascript:void(0);" class="btn btn_blue">Ver</a>
                </div>
                <?php } ?>
            </div>
        </div>
    </div>
</div>