angular.module('todoApp', [])
    .controller('PerfilesController', function () {

        var perfiles = this;
        VerificacionLogin(sessionStorage.getItem('LoginOK'));
        ValidarLocal('arrayperfil');
        perfiles.lista = ParseLocal('arrayperfil');
        perfiles.alumnos = ParseLocal('arrayalumnos');


        perfiles.showFormulario = false;
        perfiles.soyAlta = false;








        perfiles.addUsuario = function () {
            var perfil = { nombre: perfiles.NewUserNombre }
            if(perfil.nombre!=""){
                if (!this.ValidaPerfiles(perfil, perfiles.lista)) {

                    perfiles.lista.push(perfil);
                    SetLocal('arrayperfil', perfiles.lista);
                } else {
                    alert("perfil repetido");
                }
            }else{
                alert("El perfil no puede estar vacio");
            }
           

        };


        perfiles.delUsuario = function (index) {
            var perfil = perfiles.lista[index]
            if (!this.ValidarAlumnos(perfil, perfiles.alumnos)) {
                perfiles.lista.splice(index, 1);
                SetLocal('arrayperfil', perfiles.lista);

            } else {
                alert("no se puede borrar porque existe un alumno con este perfil");
            }

        };

        perfiles.indexAEditar = 0;

        perfiles.ModificarUsuario = function (perfil, index) {

            if (!this.ValidarAlumnos(perfil, perfiles.alumnos)) {
                perfiles.showFormulario = true;
                perfiles.soyAlta = false;
                perfiles.indexAEditar = index;
                perfiles.NewUserNombre = perfil.nombre;
            } else {
                alert("no se puede modificar el perfil porque existe un alumno con este perfil");

            }



        };

        perfiles.SaveModificarUsuario = function () {

            perfiles.lista[perfiles.indexAEditar].nombre = perfiles.NewUserNombre;
            SetLocal('arrayperfil', perfiles.lista);



        };

        perfiles.nuevoUsuario = function () {
            perfiles.NewUserNombre = "";
            perfiles.showFormulario = true;
            perfiles.soyAlta = true;
        };



        perfiles.perfilrepetido = false;

        perfiles.ModificarPerfiles = function () {
            window.location.href = "../../HTML/Perfiles/ABMperfiles.html";

        }

        perfiles.sendtoalumnos = function () {
            window.location.href = "../../HTML/Alumnos/AltasyEdicion.html";

        }

        perfiles.ValidaPerfiles = function (perfil, arrayperfiles) {
            var repetido = false;
            arrayperfiles.forEach(element => {
                if (element.nombre == perfil.nombre) {
                    repetido = true;
                    perfiles.perfilrepetido = true;
                }
            });
            return repetido;
        }

        perfiles.ValidarAlumnos = function (perfil, arrayalumnos) {
            var repetido = false;
            arrayalumnos.forEach(element => {
                if (element.estado.nombre == perfil.nombre) {
                    repetido = true;
                }
            });
            return repetido;
        }


    });