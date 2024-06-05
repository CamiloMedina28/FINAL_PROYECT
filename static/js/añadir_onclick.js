function add_libro(){
    document.getElementById("formulario_libro").style.display = "block"; // renderizar boton de volver
    document.getElementById("tabla_libros").style.display = "none"; // Ocultar tabla de libros
}

function eliminar_libro(id_libro){
    let confirmacion = "¿Está seguro que desea eliminar el libro con id " + id_libro +"?";
    if (confirm(confirmacion)){
        fetch(`/bibliotecario/libros/eliminar?id=${id_libro}`)
    }
}

function send_info_book(){
    var id = document.getElementById('id').value;
    var titulo = document.getElementById('titulo').value;
    var biblioteca = document.getElementById('biblioteca').value;
    var autor = document.getElementById('autor').value;
    var estante = document.getElementById('estante').value;
    fetch(`/bibliotecario/libros/crear?id=${id}&titulo=${titulo}&biblioteca=${biblioteca}&autor=${autor}&estante=${estante}`)
}

function add_prestamo(){
    document.getElementById("formulario_prestamo").style.display = "block"; // renderizar boton de volver
    document.getElementById("tabla_prestamos").style.display = "none"; // Ocultar tabla de libros
}

function send_prestamo(){
    var documento = document.getElementById('documento').value;
    var id_libro = document.getElementById('id_libro').value;
    fetch(`/bibliotecario/prestamo/agregarprestamo?documento=${documento}&id_libro=${id_libro}`)
}

function eliminar_prestamo(){
    fetch(``)
}
