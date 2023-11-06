// VARIABLES GLOBALES

(function () {
    "use strict";
  
    document.addEventListener('DOMContentLoaded', function (){
      // Despues de cargar todo el DOM se ejecuta el codigo
    
  
    }); // end DOMContentLoaded
  
  
})();

// ///////////////// *******************************  FUNCIONES  ****************************** /////////////////////


///////////// ************************ AJAX BACKEND CONN ************************ ///////////////
// FUNCION QUE REALIZA LA CONECCION CON EL BACKEND
// Debe haber un campo en el form data indicando el metodo a utilizar en el ajax controller llamado 'ajaxMethod'
async function ajaxRequest(formData){
    return new Promise(resolve => {
      $.ajax({
        url:'app/controllers/Ajax.php',
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

  