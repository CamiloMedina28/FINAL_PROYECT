function eliminar_egresado(id){
    fetch(`/eliminar_egresado?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
        // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
        alert(data);
    });
}

function eliminar_familiar(id){
    fetch(`/eliminar_familiar?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
        // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
        alert(data);
    });
}

function eliminar_residencia(id){
    fetch(`/eliminar_residencia?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
        // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
        alert(data);
    });
}


function eliminar_distincion(id){
    fetch(`/eliminar_distincion?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
        // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
        alert(data);
    });
}

function add_info_form(){
    document.getElementById('tabla_info').style.display = 'none';
    document.getElementById('formulario_añadir').style.display = 'flex';
}