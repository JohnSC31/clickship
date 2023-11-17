// VARIABLES GLOBALES
const URL_PATH = $('body').attr('data-url').replace(/[\\]/gi,'/');
const AJAX_URL = URL_PATH + 'app/controllers/Ajax.php';

(function () {
    "use strict";
  
    document.addEventListener('DOMContentLoaded', function (){
      // Despues de cargar todo el DOM se ejecuta el codigo

      //LOGIN
      $("body").on("submit", "form#admin_login", loginAdmin);

      // APERTURA DE LOS MODALS
      $("body").on("click", "[data-modal]", openModal);
      $("body").on("click", "[close-modal]", closeModal);

      // NAVEGACION DE ADMINISTRACION
      $("body").on("click", "[data-admin-nav]", function(e){
        e.stopPropagation();
        adminNavigation(e.currentTarget);
      });

      //LOGOUT
      $("body").on("click", "[data-admin-logout]", logoutAdmin);
      

      // INICIALIZACION DE LA DATA TABLES
      // -------------------------------------------------------------------SECCION DE VENTAS
      initDataTable('sells', 'loadDataTableSells');
      $("body").on("click", "[data-update-order-status]", changeOrderStatus);
      

      // -------------------------------------------------------------------SECCION DE INVENTARIO
      initDataTable('inventory', 'loadDataTableInventory');
      $("body").on("submit", "form#add_product", addProduct); // agrega producto
      $("body").on("click", "[data-delete-product]", deleteProduct); // elimina producto
      $("body").on("submit", "form#edit_product", editProduct); // edita product

      loadSelectOptions('catProduct'); // carga select de categorias

      // carrusel de imagenes del producto
      $("body").on("click", "[data-carrousel-pass]", function(e){
        e.stopPropagation();
        changeCarrouselImage(e.currentTarget);
      });

      // -------------------------------------------------------------------SECCION DE RECURSOS HUMANOS
      initDataTable('rrhh', 'loadDataTableRrhh');
      $("body").on("submit", "form#add_employee", addEmployee); // agrega empleado
      $("body").on("submit", "form#add_hours", addEmployeeHours); // agrega horas
      $("body").on("click", "[data-calc-paid]", calcEmployeePaid); // calcular el pago
      
      loadSelectOptions('country'); // carga select de paises
      loadSelectOptions('rol'); // carga select de roles
      loadSelectOptions('department'); // carga select de departamentos
      loadSelectOptions('currency'); // carga select de monedas

      // -------------------------------------------------------------------SECCION DE SERVICIO AL CLIENTE
      initDataTable('service', 'loadDataTableService');
      $("body").on("submit", "form#add_call", addCall); // agrega llamada
      
      loadSelectOptions('questionType'); // carga select de paises
  
    }); // end DOMContentLoaded
  
  
})();

// ///////////////// *******************************  FUNCIONES  ****************************** /////////////////////

// FUNCION PARA ABRIR Y CARGAR UN MODAL
function openModal(e){
  e.preventDefault();
  const modalName = $(this).attr('data-modal');
  const modalData = $(this).attr('data-modal-data') !== undefined ? JSON.parse($(this).attr('data-modal-data')) : {};

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
    // console.log(data);
    $('div#modal_container').html(data);
    $('div#modal_container').css('display', 'block'); // estaba en flex
    $('body').css('overflow', 'hidden');

    // acciones para los modals
    if(modalName === "product"){
      loadSelectOptions('catProduct');
    }
  });
}

// FUNCION PARA CERRAR UN MODAL
function closeModal(e = false){
  if(e) e.preventDefault();
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
// validar inputs comunes
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
// validar contrasenas
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
// validar correos
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
// valida archivos
function validFiles(fileInput){

  if(fileInput[0].files.length == 0){
    showNotification("Ingrese al menos una imagen", false);
    return false
  }

  for (var i = 0; i < fileInput[0].files.length; i++){
    
    if (fileInput[0].files[i] && fileInput[0].files[i].size < 2000000){ 
      return true;
    }
    var msjError;
    if(!fileInput[0].files[i]) msjError = 'Selecciona un archivo';

    if(fileInput[0].files[i] && fileInput[0].files[i].size > 2000000) msjError = 'El archivo seleccionado es muy grande';
    showNotification(msjError, false);
    return false;

  }

  
  
}

///////////// **************************************************************************************************** ///////////////
///////////// ********************************************** ADMIN AREA ****************************************** ///////////////
///////////// **************************************************************************************************** ///////////////

// FUNCION PARA INICIAR SESION DE ADMINSITRADOR
async function loginAdmin(e){
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
  loginFormData.append('ajaxMethod', "adminLogin");  

  result = await ajaxRequest(loginFormData);
  showNotification(result.Message, result.Success, false);

  if(result.Success){
    setTimeout(()=>{
      window.location.href = URL_PATH + 'home';
    }, 1500)
  }
}

// CERRAR SESION DE ADMINSITRADOR
async function logoutAdmin(e){
  e.preventDefault();

  const logoutFormData = new FormData();
  logoutFormData.append('ajaxMethod', "adminLogout");  

  result = await ajaxRequest(logoutFormData);
  showNotification(result.Message, result.Success, false);

  if(result.Success){
    setTimeout(()=>{
      window.location.href = URL_PATH + 'login';
    }, 1500)
  }
}

// FUNCION PARA LA INICIALIZACION DE LAS DATATABLES
// ///////////////////////----------------------AJAX TABLE LOADES/ CARGADOR PARA LAS TABLAS AJAX ---------------------////////////////////////////
function initDataTable(table, ajaxMethod){
  const columns = getDataTableColumns(table);
  $("#"+table+"-table").DataTable({
    "responsive": true,
    "autoWidth": false,
    "processing": true,
    "serverSide": true,
    "ajax":{
      url: AJAX_URL,
      type:"POST",
      data: {ajaxMethod: ajaxMethod, table:table}
    },
    "columns": columns
  });
}

// FUNCION PARA OBTENER LAS COLUMNAS DE LAS DATATABLES
function getDataTableColumns(table){
  var columns = new Array();
  //COLS PARA VENTAS
  if(table === 'sells') columns = [{data: 'idSell'}, {data: 'clientName'}, {data: 'status'}, {data: 'date'}];

  // COLS PARA INVENTARIO
  if(table === 'inventory') columns = [{data: 'id'}, {data: 'name'}, {data: 'categorie'}, {data: 'price'}, {data: 'amount'}];

  // COLS PARA RECURSOS HUMANOS
  if(table === 'rrhh') columns = [{data: 'name'}, {data: 'email'}, {data: 'country'}, {data: 'rol'}, {data: 'department'}];

  // COLS PARA SERVICIO AL CLIENTE
  if(table === 'service') columns = [{data: 'client'}, {data: 'type'}, {data: 'employee'}, {data: 'date'}, {data: 'idOrder'}];

  //PARA LAS ACCIONES
  columns.push({data: 'actions', "orderable": false });

  return columns;
}

//RECARGAR LAS DATA TABLES
function refreshDataTables(table){
  $("#"+table+"-table").DataTable().ajax.reload();
}

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
  $('div#dashboard_container div.'+ $(option).attr("data-admin-nav") + '_container').css('display', 'block');

  // ACCIONES PARA LAS SECCIONES
  if($(option).attr("data-admin-nav") === 'sells'){
    refreshDataTables('sells'); // recarga la tabla
  }

  if($(option).attr("data-admin-nav") === 'inventory'){
    refreshDataTables('inventory'); // recarga la tabla
  }

  if($(option).attr("data-admin-nav") === 'human_resources'){
    refreshDataTables('rrhh'); // recarga la tabla
  }

  if($(option).attr("data-admin-nav") === 'client_service'){
    refreshDataTables('service'); // recarga la tabla
  }
}

//-------------------------------------------------- SECCION DE VENTAS---------------------------------------------------------
async function changeOrderStatus(e){
  e.preventDefault();
  const status = $(this).attr('data-update-order-status');
  const idOrder = $(this).attr('data-id-order');

  const orderFormData = new FormData();
  orderFormData.append('status', status);
  orderFormData.append('idOrder', idOrder);

  orderFormData.append('ajaxMethod', "changeOrderStatus");  

  result = await ajaxRequest(orderFormData);

  showNotification(result.Message, result.Success);

  if(result.Success){
    refreshDataTables('sells'); // recarga la tabla
  }

}

// -------------------------------------------------- SECCION DE INVENTARIO ---------------------------------------------------
// se agrega un producto
async function addProduct(e){
  e.preventDefault();

  // optienen los campos del formulario
  const input_name = $('input#name');
  const select_catProduct = $('select#catProduct');
  const input_price = $('input#price');
  const textarea_detail = $('textarea#detail');

  const input_AmountStore1 = $('input#amountStore1');
  const input_AmountStore2 = $('input#amountStore2');
  const input_AmountStore3 = $('input#amountStore3');
  
  const input_images = $('input#product_images');

  // validan los datos
  if(!validInput(input_name.val(), false, "Ingrese un nombre")) return false;
  if(!validInput(select_catProduct.val(), false, "Escoga una categoria")) return false;
  if(!validInput(input_price.val(), false, "Ingrese un precio")) return false;
  if(!validInput(textarea_detail.val(), false, "Ingrese un detalle")) return false;

  if(!validInput(input_AmountStore1.val(), false, "Ingrese una cantidad para bodega 1")) return false;
  if(!validInput(input_AmountStore2.val(), false, "Ingrese una cantidad para bodega 2")) return false;
  if(!validInput(input_AmountStore3.val(), false, "Ingrese una cantidad para bodega 3")) return false;

  // validacion de archivos
  if(!validFiles(input_images)) return false;
  

  const productFormData = new FormData();
  productFormData.append('name', input_name.val());
  productFormData.append('idCategorie', select_catProduct.val());
  productFormData.append('price', input_price.val());
  productFormData.append('detail', textarea_detail.val());

  productFormData.append('amountStore1', input_AmountStore1.val());
  productFormData.append('amountStore2', input_AmountStore2.val());
  productFormData.append('amountStore3', input_AmountStore3.val());

  for (var i = 0; i < input_images[0].files.length; i++){
    productFormData.append("image_"+ i, input_images[0].files[i]);
  }
  
  productFormData.append('action', "add");

  productFormData.append('ajaxMethod', "adminProducts");  

  result = await ajaxRequest(productFormData);

  showNotification(result.Message, result.Success);
  if(result.Success){
    $(this)[0].reset();// se resetea al formulario
    refreshDataTables('inventory'); // recarga la tabla
  }

}
// se edita un producto
async function editProduct(e){
  e.preventDefault();

  // optienen los campos del formulario
  const input_name = $('form#edit_product input#name');
  const select_catProduct = $('form#edit_product select#catProduct');
  const input_price = $('form#edit_product input#price');
  const textarea_detail = $('form#edit_product textarea#detail');

  const input_AmountStore1 = $('form#edit_product input#amountStore1');
  const input_AmountStore2 = $('form#edit_product input#amountStore2');
  const input_AmountStore3 = $('form#edit_product input#amountStore3');
  
  const input_images = $('form#edit_product input#product_images');

  // validan los datos
  if(!validInput(input_name.val(), false, "Ingrese un nombre")) return false;
  if(!validInput(select_catProduct.val(), false, "Escoga una categoria")) return false;
  if(!validInput(input_price.val(), false, "Ingrese un precio")) return false;
  if(!validInput(textarea_detail.val(), false, "Ingrese un detalle")) return false;

  if(!validInput(input_AmountStore1.val(), false, "Ingrese una cantidad para bodega 1")) return false;
  if(!validInput(input_AmountStore2.val(), false, "Ingrese una cantidad para bodega 2")) return false;
  if(!validInput(input_AmountStore3.val(), false, "Ingrese una cantidad para bodega 3")) return false;

  // validacion de archivos si no hay no hace nada
  if(!validFiles(input_images) && input_images[0].files.length > 0) return false;
  

  const productFormData = new FormData();
  productFormData.append('id', $("form#edit_product input#idProduct").attr('data-id'));
  productFormData.append('name', input_name.val());
  productFormData.append('idCategorie', select_catProduct.val());
  productFormData.append('price', input_price.val());
  productFormData.append('detail', textarea_detail.val());

  productFormData.append('amountStore1', input_AmountStore1.val());
  productFormData.append('amountStore2', input_AmountStore2.val());
  productFormData.append('amountStore3', input_AmountStore3.val());

  for (var i = 0; i < input_images[0].files.length; i++){
    productFormData.append("image_"+ i, input_images[0].files[i]);
  }
  
  productFormData.append('action', "edit");

  productFormData.append('ajaxMethod', "adminProducts");  

  result = await ajaxRequest(productFormData);

  showNotification(result.Message, result.Success);
  if(result.Success){
    $(this)[0].reset();// se resetea al formulario
    refreshDataTables('inventory');
  }
}
async function deleteProduct(e){
  e.preventDefault();

  const idProduct = $(this).attr('data-delete-product');

  const deleteProductFormData = new FormData();
  deleteProductFormData.append('idProduct', idProduct);  
  deleteProductFormData.append('action', "delete");  
  deleteProductFormData.append('ajaxMethod', "adminProducts");  

  result = await ajaxRequest(deleteProductFormData);
  showNotification(result.Message, result.Success);
}

function changeCarrouselImage(button){

  var carrousel_id = $(button).attr('data-carrousel-id');

  var max_image = parseInt($('input#input-'+carrousel_id).attr('data-max-image'));
  var current_image = parseInt($('input#input-'+carrousel_id).attr('data-current-image'));

  if($(button).attr('data-carrousel-pass') === 'left'){
    current_image = current_image - 1 < 0 ? max_image: current_image -= 1;
  }

  if($(button).attr('data-carrousel-pass') === 'right'){
    current_image = current_image + 1 > max_image ? 0 : current_image += 1;
  }
  // se actualiza la imagen actual
  $('input#input-'+carrousel_id).attr('data-current-image', current_image);
  
  // se ocultan todas las imagnes
  $('div#'+carrousel_id +' > div.img').css('display', 'none');
  // se muestra la que toca
  $('div#'+carrousel_id +' > div.img-'+ current_image).css('display', 'block')
}

// -------------------------------------------------- SECCION DE RECURSOS HUMANOS ---------------------------------------------------
// se agrega un empleado
async function addEmployee(e){
  e.preventDefault();

  // optienen los campos del formulario
  const input_name = $('input#employee_name');
  const input_lastname = $('input#lastname');
  const input_email = $('input#email');
  const select_country = $('select#country');
  const select_rol = $('select#rol');
  const select_department = $('select#department');

  const input_salary = $('input#salary');
  const select_currency = $('select#currency');

  // validan los datos
  if(!validInput(input_name.val(), false, "Ingrese un nombre")) return false;
  if(!validInput(input_lastname.val(), false, "Ingrese un apellido")) return false;
  if(!validEmail(input_email.val())) return false;

  if(!validInput(select_country.val(), false, "Escoga un pais")) return false;
  if(!validInput(select_rol.val(), false, "Escoga un rol")) return false;
  if(!validInput(select_department.val(), false, "Escoga un departamento")) return false;

  if(!validInput(input_salary.val(), false, "Ingrese un salario")) return false;
  if(!validInput(select_currency.val(), false, "Escoga una moneda")) return false;
  

  const employeeFormData = new FormData();
  employeeFormData.append('name', input_name.val());
  employeeFormData.append('lastname', input_lastname.val());
  employeeFormData.append('email', input_email.val());

  employeeFormData.append('idCountry', select_country.val());
  employeeFormData.append('idRol', select_rol.val());
  employeeFormData.append('idDepartment', select_department.val());

  employeeFormData.append('salary', input_salary.val());
  employeeFormData.append('idCurrency', select_currency.val());

  employeeFormData.append('ajaxMethod', "addEmployee");  

  result = await ajaxRequest(employeeFormData);

  showNotification(result.Message, result.Success);
  if(result.Success){
    $(this)[0].reset();// se resetea al formulario
    refreshDataTables('rrhh'); // recarga la tabla
  }

}

// funcion para agregar las horas de un empleado
async function addEmployeeHours(e){
  e.preventDefault();

  const input_workedHours = $('input#workedHours');
  const select_day = $('select#day');

  if(!validInput(input_workedHours.val(), false, "Ingrese horas")) return false;
  if(!validInput(select_day.val(), false, "Escoga un dia")) return false;

  const employeeFormData = new FormData();
  employeeFormData.append('hours', input_workedHours.val());
  employeeFormData.append('idDay', select_day.val());
  employeeFormData.append('idEmployee', $('input[data-id-employee]').val());

  employeeFormData.append('ajaxMethod', "addHoursEmployee"); 

  result = await ajaxRequest(employeeFormData);

  showNotification(result.Message, result.Success);
  if(result.Success){
    $(this)[0].reset();// se resetea al formulario
    refreshDataTables('rrhh'); // recarga la tabla
  }
  
}

// funcion para calcular el pago de un empleado
async function calcEmployeePaid(e){
  e.preventDefault();

  const idEmployee = $(this).attr('data-calc-paid');

  const employeeFormData = new FormData();
  employeeFormData.append('idEmployee', idEmployee);  
  employeeFormData.append('ajaxMethod', "calcEmployeePaid");  

  result = await ajaxRequest(employeeFormData);
  showNotification(result.Message, result.Success);
  if(result.Success){
    $("span#calc_paid").text(result.Data);
  }
}
// -------------------------------------------------- SECCION DE SERVICIO AL CLIENTE ---------------------------------------------------
async function addCall(e){
  e.preventDefault();

  const input_idOrder = $('input#idOrder');
  const select_questionType = $('select#questionType');
  const textarea_detail = $('textarea#call_detail');

  if(!validInput(input_idOrder.val(), false, "Ingrese una orden")) return false;
  if(!validInput(select_questionType.val(), false, "Escoga un tipo de pregunta")) return false;
  if(!validInput(textarea_detail.val(), false, "Ingrese un detalle")) return false;

  const callFormData = new FormData();
  callFormData.append('idOrder', input_idOrder.val());
  callFormData.append('idQuestionType', select_questionType.val());
  callFormData.append('detail', textarea_detail.val());

  callFormData.append('ajaxMethod', "addCall"); 

  result = await ajaxRequest(callFormData);

  showNotification(result.Message, result.Success);
  if(result.Success){
    $(this)[0].reset();// se resetea al formulario
    refreshDataTables('services'); // recarga la tabla
  }
  
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


  