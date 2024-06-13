function autorizar_user(documento){
    fetch(`/autorizar_usuario?documento=${documento}`)
    .then(response => response.text())
    .then(data => {
        alert(data);
        window.location.href = "http://127.0.0.1:5010/ver-solicitudes-acceso";
    });
}