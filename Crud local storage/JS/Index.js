angular.module('todoApp', [])
    .controller('logueoController', function () {
        var login = this;
        login.showFormulario = false;

      
        login.ingresar = function(){
            var array =[];
            array = ParseLocal('arrayus');
            angular.forEach(array, function(element) {
               if (element.usuario == login.usingresado & element.clave == login.clavingresado){

                sessionStorage.setItem('LoginOK', 'Ok');
                window.location.href = "HTML/Alumnos/AltasyEdicion.html"

               }

              });
              
        }

        login.Registrarse = function(){
            window.location.href = "HTML/RegistroDeUsuarios/Registro.html"

        }
        

    
});