angular.module('todoApp', [])
    .controller('ValidacionesController', function () {
        var usuarios = this;
        ValidarLocal('arrayus');
        usuarios.lista = ParseLocal('arrayus');
        SetLocal('arrayus', usuarios.lista);

      

        usuarios.clavevalida = true;
        usuarios.usuariorepetido = false;

        usuarios.validarClaves = function (usuario) {
            var claveVal = false;
            if (usuario.clave == usuario.claverep && usuario.claverep != "" && usuario.claverep != null ) {
                claveVal = true;
            }
            return claveVal;
        }

        usuarios.ValidarUsuarios = function (usuario, arrayUsuarios) {
            var repetido = false;
            arrayUsuarios.forEach(element => {
                if(element.usuario == usuario.usuario){
                    repetido=true;
                    usuarios.usuariorepetido = true;
                }
            });
            return repetido;
        }


        usuarios.addToUsuarios = function () {
            var usuario = { usuario: usuarios.usuario, clave: usuarios.clave, claverep: usuarios.rclave };
            if (usuarios.validarClaves(usuario)) {
                usuarios.lista = ParseLocal('arrayus');
                if(!this.ValidarUsuarios(usuario, usuarios.lista)){
                    usuarios.lista.push(usuario)
                    SetLocal('arrayus', usuarios.lista);
                    alert("usuario creado exitosamente");
                    usuarios.usuario = "";
                    usuarios.clave = "";
                    usuarios.rclave="";
                    window.location.href = "../../Index.html"
                }

                
            }

        
        }

       


        
    
});