function add_libro() {
    document.getElementById("formulario_libro").style.display = "block"; // renderizar boton de volver
    document.getElementById("tabla_libros").style.display = "none"; // Ocultar tabla de libros
}

function info_convo(id) {
    var url = '/empresa/convo-info/' + id;
    window.location.href = url;
}

function seeInfoToDetail(IdElement) {
    var url = '/informacion_personal_egresados/' + IdElement;
    window.location.href = url;
}
function info_aplicantes(id_emp) {
    var id_emp = id_emp;
    var url = '/empresa/aplicadas/' + id_emp;
    window.location.href = url;
}

function volver_convocatorias() {
    var url = '/empresa/convocatorias';
    window.location.href = url;
}

function update_aplicacion(id_egr, id_con, estado) {
    let confirmacion =
    "¿Está seguro que desea " + estado + " al aplicante con cedula: "+ id_egr
    + " para la convocatoria con id " + id_con + "?";
    if (confirm(confirmacion)) {
    fetch(`/empresa/aplicadas/update?id_con=${id_con}&id_egr=${id_egr}&estado=${estado}`)
        .then((response) => response.text())
        .then((data) => {
        alert(data);
        });
    }
    setTimeout(function() {
        var url = '/empresa/aplicadas/' + id_con;
        window.location.href = url;
    }, 1000);
}

function eliminar_convo(id_convo) {
    let confirmacion =
    "¿Está seguro que desea eliminar la convocatoria con id " + id_convo + "?";
    if (confirm(confirmacion)) {
    fetch(`/empresa/convocatorias/eliminar?id=${id_convo}`)
        .then((response) => response.text())
        .then((data) => {
        alert(data);
        });
    }
}

function sendConvo() {
    var cargo = document.getElementById("cargo").value;
    var habilidades = document.getElementById("habilidades").value;
    var competencias = document.getElementById("competencias").value;
    var experiencia = document.getElementById("experiencia").value;
    var vacantes = document.getElementById("vacantes").value;
    var salario = document.getElementById("salario").value;
    var jornada = document.getElementById("jornada").value;
    var horario = document.getElementById("horario").value;
    var teletrabajo = document.getElementById("teletrabajo").value;
    var pais = document.getElementById("pais").value;
    var ciudad = document.getElementById("ciudad").value;
    var fechaOUT = document.getElementById("fechaOUT").value;
    let confirmacion =
    "¿Está seguro que desea crear una nueva convocatoria?";
    if (confirm(confirmacion)) {
    fetch(`/empresa/convocatorias/crear?titulo=${id}&cargo=${cargo}&habilidades=${habilidades}&competencias=${competencias}&experiencia=${experiencia}&vacantes=${vacantes}&salario=${salario}&jornada=${jornada}&horario=${horario}&teletrabajo=${teletrabajo}&pais=${pais}&ciudad=${ciudad}&fechaOUT=${fechaOUT}`)
        .then((response) => response.text())
        .then((data) => {
            alert(data);
            window.location.href = "http://127.0.0.1:5010/empresa/convocatorias";
        });}
}