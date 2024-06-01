function add_libro(){
    document.getElementById("return_button").style.display = "block"; // renderizar boton de volver
    document.getElementById("tabla_libros").innerHTML = "<iframe src=''></iframe>";
    // fetch(`/bibliotecario/libros/crear?id=`)
}

function eliminar_libro(id_libro){
    let confirmacion = "¿Está seguro que desea eliminar el libro con id " + id_libro +"?";
    if (confirm(confirmacion)){
        fetch(`/bibliotecario/libros/eliminar?id=${id_libro}`)
    }
}