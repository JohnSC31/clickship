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

        // carga al ingresar en el input
        $("input#product_search").on("change", loadProducts);
        // carga productos al cambiar el select
        $("select#select_categorie").on("change", loadProducts);
      }

      // PAGINA DE CHECKOUT
      if($("body").attr('id') === 'checkout'){
        loadClientCart();
        $("body").on("submit", "form#order_form", makeOrder);
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

// FUNCION PARA EL REGISTRO DE UN NUEVO USUARIO
async function clientSignupForm(e){
  e.preventDefault();

  // optienen los campos del formulario
  const input_name = $('input#name');
  const input_lastnames = $('input#lastnames');
  const input_email = $('input#email');
  const input_pass = $('input#pass');

  // validan los datos
  if(!validInput(input_name.val(), false, "Ingrese un nombre")) return false;
  if(!validInput(input_lastnames.val(), false, "Ingrese un apellido")) return false;
  if(!validEmail(input_email.val())) return false;
  if(!validPassword(input_pass.val())) return false;

  const signupFormData = new FormData();
  signupFormData.append('name', input_name.val());
  signupFormData.append('lastnames', input_lastnames.val());
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


// CLICK DE LOS PRODUCTOS PARA VERLO EN LA PAGINA
function productPage(e){
  e.preventDefault();
  console.log("click");
  const idProduct = $(this).attr('data-item');
  window.location.href = URL_PATH + 'product/' + idProduct;
}

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


// FUNCION DE BUSQUEDA Y FILTROS PARA CARGAR LOS PRODUCTOS
async function loadProducts(){

  const input_search_product = $('input#product_search');
  const select_categorie = $('select#select_categorie');

  const filtersProduct = new FormData();
  if($(input_search_product).val() !== ""){
    filtersProduct.append('search', input_search_product.val());
  }

  if($(select_categorie).val() !== ""){
    filtersProduct.append('idCategorie', select_categorie.val());
  }
  
  filtersProduct.append('ajaxMethod', "loadProducts");  

  ajaxHTMLRequest(filtersProduct, "#product_list");

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
    showNotification('Direccion invalida', false); 
    return false;
  }
  // formdata
  const orderFormData = new FormData();

  orderFormData.append('cardNum', input_cardNum.val());
  orderFormData.append('expireDate', input_expireDate.val());
  orderFormData.append('cvc', input_cvc.val());
  orderFormData.append('location', orderShippingLocation);
  orderFormData.append('ajaxMethod', 'clientMakeOrder');

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

  