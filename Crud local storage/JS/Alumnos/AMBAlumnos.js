angular.module('todoApp', [])
    .controller('UsuariosController', function () {
        
        var alumnoslista = this;
        
        VerificacionLogin(sessionStorage.getItem('LoginOK'));
        ValidarLocal('arrayalumnos');
        alumnoslista.pefiles = ParseLocal('arrayperfil');
        alumnoslista.lista = ParseLocal('arrayalumnos');


        alumnoslista.showFormulario = false;
        alumnoslista.soyAlta = false;
      


        alumnoslista.addUsuario = function () {
            var usuario = { dni: alumnoslista.NewDNI, nombre: alumnoslista.NewUserNombre, apellido: alumnoslista.NewUserApellido, estado: alumnoslista.estado, nota1: alumnoslista.nota1, nota2 : alumnoslista.nota2 }
            if(usuario.dni!=""){
                if(!this.ValidarUsuario(usuario, alumnoslista.lista)){
                    alumnoslista.lista.push(usuario);
                    SetLocal('arrayalumnos',  alumnoslista.lista);
                }else{
                    alert("DNI ya ingresado")
                }
                
            }else{
                alert("el dni no puede estar vacio");
            }
           
            
        };


        alumnoslista.delUsuario = function (index) {
            alumnoslista.lista.splice(index, 1);
            SetLocal('arrayalumnos',  alumnoslista.lista);

        };

        alumnoslista.indexAEditar = 0;

        alumnoslista.ModificarUsuario = function (usuario, index) {
            alumnoslista.showFormulario = true;
            alumnoslista.soyAlta = false;
            alumnoslista.indexAEditar = index;
            alumnoslista.NewDNI = usuario.dni;
            alumnoslista.NewUserNombre = usuario.nombre;
            alumnoslista.NewUserApellido = usuario.apellido;
            alumnoslista.nota1 = usuario.nota1;
            alumnoslista.nota2 = usuario.nota2;
            alumnoslista.estado = usuario.estado;

        };

        alumnoslista.SaveModificarUsuario = function () {
            alumnoslista.lista[alumnoslista.indexAEditar].dni = alumnoslista.NewDNI;
            alumnoslista.lista[alumnoslista.indexAEditar].nombre = alumnoslista.NewUserNombre;
            alumnoslista.lista[alumnoslista.indexAEditar].apellido = alumnoslista.NewUserApellido;
            alumnoslista.lista[alumnoslista.indexAEditar].nota1 = alumnoslista.nota1;
            alumnoslista.lista[alumnoslista.indexAEditar].nota2 = alumnoslista.nota2;
            alumnoslista.lista[alumnoslista.indexAEditar].estado = alumnoslista.estado;

            SetLocal('arrayalumnos',  alumnoslista.lista);

        };

        alumnoslista.nuevoUsuario = function () {
            alumnoslista.NewDNI = "";
            alumnoslista.NewUserNombre = "";
            alumnoslista.NewUserApellido = "";
            alumnoslista.nota1 = "";
            alumnoslista.nota2 = "";


            alumnoslista.showFormulario = true;
             alumnoslista.soyAlta = true;
        };

        alumnoslista.ModificarPerfiles = function(){
            window.location.href = "../../HTML/Perfiles/ABMperfiles.html";

        }
        
        alumnoslista.Listar = function(){
            window.location.href = "../../HTML/Reportes/ListadoTotal.html";

        }

        alumnoslista.ValidarUsuario = function(alumno, arrayperfiles) {
                var repetido = false;
                arrayperfiles.forEach(element => {
                    if(element.dni == alumno.dni){
                        repetido=true;
                    }
                });
                return repetido;
            }  
            alumnoslista.manual = function(){
                window.location.href = "../../manual.pdf";
            }

    });