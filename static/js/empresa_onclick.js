function add_libro() {
    document.getElementById("formulario_libro").style.display = "block"; // renderizar boton de volver
    document.getElementById("tabla_libros").style.display = "none"; // Ocultar tabla de libros
}

function info_convo(id) {
    var url = '/empresa/convo-info/' + id;
    window.location.href = url;
}

function seeInfoToDetail(IdElement) {
    var url = '/empresa/egresadp-info/' + IdElement;
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

function send_covo() {
    var id = document.getElementById("id").value;
    var titulo = document.getElementById("titulo").value;
    var biblioteca = document.getElementById("biblioteca").value;
    var autor = document.getElementById("autor").value;
    var estante = document.getElementById("estante").value;
    fetch(
    `/bibliotecario/libros/crear?id=${id}&titulo=${titulo}&biblioteca=${biblioteca}&autor=${autor}&estante=${estante}`
    )
        .then((response) => response.text())
        .then((data) => {
        alert(data);
        window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
        });
  }
  