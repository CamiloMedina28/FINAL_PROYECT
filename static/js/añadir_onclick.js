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