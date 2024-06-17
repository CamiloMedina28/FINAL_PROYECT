function eliminar_egresado(id) {
  fetch(`/eliminar_egresado?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function edit_info_personal_form(
  num_id,
  prim_nom,
  prim_ape,
  seg_ape,
  sexo,
  estrato,
  grupo_etn,
  est_civil,
  discap,
  adm_esp,
  vict_conf,
  tipo_id,
  pais_nac,
  depto_nac,
  mun_nac,
  seg_nom
) {
  add_info_form();
  document.getElementById("num_id").value = num_id;
  document.getElementById("prim_nom").value = prim_nom;
  document.getElementById("prim_ape").value = prim_ape;
  document.getElementById("seg_ape").value = seg_ape;
  document.getElementById("sexo").value = sexo;
  document.getElementById("estrato").value = estrato;
  document.getElementById("grupo_etn").value = grupo_etn;
  document.getElementById("est_civil").value = est_civil;
  document.getElementById("discap").value = discap;
  document.getElementById("adm_esp").value = adm_esp;
  document.getElementById("vict_conf").value = vict_conf;
  document.getElementById("tipo_id").value = tipo_id;
  document.getElementById("pais_nac").value = pais_nac;
  document.getElementById("depto_nac").value = depto_nac;
  document.getElementById("mun_nac").value = mun_nac;
  document.getElementById("seg_nom").value = seg_nom;
}

function add_informacion_egresado() {
  var num_id = document.getElementById("num_id").value;
  var prim_nom = document.getElementById("prim_nom").value;
  var prim_ape = document.getElementById("prim_ape").value;
  var seg_ape = document.getElementById("seg_ape").value;
  var sexo = document.getElementById("sexo").value;
  var estrato = document.getElementById("estrato").value;
  var grupo_etn = document.getElementById("grupo_etn").value;
  var est_civil = document.getElementById("est_civil").value;
  var discap = document.getElementById("discap").value;
  var adm_esp = document.getElementById("adm_esp").value;
  var vict_conf = document.getElementById("vict_conf").value;
  var tipo_id = document.getElementById("tipo_id").value;
  var pais_nac = document.getElementById("pais_nac").value;
  var depto_nac = document.getElementById("depto_nac").value;
  var mun_nac = document.getElementById("mun_nac").value;
  var seg_nom = document.getElementById("seg_nom").value;

  fetch(
    `/agregar-info-egresado?num_id=${num_id}&prim_nom=${prim_nom}&prim_ape=${prim_ape}&seg_ape=${seg_ape}&sexo=${sexo}&estrato=${estrato}&grupo_etn=${grupo_etn}&est_civil=${est_civil}&discap=${discap}&adm_esp=${adm_esp}&vict_conf=${vict_conf}&tipo_id=${tipo_id}&pais_nac=${pais_nac}&depto_nac=${depto_nac}&mun_nac=${mun_nac}&seg_nom=${seg_nom}`
  )
    .then((response) => response.text())
    .then((data) => {
      alert(data);
    });
}
// FAMILIAR
function edit_familiar_form(
  documento,
  docmento_hijo,
  nombre_hijo,
  pri_ape_hijo,
  seg_ape_hijo,
  anio_nacimiento_hijo,
  direccion_residencia_hijo
) {
  add_info_form();
  document.getElementById("documento").value = documento;
  document.getElementById("docmento_hijo").value = docmento_hijo;
  document.getElementById("nombre_hijo").value = nombre_hijo;
  document.getElementById("pri_ape_hijo").value = pri_ape_hijo;
  document.getElementById("seg_ape_hijo").value = seg_ape_hijo;
  document.getElementById("anio_nacimiento_hijo").value = anio_nacimiento_hijo;
  document.getElementById("direccion_residencia_hijo").value = direccion_residencia_hijo;
}

function add_info_familia() {
  var documento = document.getElementById("documento").value;
  var docmento_hijo = document.getElementById("docmento_hijo").value;
  var nombre_hijo = document.getElementById("nombre_hijo").value;
  var pri_ape_hijo = document.getElementById("pri_ape_hijo").value;
  var seg_ape_hijo = document.getElementById("seg_ape_hijo").value;
  var anio_nacimiento_hijo = document.getElementById("anio_nacimiento_hijo").value;
  var direccion_residencia_hijo = document.getElementById("direccion_residencia_hijo").value;

  fetch(
    `/agregar-info-familir?documento=${documento}&docmento_hijo=${docmento_hijo}&nombre_hijo=${nombre_hijo}&pri_ape_hijo=${pri_ape_hijo}&seg_ape_hijo=${seg_ape_hijo}&anio_nacimiento_hijo=${anio_nacimiento_hijo}&direccion_residencia_hijo=${direccion_residencia_hijo}`
  )
    .then((response) => response.text())
    .then((data) => {
      alert(data);
    });
}

function eliminar_familiar(id) {
  fetch(`/eliminar_familiar?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function eliminar_residencia(id) {
  fetch(`/eliminar_residencia?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function eliminar_distincion(id) {
  fetch(`/eliminar_distincion?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function add_info_form() {
  document.getElementById("tabla_info").style.display = "none";
  document.getElementById("formulario_añadir").style.display = "flex";
}

function add_informacion_contacto() {
  var documento = document.getElementById("documento").value;
  var telefono_principal = document.getElementById("telefono_principal").value;
  var correo = document.getElementById("correo").value;
  var telefono_adicional = document.getElementById("telefono_adicional").value;
  var correo_adicional = document.getElementById("correo_adicional").value;
  fetch(
    `/agregar-info-contacto?documento=${documento}&telefono-principal=${telefono_principal}&correo=${correo}&telefono-adicional=${telefono_adicional}&correo-adicional=${correo_adicional}`
  )
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function edit_contacto_form(
  documento,
  telefono_principal,
  correo,
  telefono_adicional,
  correo_adicional
) {
  add_info_form();
  document.getElementById("documento").value = documento;
  document.getElementById("telefono_principal").value = telefono_principal;
  document.getElementById("correo").value = correo;
  document.getElementById("telefono_adicional").value = telefono_adicional;
  document.getElementById("correo_adicional").value = correo_adicional;
}

function add_informacion_residencia() {
  var documento = document.getElementById("documento").value;
  var pais = document.getElementById("pais").value;
  var departamento = document.getElementById("departamento").value;
  var municipio = document.getElementById("municipio").value;
  var ciudad = document.getElementById("ciudad").value;
  var direccion = document.getElementById("direccion").value;
  fetch(
    `/agregar-info-residencia?documento=${documento}&pais=${pais}&departamento=${departamento}&municipio=${municipio}&ciudad=${ciudad}&direccion=${direccion}`
  )
    .then((response) => response.text())
    .then((data) => {
      alert(data);
    });
}

function seeInfoToDetail(IdElement) {
  var url = '/informacion_personal_egresados/' + IdElement;
  window.location.href = url;
}

function edit_residencia_form(
  documento,
  pais,
  departamento,
  municipio,
  ciudad,
  direccion
) {
  add_info_form();
  document.getElementById("documento").value = documento;
  document.getElementById("pais").value = pais;
  document.getElementById("departamento").value = departamento;
  document.getElementById("municipio").value = municipio;
  document.getElementById("ciudad").value = ciudad;
  document.getElementById("direccion").value = direccion;
}

// DISTINCIONES 
function edit_distincion_form(
  documento,
  anio,
  nombre_distincion,
  descripcion,
) {
  add_info_form();
  document.getElementById("documento").value = documento;
  document.getElementById("anio").value = anio
  document.getElementById("nombre_distincion").value = nombre_distincion;
  document.getElementById("descripcion").value = descripcion;
}

function add_informacion_distincion() {
  var documento = document.getElementById("documento").value;
  var anio = document.getElementById("anio").value;
  var nombre_distincion = document.getElementById("nombre_distincion").value;
  var descripcion = document.getElementById("descripcion").value;
  
  fetch(
    `/agregar-info-distincion?documento=${documento}&anio=${anio}&nombre_distincion=${nombre_distincion}&descripcion=${descripcion}`
  )
    .then((response) => response.text())
    .then((data) => {
      alert(data);
    });
}