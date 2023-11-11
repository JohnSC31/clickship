// VARIABLES GLOBALES
const URL_PATH = $('body').attr('data-url').replace(/[\\]/gi,'/');
const AJAX_URL = URL_PATH + 'app/controllers/Ajax.php';

(function () {
    "use strict";
  
    document.addEventListener('DOMContentLoaded', function (){
      // Despues de cargar todo el DOM se ejecuta el codigo
      // NAVEGACION DE ADMINISTRACION
      $("body").on("click", "[data-admin-nav]", function(e){
        e.stopPropagation();
        adminNavigation(e.currentTarget);
      });
  
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
///////////// ********************************************** ADMIN AREA ****************************************** ///////////////
///////////// **************************************************************************************************** ///////////////

// Funcionalidad de navegacion para el area de administracion
function adminNavigation(option){
  // style para el hover del menu
  if(!$(option).hasClass("active")){
    // se quita el active de todos y se coloca al actual
    $("ul#admin_nav li").removeClass("active");
    $(option).addClass("active")
  }
  // se ocultan todos los div
  $('div#dashboard_container > div').css('display', 'none');
  // se muestra el div correspondiente
  $('div#dashboard_container div.'+ $(option).attr("data-admin-nav") + '_container').css('display', 'flex');
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


  