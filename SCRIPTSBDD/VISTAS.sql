/* DESCRIBE egresado_db.informacion_personal_egresado;
DESCRIBE egresado_db.empresa;
DESCRIBE egresado_db.convocatorias_aplicadas;
DESCRIBE egresado_db.convocatoria;
--
DESCRIBE egresado_db.trabajo;
DESCRIBE egresado_db.empresa;
DESCRIBE egresado_db.jefe; 
--
DESCRIBE egresado_db.asesoria;
DESCRIBE egresado_db.estudiante_pregrado;
--
DESCRIBE egresado_db.prestamo;
DESCRIBE egresado_db.libro;
--
DESCRIBE egresado_db.informacion_residencia;
DESCRIBE egresado_db.contacto;
DESCRIBE egresado_db.distincion;
--
DESCRIBE egresado_db.familiar;
DESCRIBE egresado_db.hijo_egresado;
--
DESCRIBE egresado_db.estudio_realizado;
DESCRIBE egresado_db.beca;
--
DESCRIBE egresado_db.idioma_egresado;
DESCRIBE egresado_db.idioma;
--
DESCRIBE egresado_db.investigacion_del_egresado;
DESCRIBE egresado_db.proyecto_de_investigacion;
*/

/*Vista datos personales para egresado*/
DROP VIEW IF EXISTS datos_personales;
CREATE VIEW datos_personales
AS SELECT 
    *
FROM
    informacion_personal_egresado AS egr
    LEFT JOIN informacion_residencia AS inf_res ON inf_res.inf_res_egr_numero_de_identificacion=egr.egr_numero_de_identificacion
    LEFT JOIN contacto AS con ON con.con_egr_numero_de_identificacion= egr.egr_numero_de_identificacion
    LEFT JOIN distincion AS dis ON dis.dis_documento_egresado = egr.egr_numero_de_identificacion;
    
/*Vista datos familiares*/
DROP VIEW IF EXISTS datos_familiares;
CREATE VIEW 
	datos_familiares
AS SELECT 
    *
FROM
    (SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
    LEFT JOIN familiar AS fam ON fam.fam_egr_numero_documento_identidad = egr.egr_numero_de_identificacion
    LEFT JOIN hijo_egresado AS hij ON hij.hij_documento=fam.fam_hijo_egresado_documento;
    
/*Vista estudios realizados*/
DROP VIEW IF EXISTS estudios_egr;
CREATE VIEW
	estudios_egr
AS SELECT 
	* 
FROM 
	(SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
    INNER JOIN estudio_realizado AS est ON est.est_documento_egresado = egr.egr_numero_de_identificacion
    LEFT JOIN beca AS bec ON bec.bec_est_documento_egresado= est.est_documento_egresado AND bec. bec_est_programa_formativo=est_programa;

/*Vista idiomas*/
DROP VIEW IF EXISTS idioma_egr;
CREATE VIEW 
	idioma_egr
AS SELECT 
	* 
FROM 
	(SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
	LEFT JOIN idioma_egresado AS idi_egr ON idi_egr.idi_egr_numero_de_identificacion=egr.egr_numero_de_identificacion
    LEFT JOIN idioma AS idi ON idi_egr.idi_egr_idi_idioma_id= idi.idi_idioma_id;

/*Vista proyectos*/
DROP VIEW IF EXISTS proyectos_egr;
CREATE VIEW 
	proyectos_egr
AS SELECT 
* 
FROM 
	(SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
    LEFT JOIN investigacion_del_egresado AS inv ON inv.inv_documento_egresado= egr.egr_numero_de_identificacion 
    LEFT JOIN proyecto_de_investigacion AS pro ON inv.inv_id_colciencias=pro.pro_inv_id_colciencias;

/*Vista general de las convocatorias */
DROP VIEW IF EXISTS vista_convocatorias;
CREATE VIEW 
	vista_convocatorias
AS SELECT 
	*
FROM 
	(SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
    INNER JOIN convocatorias_aplicadas AS con_apl ON con_apl.conv_documento_identidad = egr.egr_numero_de_identificacion
	INNER JOIN convocatoria AS con ON con_apl.con_apl_id =con.con_id AND con_apl.con_apl_emp_idNit = con.con_empresa_idNit
    INNER JOIN empresa AS emp ON con.con_empresa_idNit = emp.emp_idNit;

/*Información laboral*/
DROP VIEW IF EXISTS informacion_laboral;
CREATE VIEW 
	informacion_laboral 
AS SELECT 
	* 
    
FROM 
	(SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
    INNER JOIN trabajo AS tra ON tra.tra_egr_documento_egresado = egr.egr_numero_de_identificacion
    LEFT JOIN jefe AS jef ON jef.jef_documento_egresado = tra.tra_egr_documento_egresado
    LEFT JOIN empresa AS emp ON tra.tra_emp_id_Nit = emp.emp_idNit;

/*Servicios adicionales*/
/*Asesoría*/
DROP VIEW IF EXISTS egr_pre_asesoria;
CREATE VIEW 
	egr_pre_asesoria
AS SELECT 
	* 
FROM 
	(SELECT egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido
		FROM informacion_personal_egresado)AS egr
    INNER JOIN asesoria AS ase ON ase.ase_egr_numero_de_identificacion=egr.egr_numero_de_identificacion
    INNER JOIN estudiante_pregrado AS est_pre ON ase.ase_est_pre_numero_de_identificacion=est_pre.est_pre_numero_de_identificacion;


/*Préstamo libros*/
DROP VIEW IF EXISTS pre_libros;
CREATE VIEW 
	pre_libros
AS SELECT 
* 
FROM 
	informacion_personal_egresado AS egr
    INNER JOIN prestamo AS pre ON pre.pre_egr_numero_documento_identidad = egr.egr_numero_de_identificacion
    INNER JOIN libro AS lib ON lib.lib_id_libro = pre.pre_lib_id;
    
/*Carnet*/
DROP VIEW IF EXISTS carnet_egr;
CREATE VIEW 
	carnet_egr
AS SELECT 
	* 
FROM 
	informacion_personal_egresado AS egr
    INNER JOIN carnet AS car ON car.car_egr_numero_de_identificacion = egr.egr_numero_de_identificacion ;
    
/*Datos personales egresado*/
DROP VIEW IF EXISTS informacion_egresado;
CREATE VIEW informacion_egresado AS
SELECT * FROM informacion_personal_egresado;


/*información de contacto*/
DROP VIEW IF EXISTS informacion_egresado;
CREATE VIEW informacion_egresado AS
SELECT * FROM informacion_personal_egresado;

DROP VIEW IF EXISTS informacion_contacto;
CREATE VIEW informacion_contacto AS 
SELECT 
	egr_numero_de_identificacion,
    egr_primer_nombre,
    egr_segundo_nombre
    egr_primer_apellido,
    egr_segundo_apellido,
    con_numero_telefono_principal,
    con_correo_electronico_principal,
    con_numero_telefono_adicional,
    con_correo_adicional
FROM
	informacion_personal_egresado
    INNER JOIN contacto ON contacto.con_egr_numero_de_identificacion = informacion_personal_egresado.egr_numero_de_identificacion;


DROP VIEW IF EXISTS informacion_residencia_egr;
CREATE VIEW informacion_residencia_egr AS 
SELECT
	egr_numero_de_identificacion,
    egr_primer_nombre,
    egr_segundo_nombre,
    egr_primer_apellido,
    egr_segundo_apellido,
    inf_res_pais_residencia,
    inf_res_departamento_residencia,
    inf_res_municipio_residencia,
    inf_res_ciudad_residencia,
    inf_res_direccion_residencia 
FROM 
	informacion_residencia 
    INNER JOIN informacion_personal_egresado ON inf_res_egr_numero_de_identificacion = egr_numero_de_identificacion;

DROP VIEW IF EXISTS distinciones;
CREATE VIEW distinciones AS 
SELECT 
	egr_numero_de_identificacion,
    egr_primer_nombre,
    egr_segundo_nombre,
    egr_primer_apellido,
    egr_segundo_apellido,
    dis_año,
    dist_nombre_distincion,
    dist_descripcion
FROM
	distincion
    INNER JOIN informacion_personal_egresado;
