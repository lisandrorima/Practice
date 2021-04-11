angular.module('todoApp', [])
    .controller('ListadosController', function () {
        
        var alumnoslista = this;
        VerificacionLogin(sessionStorage.getItem('LoginOK'));
        alumnoslista.lista = ParseLocal('arrayalumnos');


        alumnoslista.CargarPromedios = function (){
            alumnoslista.listapromedios =[]
            alumnoslista.lista.forEach(element => {
                var promedio = (parseFloat(element.nota1) + parseFloat(element.nota2))/2
                var alupro = {dni: element.dni, nombre: element.nombre, apellido: element.apellido, estado: element.estado, promedio: promedio}
                alumnoslista.listapromedios.push(alupro);
            });
            SetLocal('arraypromedios',  alumnoslista.listapromedios);
        }


        alumnoslista.LisarAplazados = function (){
            alumnoslista.listapromedios = [];
            alumnoslista.lista.forEach(element => {
                var promedio = (parseFloat(element.nota1) + parseFloat(element.nota2))/2
                var alupro = {dni: element.dni, nombre: element.nombre, apellido: element.apellido, estado: element.estado, promedio: promedio}
                if(promedio<4){
                    alumnoslista.listapromedios.push(alupro);
                }
                
            });
            SetLocal('arraypromedios',  alumnoslista.listapromedios);

        }

        alumnoslista.ListarAprobados = function (){
            alumnoslista.listapromedios = [];
            alumnoslista.lista.forEach(element => {
                var promedio = (parseFloat(element.nota1) + parseFloat(element.nota2))/2
                var alupro = {dni: element.dni, nombre: element.nombre, apellido: element.apellido, estado: element.estado, promedio: promedio}
                if(promedio>4){
                    alumnoslista.listapromedios.push(alupro);
                }
                
            });
            SetLocal('arraypromedios',  alumnoslista.listapromedios);

        }


        alumnoslista.ModificarUs = function(){
            window.location.href = "../../HTML/Alumnos/AltasyEdicion.html";
        }

        
    });