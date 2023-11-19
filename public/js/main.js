// VARIABLES GLOBALES
const URL_PATH = $('body').attr('data-url').replace(/[\\]/gi,'/');
const AJAX_URL = URL_PATH + 'app/controllers/Ajax.php';

(function () {
    "use strict";
  
    document.addEventListener('DOMContentLoaded', function (){
      // Despues de cargar todo el DOM se ejecuta el codigo

      // APERTURA DE LOS MODALS
      $("body").on("click", "[data-modal]", openModal);
      $("body").on("click", "[close-modal]", closeModal);

      // EVENT LISTENER DE FORMULARIOS
      // SIGNUP FORM
      $("body").on("submit", "form#signup_form", clientSignupForm);
      // Inicio de seion
      $("body").on("submit", "form#login_form", clientLoginForm);
      // cerrar seion
      $("body").on("click", "[data-logout]", clientLogout);

      

      // CLICK DE LOS PRODUCTOS
      $("body").on("click", "[data-item]", productPage);
      
      // AGREGAR PRODUCTO
      $("body").on("click", "[data-cart]", function(e){
        e.stopPropagation();
        clientCart(e.currentTarget);
      });

      // PAGINA HOME O INICIO
      if($("body").attr('id') === 'home'){
        loadProducts(); // se cargan los productos

        // carga las categorias del select
        loadSelectOptions('select_categorie');
        loadSelectOptions('select_currency');

        // carga al ingresar en el input
        $("input#product_search").on("change", loadProducts);
        // carga productos al cambiar el select
        $("select#select_categorie").on("change", loadProducts);
        $("select#select_currency").on("change", loadProducts);
      }

      // PAGINA DE CHECKOUT
      if($("body").attr('id') === 'checkout'){
        loadClientCart();
        $("body").on("submit", "form#order_form", makeOrder);
      }

      // PAGINA DE PRODUCTO 
      if($("body").attr('id') === 'product'){
        // funcionalidad del carrusel de producto
        $("body").on("click", "[data-carrousel-pass]", function(e){
          e.stopPropagation();
          changeCarrouselImage(e.currentTarget);
        });
      }

      // PAGINA DEL PERFIL
      if($("body").attr('id') === 'profile'){
        loadClientOrders();
      }
      
      
      
    
  
    }); // end DOMContentLoaded
  
  
})();

// ///////////////// *******************************  FUNCIONES  ****************************** /////////////////////

// FUNCION PARA ABRIR Y CARGAR UN MODAL
function openModal(e){
  e.preventDefault();
  const modalName = $(this).attr('data-modal');
  const modalData = $(this).attr('data-modal-data') !== undefined ? $(this).attr('data-modal-data') : '{}';

  const myData = {
    'ajaxMethod': 'loadModal',
    'modal': modalName,
    'data': modalData
  }

  $.ajax({
    url: AJAX_URL,
    type:'POST',
    dataType:'html',
    data: myData
  }).done(function(data){
    $('div#modal_container').html(data);
    $('div#modal_container').css('display', 'block'); // estaba en flex
    $('body').css('overflow', 'hidden');
  });
}

// FUNCION PARA CERRAR UN MODAL
function closeModal(e){
  e.preventDefault();
  $('div.modal_container').css('display', 'none');
  $('div#modal_container').html('');
  $('body').css('overflow', 'auto');
  // if($('div.notification')) $('div.notification').remove();
}

// Funcionalidad para mostrar la notificacion
///////////// ************************ NOTIFICACION ************************ ///////////////
function showNotification(message, success, timer = true){
  const notification = $('<div></div>');
  notification.addClass('notification');
  notification.addClass((success) ? 'n_success' : 'n_error');

  const text = $("<p></p>").text(message);

  notification.html(text);
  // insert before toma de paramatros (que insertar, antes de que se insetar)
  $("#notification_container").html("");
  $("#notification_container").html(notification);
  // ocultar y mostrar la notif
  setTimeout(()=>{
      notification.addClass('visible');
      setTimeout(()=>{
        if(timer){ // si timer entonces de deshace sola
          notification.removeClass('visible');
          setTimeout(()=>{
              notification.remove();
          }, 500)
        }    
      }, 3000)   
  }, 100)
}

// FUNCIONES PARA LA VALIDACION DE FORMULARIO
function validInput(input_value, max_length = false, msj = 'Campo Obligatorio'){
  
  if(input_value.length == 0){
    showNotification(msj, false);
    return false;
  }
  if(length > 0 && input_value.length > max_length){
    showNotification("Excede max de caracteres", false);
    return false;
  }

  return true;
  
}

function validPassword(input_value){
  if(input_value.length == 0){
    showNotification("Ingrese una contreseña", false);
    return false;

  }else if (input_value.length < 7) {
    showNotification("Contreseña muy corta", false);
    return false;
  }
  return true
}

function validEmail(input_value){
  const validEmailPattern = /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;
  if(input_value.length == 0){
    showNotification("Ingrese un correo", false);
    return false;
  }
  if (!validEmailPattern.test(input_value)){
    showNotification("Correo inválido", false);
    return false;

  }
  return true;
}


///////////// **************************************************************************************************** ///////////////
///////////// ********************************************** CLEINT AREA ****************************************** ///////////////
///////////// **************************************************************************************************** ///////////////

///////////// ********************************************** REGISTRO ****************************************** ///////////////
// FUNCION PARA EL REGISTRO DE UN NUEVO USUARIO
async function clientSignupForm(e){
  e.preventDefault();

  // optienen los campos del formulario
  const input_name = $('input#name');
  const input_lastname1 = $('input#lastname1');
  const input_lastname2 = $('input#lastname2');
  
  const input_email = $('input#email');
  const input_pass = $('input#pass');

  // validan los datos
  if(!validInput(input_name.val(), false, "Ingrese un nombre")) return false;
  if(!validInput(input_lastname1.val(), false, "Ingrese un apellido")) return false;
  if(!validInput(input_lastname2.val(), false, "Ingrese un apellido")) return false;
  if(!validEmail(input_email.val())) return false;
  if(!validPassword(input_pass.val())) return false;

  const signupFormData = new FormData();
  signupFormData.append('name', input_name.val());
  signupFormData.append('lastname1', input_lastname1.val());
  signupFormData.append('lastname2', input_lastname2.val());
  signupFormData.append('email', input_email.val());
  signupFormData.append('pass', input_pass.val());
  signupFormData.append('ajaxMethod', "clientSignup");  

  result = await ajaxRequest(signupFormData);
  showNotification(result.Message, result.Success, false);

  if(result.Success){
    setTimeout(()=>{
      window.location.href = URL_PATH + 'home';
    }, 1500)
  }

}

// FUNCION PARA EL INICIO DE SESION DE UN USUARIO
async function clientLoginForm(e){
  e.preventDefault();
  // campos
  const input_email = $('input#email');
  const input_pass = $('input#pass');
  // validacion
  if(!validEmail(input_email.val())) return false;
  if(!validPassword(input_pass.val())) return false;

  // form data
  const loginFormData = new FormData();
  loginFormData.append('email', input_email.val());
  loginFormData.append('pass', input_pass.val());
  loginFormData.append('ajaxMethod', "clientLogin");  

  result = await ajaxRequest(loginFormData);
  showNotification(result.Message, result.Success, false);

  if(result.Success){
    setTimeout(()=>{
      window.location.href = URL_PATH + 'home';
    }, 1500)
  }

}

///////////// ********************************************** PROFILE ****************************************** ///////////////
async function clientLogout(e){
  e.preventDefault();

  const logoutFormData = new FormData();
  logoutFormData.append('ajaxMethod', "clientLogout");  

  result = await ajaxRequest(logoutFormData);
  showNotification(result.Message, result.Success, false);

  if(result.Success){
    setTimeout(()=>{
      window.location.href = URL_PATH + 'home';
    }, 1500)
  }
}

// cargar todas las ordenes de un cliente
async function loadClientOrders(){
  const selectFormData = new FormData();
  selectFormData.append('ajaxMethod', "loadClientOrders");

  ajaxHTMLRequest(selectFormData, "div#client_orders_container");
}

///////////// ********************************************** HOME ****************************************** ///////////////
// CLICK DE LOS PRODUCTOS PARA VERLO EN LA PAGINA
function productPage(e){
  e.preventDefault();
  console.log("click");
  const idProduct = $(this).attr('data-item');
  window.location.href = URL_PATH + 'product/' + idProduct;
}

// FUNCION DE BUSQUEDA Y FILTROS PARA CARGAR LOS PRODUCTOS
async function loadProducts(){

  const input_search_product = $('input#product_search');
  const select_categorie = $('select#select_categorie');
  const select_currency = $('select#select_currency');

  const filtersProduct = new FormData();

  if($(input_search_product).val() !== ""){
    filtersProduct.append('search', input_search_product.val());
  }

  if($(select_categorie).val() !== ""){
    filtersProduct.append('idCategorie', select_categorie.val());
  }

  if($(select_currency).val() !== ""){
    filtersProduct.append('idCurrency', select_currency.val());
  }
  
  filtersProduct.append('ajaxMethod', "loadProducts");  
  ajaxHTMLRequest(filtersProduct, "#product_list");

}

///////////// ********************************************** PRODUCT ****************************************** ///////////////

// FUCIONALIDAD PARA PASAR LAS IMAGENES EN EL CARRUSEL DE IMAGENES
function changeCarrouselImage(button){

  var carrousel_id = $(button).attr('data-carrousel-id');

  var max_image = parseInt($('input#input-'+carrousel_id).attr('data-max-image'));
  var current_image = parseInt($('input#input-'+carrousel_id).attr('data-current-image'));

  if($(button).attr('data-carrousel-pass') === 'left'){
    current_image = (current_image - 1) < 1 ? max_image : (current_image -= 1);
  }

  if($(button).attr('data-carrousel-pass') === 'right'){
    current_image = (current_image + 1) > max_image ? 1 : (current_image += 1);
  }
  // se actualiza la imagen actual
  $('input#input-'+carrousel_id).attr('data-current-image', current_image);
  
  // se ocultan todas las imagnes
  $('div#'+carrousel_id +' > div.img').css('display', 'none');
  // se muestra la que toca
  $('div#'+carrousel_id +' > div.img-'+ current_image).css('display', 'block')
}

///////////// ********************************************** CHECKOUT ****************************************** ///////////////
// funcion para cargar el carrito
async function loadClientCart(){
  const loadCartFormData = new FormData();

  loadCartFormData.append('ajaxMethod', 'loadClientCart');
  ajaxHTMLRequest(loadCartFormData, "#cart_container");
  getTotalClientCart();
}

// funcion para cargar el carrito
async function getTotalClientCart(){
  const loadCartFormData = new FormData();

  loadCartFormData.append('ajaxMethod', 'getTotalClientCart');
  ajaxHTMLRequest(loadCartFormData, "#total_bill");
  
}

// ACCIONES PARA EL CARRITO DE COMPRA
async function clientCart(button){
  const cartFormData = new FormData();

  if($(button).attr('data-cart') === 'add'){
    // se agrega un producto al carrito
    cartFormData.append('id', $(button).attr('data-id'));
    cartFormData.append('name', $(button).attr('data-name'));
    cartFormData.append('price', $(button).attr('data-price'));
    cartFormData.append('symbol', $(button).attr('data-symbol'));
    cartFormData.append('idCurrency', $(button).attr('data-id-currency'));
  }else{
    // para aumenta y disminuir y para eliminar
    cartFormData.append('id', $(button).attr('data-id'));
  }

  cartFormData.append('ajaxMethod', "clientCart");
  cartFormData.append('action', $(button).attr('data-cart')); // accion en el carrito 

  result = await ajaxRequest(cartFormData);
  showNotification(result.Message, result.Success, true);

  if($("body").attr("id") === 'checkout'){
    loadClientCart();
  }
}

// FUNCION PARA CREAR UNA ORDEN DEL CLIENTE
async function makeOrder(e){
  e.preventDefault();

  const input_cardNum = $('input#carNumber');
  const input_expireDate = $('input#expireDate');
  const input_cvc = $('input#cvc');
  const input_shippingAddress = $('input#shippingAddress');


  // validacion de los datos
  if(!validInput(input_cardNum.val(), false, "Ingrese numero de tarjeta")) return false;
  if(!validInput(input_expireDate.val(), false, "Ingrese una fecha de vencimiento")) return false;
  if(!validInput(input_cvc.val(), false, "Ingrese un numero de seguridad")) return false;
  
  // validacion de la direccion
  if(!validInput(input_shippingAddress.val(), false, "Ingrese una direccion de entrega")) return false;
  
  // se obtiene la geolocalizacion
  const orderShippingLocation = await getGeoLocation(input_shippingAddress.val());
  if(!orderShippingLocation){ 
    showNotification('Dirección invalida', false); 
    return false;
  }
  // formdata
  const orderFormData = new FormData();

  orderFormData.append('cardNum', input_cardNum.val());
  orderFormData.append('expireDate', input_expireDate.val());
  orderFormData.append('cvc', input_cvc.val());
  orderFormData.append('location', orderShippingLocation);
  orderFormData.append('ajaxMethod', 'clientMakeOrder');

  console.log(...orderFormData);
  return;
  result = await ajaxRequest(orderFormData);

  showNotification(result.Message, result.Success, true);
  
  if(result.Success){
    setTimeout(()=>{
      window.location.href = URL_PATH + 'profile';
    }, 1500)
  }
}

function getGeoLocation(address){

  return new Promise(resolve => {
    $.ajax({
      url:'https://maps.googleapis.com/maps/api/geocode/json',
      type:'GET',
      data: {
        sensor : false,
        address : address,
        key : 'AIzaSyBX8-UhEanXF3-oc2HB4LA5He-QdBjRVa0'
      }
    }).done(function(data){

      if(data.results.length > 0){
        resolve(JSON.stringify(data.results[0].geometry.location));
      }else{
        resolve(false);
      }
      
    });
  });

  
}


///////////// ************************ CARGAR LOS SELECT ************************ ///////////////
async function loadSelectOptions(idSelect){

  const selectFormData = new FormData();
  selectFormData.append("idSelect", idSelect);
  selectFormData.append('ajaxMethod', "loadSelectOptions");

  ajaxHTMLRequest(selectFormData, "select#" + idSelect);
}

///////////// ************************ AJAX BACKEND CONN ************************ ///////////////
// FUNCION QUE REALIZA LA CONECCION CON EL BACKEND
// Debe haber un campo en el form data indicando el metodo a utilizar en el ajax controller llamado 'ajaxMethod'
async function ajaxRequest(formData){
    return new Promise(resolve => {
      $.ajax({
        url:AJAX_URL,
        type:'POST',
        processData: false,
        contentType: false,
        data: formData
      }).done(function(data){
        console.log(data);
        resolve(JSON.parse(data));
      });
    });
}

// FUNCION QUE REALIZA LA CONECCION CON EL BACKEND Y RETORNA UN HTML
// Debe haber un campo en el form data indicando el metodo a utilizar en el ajax controller llamado 'ajaxMethod'
// html container indica el contenedor en el cual va ser insertado el html es un string indicando el id
async function ajaxHTMLRequest(formData, html_container){
  $.ajax({
    url: AJAX_URL,
    type:'POST',
    processData: false,
    contentType: false,
    dataType:'html',
    data: formData
  }).done(function(data){
    $(html_container).html(data);
  });
}

  