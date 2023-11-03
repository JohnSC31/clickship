
<div class="modal modal_login">
    <div class="modal_header">
        <a close-modal="" class="close_modal"><i class="fas fa-times"></i></a>
    </div>
    <div class="modal-content">
        <h2 class="fw_300 txt_center">Inicia Sesión</h2>

        <form id="login_form" method="post" enctype="multipart/form-data">
            <div class="field">
                <label for="email">Tu email</label>
                <input type="email" name="email" id="email">
            </div>
            <div class="field">
                <label for="pass">Tu contraseña</label>
                <input type="password" name="pass" id="pass">
            </div>
            <div class="submit">
                <input type="submit" class="btn btn_white" value="Iniciar Sesión">
            </div>
        </form>
        <p class="register">¿Aún no tienes cuenta? <a href="signup">Regístrate</a></p>
    </div><!-- .modal-content -->
</div>