function ValidarLocal(nombreses){
    if(JSON.parse(localStorage.getItem(nombreses))==null){
        nomarray = nombreses;
        nombreses =[]
        localStorage.setItem(nomarray, JSON.stringify(nombreses));
    }
}

function ParseLocal(nombreses){
    var array =[]
    array = JSON.parse(localStorage.getItem(nombreses));
    return array;
}

function SetLocal(nombreses, array){
    localStorage.setItem(nombreses, JSON.stringify(array));
}

function GetLogin(){
    var data = sessionStorage.getItem('loginOK')
    VerificacionLogin(data);
}

function SetLogin(){
    if(sessionStorage.getItem('loginOK') == null){
        sessionStorage.setItem('LoginOk', 'OK')
    }
   
}


function VerificacionLogin(data){

    if(data != 'Ok' | data == null)
    {
        window.location.href = "../../index.html";
    }
}

