

<div class="checkout container">

    <h1>Carrito de Compra</h1>

    <div class="checkout_container">
        <div class="bill_container">
            <div class="bill_detail_container">
                <?php for($i = 0; $i < 6; $i++) { ?>
                    <div class="bill_detail">
                        <div class="detail_product">
                            <button class="btn_minus_product"><i class="fa-solid fa-minus"></i></button>
                            <p class="numProduct" id="numProduct">3</p>
                            <button class="btn_add_product"><i class="fa-solid fa-plus"></i></button>
                            <p>Nombre producto</p>
                        </div>
                        <div class="price_product_detail">
                            <p class="product_price">$45</p>
                            <button class="btn_detele_product"><i class="fa-solid fa-xmark"></i></button>
                        </div>
                    </div>
                <?php } ?>
            </div>
            <div class="bill_total">
                    <h4>Total</h4>
                    <h4>$ <span id="total_bill">45</span></h4>
            </div>
        </div>
        <div class="payment">
            <form action="" method="post" id="checkout_form">
                <div class="field">
                    <label for="carNumber">Número de tarjeta</label>
                    <input type="text" name="carNumber" id="carNumber" data-mask="0000 0000 0000 0000">
                </div>
                <div class="field">
                    <label for="expireDate">Fecha de vencimiento</label>
                    <input type="text" name="expireDate" id="expireDate" data-mask="00/00">
                </div>
                <div class="field">
                    <label for="cvc">CVC</label>
                    <input type="text" name="cvc" id="cvc" data-mask="000">
                </div>

                <div class="field">
                    <label for="shippingAddress">Dirección de envío</label>
                    <input type="text" name="shippingAddress" id="shippingAddress">
                </div>
                <div class="field">
                    <label for="postalCode">Codigo Postal</label>
                    <input type="text" name="postalCode" id="postalCode" data-mask="000000">
                </div>
                <div class="submit">
                    <input type="submit" class="btn btn_yellow" value="Ordenar">
                </div>

            </form>
        </div>
    </div>
</div>