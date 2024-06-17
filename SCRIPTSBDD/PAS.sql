
-- PA para ver datos personales de un egresado
USE egresado_db;
DROP PROCEDURE IF EXISTS ver_datos_personales;
DELIMITER $$ 
CREATE PROCEDURE ver_datos_personales(egr_id INT)
BEGIN 
	IF egr_id = 0 THEN 
		SELECT * FROM  datos_personales ;
	ELSE 
		SELECT * FROM  datos_personales WHERE egr_numero_de_identificacion=egr_id;
	END IF;
END $$
DELIMITER ;

-- PA para vista estudio realizado
DROP PROCEDURE IF EXISTS ver_estudios_realizados;
DELIMITER $$ 
CREATE PROCEDURE ver_estudios_realizados(IN egr_id INT)
BEGIN
	IF egr_id = 0 THEN 
		SELECT * FROM estudios_egr;
    ELSE
		SELECT * FROM estudios_egr WHERE egr_numero_de_identificacion = egr_id;
    END IF ;
END$$
DELIMITER ;

-- PA para Vista prestamo_Libros egresado 
DROP PROCEDURE IF EXISTS ver_prestamo;
DELIMITER $$ 
CREATE PROCEDURE ver_prestamo(IN egr_id INT)
BEGIN
	IF egr_id = 0 THEN
		SELECT * FROM pre_libros;
    ELSE
		SELECT * FROM libro
		WHERE lib_id_libro IN (SELECT pre_lib_id FROM prestamo WHERE pre_egr_numero_documento_identidad= egr_id);
	END IF;
END$$
DELIMITER ;

-- PA para ver libros 
DROP PROCEDURE IF EXISTS ver_libros;
DELIMITER $$
CREATE PROCEDURE ver_libros(IN egr_id INT)
BEGIN
	IF egr_id = 0 THEN
		SELECT * FROM libro
        WHERE lib_id_libro;
    ELSE
		SELECT * FROM libro
		WHERE lib_id_libro NOT IN (SELECT pre_lib_id FROM prestamo) ;
	END IF;
END$$
DELIMITER ;

-- PA para Vista Asesoria Egresado
DROP PROCEDURE IF EXISTS ver_asesoria;
DELIMITER $$ 
CREATE PROCEDURE ver_asesoria(IN egr_id INT)
BEGIN
	IF egr_id=0 THEN
		SELECT * FROM egr_pre_asesoria;
    ELSE
		SELECT * FROM egr_pre_asesoria
		WHERE egr_numero_de_identificacion = egr_id AND est_pre_solicitud=1;
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ver_pregrado;
DELIMITER $$ 
CREATE PROCEDURE ver_pregrado(IN pre_id INT)
BEGIN
	IF pre_id=0 THEN
		SELECT * FROM estudiante_pregrado;
    ELSE
		SELECT * FROM estudiante_pregrado
		WHERE est_pre_numero_de_identificacion = pre_id ;
    END IF;
END$$
DELIMITER ;

-- PA para llamar convocatorias especificando emp_idNit
DROP PROCEDURE IF EXISTS emp_vista_convocatorias;
DELIMITER $$ 
CREATE PROCEDURE emp_vista_convocatorias(emp_id INT)
BEGIN 
	SELECT * FROM  egresado_db.convocatoria WHERE con_empresa_idNit=emp_id;
END $$
DELIMITER ;

-- PA para llamar convocatorias especificando documento egresado
DROP PROCEDURE IF EXISTS egr_vista_convocatorias;
DELIMITER $$ 
CREATE PROCEDURE egr_vista_convocatorias(egr_id INT)
BEGIN
	IF egr_id = 0 THEN
		SELECT * FROM  egresado_db.vista_convocatorias;
	ELSE 
		SELECT * FROM  egresado_db.vista_convocatorias WHERE egr_numero_de_identificacion=egr_id;
	END IF;
END $$
DELIMITER ;

-- PA para llamar vista_convocatorias especificando emp_idNit
DROP PROCEDURE IF EXISTS emp_aplicadas_convocatorias;
DELIMITER $$ 
CREATE PROCEDURE emp_aplicadas_convocatorias(IN convo_id INT, IN emp_id INT)
BEGIN 
	SELECT * FROM  egresado_db.vista_convocatorias WHERE con_empresa_idNit=emp_id AND con_id = convo_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_estado_convocatoria;
DELIMITER $$ 
CREATE PROCEDURE update_estado_convocatoria(
    IN p_con_apl_id INT,
    IN p_con_apl_emp_idNit INT,
    IN p_conv_documento_identidad INT,
    IN p_estado ENUM('ACEPTADA', 'EN EVALUACION', 'RECHAZADA')
)
BEGIN
    UPDATE egresado_db.convocatorias_aplicadas
    SET con_estado = p_estado
    WHERE con_apl_id = p_con_apl_id
    AND con_apl_emp_idNit = p_con_apl_emp_idNit
    AND conv_documento_identidad = p_conv_documento_identidad;
END $$
DELIMITER ;

-- 1 Insert, 2 Update, 3 Delete
-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_egresado_datos;
DELIMITER $$
CREATE PROCEDURE insertar_egresado_datos(
    IN operacion INT,
    IN numero_identificacion INT,
    IN primer_nombre VARCHAR(45),
    IN primer_apellido VARCHAR(45),
    IN segundo_apellido VARCHAR(45),
    IN sexo ENUM('Masculino', 'Femenino', 'Otro'),
    IN estrato INT,
    IN grupo_etnico ENUM('Afro', 'Negro', 'Indigena', 'Ninguno', 'Palenquero', 'Raizal del archipielago de San Andres Providencia y Santa Catalina', 'Rom/Gitano'),
    IN estado_civil ENUM('Soltero', 'Casado', 'Divorciado', 'Viudo', 'Union libre'),
    IN discapacidad ENUM('Auditiva', 'Multiples', 'Fisica', 'Intelectual', 'Ninguna', 'Psicosocial', 'Sordoceguera', 'Sordomudismo', 'Visual'),
    IN admision_especial ENUM('Paes', 'Peama', 'Ninguna'),
    IN victima_conflicto_armado ENUM('Si', 'No'),
    IN tipo_identificacion VARCHAR(45),
    IN pais_nacimiento VARCHAR(45),
    IN departamento_nacimiento VARCHAR(45),
    IN municipio_nacimiento VARCHAR(45),
    IN segundo_nombre VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO informacion_personal_egresado (
            egr_numero_de_identificacion, egr_primer_nombre, egr_primer_apellido,
            egr_segundo_apellido, egr_sexo, egr_estrato,
            egr_grupo_etnico, egr_estado_civil, egr_discapacidad,
            egr_admision_especial, egr_victima_conflicto_armado,
            egr_tipo_identificacion, egr_pais_nacimiento,
            egr_departamento_nacimiento, egr_municipio_nacimiento,
            egr_segundo_nombre
        )
        VALUES (
            numero_identificacion, primer_nombre, primer_apellido,
            segundo_apellido, sexo, estrato,
            grupo_etnico, estado_civil, discapacidad,
            admision_especial, victima_conflicto_armado,
            tipo_identificacion, pais_nacimiento,
            departamento_nacimiento, municipio_nacimiento,
            segundo_nombre
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= numero_identificacion)!= 0 THEN 
			UPDATE informacion_personal_egresado
			SET 
				egr_primer_nombre = primer_nombre,
				egr_primer_apellido = primer_apellido,
				egr_segundo_apellido = segundo_apellido,
				egr_sexo = sexo,
				egr_estrato = estrato,
				egr_grupo_etnico = grupo_etnico,
				egr_estado_civil = estado_civil,
				egr_discapacidad = discapacidad,
				egr_admision_especial = admision_especial,
				egr_victima_conflicto_armado = victima_conflicto_armado,
				egr_tipo_identificacion = tipo_identificacion,
				egr_pais_nacimiento = pais_nacimiento,
				egr_departamento_nacimiento = departamento_nacimiento,
				egr_municipio_nacimiento = municipio_nacimiento,
				egr_segundo_nombre = segundo_nombre
			WHERE 
				egr_numero_de_identificacion = numero_identificacion;
		ELSE
			SET msg = concat('No existe el egresado con el id ',numero_identificacion); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
        END IF;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_egresado_datos;
DELIMITER $$
CREATE PROCEDURE borrar_egresado_datos(IN numero_identificacion INT)
BEGIN
DELETE FROM informacion_personal_egresado WHERE egr_numero_de_identificacion = numero_identificacion;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_residencia_datos;
DELIMITER $$ 
CREATE PROCEDURE insertar_residencia_datos(
    operacion INT,
    id INT, pais_residencia VARCHAR(45), departamento_residencia VARCHAR(45),
    municipio_residencia VARCHAR(45), ciudad_residencia VARCHAR(45), direccion_residencia VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO informacion_residencia (
            inf_res_egr_numero_de_identificacion, inf_res_pais_residencia, inf_res_departamento_residencia,
            inf_res_municipio_residencia, inf_res_ciudad_residencia, inf_res_direccion_residencia
        ) VALUES (
            id, pais_residencia, departamento_residencia,
            municipio_residencia, ciudad_residencia, direccion_residencia
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM informacion_residencia WHERE inf_res_egr_numero_de_identificacion = id)!=0 THEN
			UPDATE informacion_residencia
			SET 
				inf_res_pais_residencia = pais_residencia,
				inf_res_departamento_residencia = departamento_residencia,
				inf_res_municipio_residencia = municipio_residencia,
				inf_res_ciudad_residencia = ciudad_residencia,
				inf_res_direccion_residencia = direccion_residencia
			WHERE 
				inf_res_egr_numero_de_identificacion = id;     
		ELSE 
			SET msg = concat('No existe informacion de residencia aun para el egresado con id ', id); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_residencia_datos;
DELIMITER $$
CREATE PROCEDURE borrar_residencia_datos(IN id INT)
BEGIN 
DELETE FROM informacion_residencia WHERE inf_res_egr_numero_de_identificacion = id;
END $$
DELIMITER ;

-- PA para egresado y administrador 
DROP PROCEDURE IF EXISTS insertar_contacto_datos;
DELIMITER $$ 
CREATE PROCEDURE insertar_contacto_datos(
	operacion INT,
    id INT, 
    numero_telefono_principal INT,
    correo_electronico_principal VARCHAR(45), 
    numero_telefono_adicional INT,
    correo_adicional VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
	IF operacion = 1 THEN
		INSERT INTO contacto (
			con_egr_numero_de_identificacion, con_numero_telefono_principal, con_correo_electronico_principal,
			con_numero_telefono_adicional, con_correo_adicional
		) VALUES (
			id, numero_telefono_principal, correo_electronico_principal,
			numero_telefono_adicional, correo_adicional
		); 
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM contacto WHERE con_egr_numero_de_identificacion = id)!=0 THEN
			UPDATE contacto
			SET 
				con_numero_telefono_principal = numero_telefono_principal,
				con_correo_electronico_principal = correo_electronico_principal,
				con_numero_telefono_adicional = numero_telefono_adicional,
				con_correo_adicional = correo_adicional
			WHERE 
				con_egr_numero_de_identificacion = id;
		ELSE 
			SET msg = concat('No existe contacto aun para el egresado con id ', id); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
	END IF ;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_contacto_datos; 
DELIMITER $$
CREATE PROCEDURE borrar_contacto_datos (IN numero_identificacion INT)
BEGIN 
	DELETE FROM contacto WHERE con_egr_numero_de_identificacion = numero_identificacion;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS distincion_datos;
DELIMITER $$ 
CREATE PROCEDURE distincion_datos(
    operacion INT, id INT, año YEAR, nombre_distincion VARCHAR(45), descripcion VARCHAR(150)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO distincion (
            dis_documento_egresado, dis_año, dist_nombre_distincion, dist_descripcion
        ) VALUES (
            id, año, nombre_distincion, descripcion );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM distincion WHERE dis_documento_egresado = id)!=0 THEN
			UPDATE distincion
			SET 
				dis_año = año,
				dist_nombre_distincion = nombre_distincion,
				dist_descripcion = descripcion
			WHERE 
				dis_documento_egresado = id;
		ELSE 
			SET msg = concat('No existe distincion aun para el egresado con id ', id); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS borrar_distincion_datos;
DELIMITER $$
CREATE PROCEDURE borrar_distincion_datos( IN id INT)
BEGIN
DELETE FROM distincion WHERE dis_documento_egresado = id;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_estudio_datos;
DELIMITER $$
CREATE PROCEDURE insertar_estudio_datos(
    IN operacion INT,
    IN documento_egresado INT,
    IN programa VARCHAR(45),
    IN institucion_educativa VARCHAR(45),
    IN sede VARCHAR(45),
    IN facultad VARCHAR(45),
    IN fecha_inicio DATE,
    IN fecha_finalizacion DATE,
    IN estado_formacion ENUM('En formacion', 'Finalizada', 'No finalizada'),
    IN nivel_educativo ENUM('Pregrado', 'Tecnico', 'Tecnologo', 'Especializacion', 'Maestria', 'Doctorado', 'Posdoctorado')
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO estudio_realizado (
            est_documento_egresado, est_programa, est_institucion_educativa, est_sede, 
            est_facultad, est_fecha_inicio, est_fecha_finalizacion, est_estado_formación, 
            est_nivel_educativo
        )
        VALUES (
            documento_egresado, programa, institucion_educativa, sede, 
            facultad, fecha_inicio, fecha_finalizacion, estado_formacion, 
            nivel_educativo
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM estudio_realizado WHERE est_documento_egresado = documento_egresado AND est_programa = programa)!=0 THEN
			UPDATE estudio_realizado
			SET 
				est_institucion_educativa = institucion_educativa,
				est_sede = sede,
				est_facultad = facultad,
				est_fecha_inicio = fecha_inicio,
				est_fecha_finalizacion = fecha_finalizacion,
				est_estado_formación = estado_formacion,
				est_nivel_educativo = nivel_educativo
			WHERE 
				est_documento_egresado = documento_egresado AND est_programa = programa;
		ELSE 
			SET msg = concat('Aun no existe el estudio que desea actualizar '); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_estudio_datos;
DELIMITER $$
CREATE PROCEDURE borrar_estudio_datos(IN documento_egresado INT, IN programa VARCHAR(45))
BEGIN
	DELETE FROM estudio_realizado WHERE est_documento_egresado = documento_egresado AND est_programa = programa;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_beca_datos;
DELIMITER $$
CREATE PROCEDURE insertar_beca_datos(
    IN operacion INT,
    IN programa_formativo VARCHAR(45),
    IN documento_egresado INT,
    IN nombre_beca VARCHAR(45),
    IN entidad_otorga VARCHAR(45),
    IN fecha_inicio DATE,
    IN fecha_finalizacion DATE,
    IN duracion VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO beca (
            bec_est_programa_formativo, bec_est_documento_egresado, bec_nombre_beca, 
            bec_entidad_otorga, bec_fecha_inicio, bec_fecha_finalizacion, bec_duracion
        )
        VALUES (
            programa_formativo, documento_egresado, nombre_beca, 
            entidad_otorga, fecha_inicio, fecha_finalizacion, duracion
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM beca WHERE bec_est_programa_formativo = programa_formativo AND bec_est_documento_egresado = documento_egresado)!=0 THEN
			UPDATE beca
			SET 
				bec_nombre_beca = nombre_beca,
				bec_entidad_otorga = entidad_otorga,
				bec_fecha_inicio = fecha_inicio,
				bec_fecha_finalizacion = fecha_finalizacion,
				bec_duracion = duracion
			WHERE 
				bec_est_programa_formativo = programa_formativo AND bec_est_documento_egresado = documento_egresado;
		ELSE 
			SET msg = concat('Aun no existe la beca que desea actualizar '); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_beca_datos;
DELIMITER $$
CREATE PROCEDURE borrar_beca_datos(
    IN programa_formativo VARCHAR(45),
    IN documento_egresado INT)
BEGIN
	DELETE FROM beca WHERE bec_est_programa_formativo = programa_formativo AND bec_est_documento_egresado = documento_egresado;
END $$
DELIMITER ;

-- PA para empresa y administrador
DROP PROCEDURE IF EXISTS insertar_empresa_datos;
DELIMITER $$
CREATE PROCEDURE insertar_empresa_datos(
    IN operacion INT,
    IN id_nit INT,
    IN matricula_mercantil VARCHAR(45),
    IN razon_social VARCHAR(45),
    IN direccion VARCHAR(45),
    IN telefono INT,
    IN actividad_economica VARCHAR(45),
    IN numero_empleados INT,
    IN representante_legal VARCHAR(45),
    IN correo VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO empresa (
            emp_idNit, emp_matricula_mercantil, emp_razon_social, emp_direccion,
            emp_telefono, emp_actividad_economica, emp_numero_empleados,
            emp_representante_legal, emp_correo
        )
        VALUES (
            id_nit, matricula_mercantil, razon_social, direccion,
            telefono, actividad_economica, numero_empleados,
            representante_legal, correo
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM empresa WHERE emp_idNit = id_nit) THEN
			UPDATE empresa
			SET 
				emp_matricula_mercantil = matricula_mercantil,
				emp_razon_social = razon_social,
				emp_direccion = direccion,
				emp_telefono = telefono,
				emp_actividad_economica = actividad_economica,
				emp_numero_empleados = numero_empleados,
				emp_representante_legal = representante_legal,
				emp_correo = correo
			WHERE 
				emp_idNit = id_nit;
		ELSE 
			SET msg = concat('Aun no existe la empresa que desea actualizar'); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;
-- PA empresa y administrador
DROP PROCEDURE IF EXISTS borrar_empresa_datos;
DELIMITER $$
CREATE PROCEDURE borrar_empresa_datos(IN id_nit INT)
BEGIN
	DELETE FROM empresa WHERE emp_idNit = id_nit;
END $$
DELIMITER ;

-- trabajo 
-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_trabajo_datos;
DELIMITER $$
CREATE PROCEDURE insertar_trabajo_datos(
    IN operacion INT,
    IN id INT,
    IN documento_egresado INT,
    IN nombre_cargo VARCHAR(45),
    IN ocupacion VARCHAR(45),
    IN tipo_vinculacion VARCHAR(45),
    IN area_desempeno VARCHAR(45),
    IN rango_salario VARCHAR(45),
    IN fecha_inicio DATE,
    IN fecha_finalizacion DATE,
    IN pais VARCHAR(45),
    IN departamento VARCHAR(45),
    IN municipio VARCHAR(45),
    IN id_empresa INT,
    IN trabajo_actual TINYINT
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO trabajo (
			tra_id,
            tra_egr_documento_egresado, tra_nombre_cargo, tra_ocupacion, 
            tra_tipo_vinculacion, tra_area_desempeno, tra_rango_salario, 
            tra_fecha_inicio, tra_fecha_finalizacion, tra_pais, 
            tra_departamento, tra_municipio, tra_emp_id_Nit, tra_trabajo_actual
        )
        VALUES (
			id,
            documento_egresado, nombre_cargo, ocupacion, 
            tipo_vinculacion, area_desempeno, rango_salario, 
            fecha_inicio, fecha_finalizacion, pais, 
            departamento, municipio, id_empresa, trabajo_actual
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM trabajo WHERE tra_id = id AND tra_egr_documento_egresado = documento_egresado)!=0 THEN
			UPDATE trabajo
			SET 
				tra_nombre_cargo = nombre_cargo,
				tra_ocupacion = ocupacion,
				tra_tipo_vinculacion = tipo_vinculacion,
				tra_area_desempeno = area_desempeno,
				tra_rango_salario = rango_salario,
				tra_fecha_inicio = fecha_inicio,
				tra_fecha_finalizacion = fecha_finalizacion,
				tra_pais = pais,
				tra_departamento = departamento,
				tra_municipio = municipio,
				tra_emp_id_Nit = id_empresa,
				tra_trabajo_actual = trabajo_actual
			WHERE 
				tra_id = id AND
				tra_egr_documento_egresado = documento_egresado;
		
		ELSE 
			SET msg = concat('Aun no existe el trabajo que desea actualizar '); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;


-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_trabajo_datos;
DELIMITER $$
CREATE PROCEDURE borrar_trabajo_datos(
    IN id INT,
    IN documento_egresado INT)
BEGIN	
	DELETE FROM trabajo WHERE tra_id = id AND tra_egr_documento_egresado = documento_egresado;
END $$
DELIMITER ;
 
-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_hijos_egresado_datos;
DELIMITER $$
CREATE PROCEDURE insertar_hijos_egresado_datos(
    IN operacion INT, IN documento INT, IN nombre VARCHAR(45),
    IN primer_apellido VARCHAR(45), IN segundo_apellido VARCHAR(45), IN año_nacimiento YEAR, IN direccion_residencia VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO hijo_egresado (
            hij_documento, hij_nombre, hij_primer_apellido, hij_segundo_apellido, 
            hij_año_nacimiento, hij_direccion_residencia
        )
        VALUES (
            documento, nombre, primer_apellido, segundo_apellido, 
            año_nacimiento, direccion_residencia
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM hijo_egresado WHERE hij_documento = documento)!=0 THEN
			UPDATE hijo_egresado
			SET 
				hij_nombre = nombre,
				hij_primer_apellido = primer_apellido,
				hij_segundo_apellido = segundo_apellido,
				hij_año_nacimiento = año_nacimiento,
				hij_direccion_residencia = direccion_residencia
			WHERE 
				hij_documento = documento;
		ELSE 
			SET msg = concat('Aun no existe el hijo que desea actualizar '); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_hijos_egresado_datos;
DELIMITER $$
CREATE PROCEDURE borrar_hijos_egresado_datos(IN documento INT)
BEGIN
    DELETE FROM hijo_egresado WHERE hij_documento = documento;
END $$
DELIMITER ;
	
-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_familiar_datos;
DELIMITER $$
CREATE PROCEDURE insertar_familiar_datos(IN egr_documento INT, IN hijo_documento INT
)
BEGIN 
	INSERT INTO familiar (
		fam_egr_numero_documento_identidad, fam_hijo_egresado_documento
	)
	VALUES (
		egr_documento, hijo_documento
	);
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_familiar_datos;
DELIMITER $$
CREATE PROCEDURE borrar_familiar_datos( IN egr_documento INT, IN hijo_documento INT)
BEGIN 
	 DELETE FROM familiar WHERE 
		fam_egr_numero_documento_identidad = egr_documento
        AND fam_hijo_egresado_documento;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_idioma_datos;
DELIMITER $$
CREATE PROCEDURE insertar_idioma_datos(
    IN nombre_idioma VARCHAR(45),
    IN idioma_id INT
)
BEGIN 
	DECLARE msg varchar(255); 
	INSERT INTO idioma (
		idi_nombre
	)
	VALUES (
		nombre_idioma
	);
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_idioma_datos;
DELIMITER $$
CREATE PROCEDURE borrar_idioma_datos(IN idioma_id INT)
BEGIN 
	DELETE FROM idioma WHERE idi_idioma_id = idioma_id;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS idioma_egresado_datos;
DELIMITER $$
CREATE PROCEDURE idioma_egresado_datos(
    IN numero_identificacion INT,
    IN idioma_id INT,
    IN nivel VARCHAR(45)
)
BEGIN 
	INSERT INTO idioma_egresado (
		idi_egr_numero_de_identificacion, idi_egr_idi_idioma_id, idi_egr_nivel
	)
	VALUES (
		numero_identificacion, idioma_id, nivel
	);
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_idioma_egresado_datos;
DELIMITER $$
CREATE PROCEDURE borrar_idioma_egresado_datos(
    IN numero_identificacion INT,
    IN idioma_id INT)
BEGIN
	 DELETE FROM idioma_egresado WHERE idi_egr_numero_de_identificacion = numero_identificacion AND idi_egr_idi_idioma_id = idioma_id;
END $$
DELIMITER ;

-- PA egresado y administrador
DROP PROCEDURE IF EXISTS insertar_proyecto_datos;
DELIMITER $$
CREATE PROCEDURE insertar_proyecto_datos(
    IN operacion INT,
    IN id_colciencias INT,
    IN nombre_grupo LONGTEXT,
    IN descripcion LONGTEXT,
    IN institucion VARCHAR(45)
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO proyecto_de_investigacion (
            pro_inv_id_colciencias, pro_inv_nombre_grupo,
            pro_inv_descripcion, pro_inv_institucion
        )
        VALUES (
            id_colciencias, nombre_grupo,
            descripcion, institucion
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM proyecto_de_investigacion WHERE pro_inv_id_colciencias = id_colciencias)!=0 THEN
			UPDATE proyecto_de_investigacion
			SET 
				pro_inv_nombre_grupo = nombre_grupo,
				pro_inv_descripcion = descripcion,
				pro_inv_institucion = institucion
			WHERE 
				pro_inv_id_colciencias = id_colciencias;
		ELSE 
			SET msg = concat('Aun no existe el proyecto que desea actualizar '); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA egresado y administrador
DROP PROCEDURE IF EXISTS borrar_proyecto_datos;
DELIMITER $$
CREATE PROCEDURE borrar_proyecto_datos(IN id_colciencias INT)
BEGIN 
	DELETE FROM proyecto_de_investigacion WHERE pro_inv_id_colciencias = id_colciencias;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_investigacion_datos;
DELIMITER $$
CREATE PROCEDURE insertar_investigacion_datos(
    IN operacion INT,
    IN documento_egresado INT,
    IN id_colciencias INT,
    IN rol_en_grupo VARCHAR(45),
    IN fecha_inicio DATE,
    IN fecha_finalizacion DATE
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO investigacion_del_egresado (
            inv_documento_egresado, inv_id_colciencias, inv_rol_en_grupo,
            inv_fecha_inicio, inv_fecha_finalizacion
        )
        VALUES (
            documento_egresado, id_colciencias, rol_en_grupo,
            fecha_inicio, fecha_finalizacion
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM investigacion_del_egresado  
			WHERE inv_documento_egresado = documento_egresado AND inv_id_colciencias = id_colciencias)!=0 THEN
				UPDATE investigacion_del_egresado
				SET 
					inv_rol_en_grupo = rol_en_grupo,
					inv_fecha_inicio = fecha_inicio,
					inv_fecha_finalizacion = fecha_finalizacion
				WHERE 
					inv_documento_egresado = documento_egresado AND inv_id_colciencias = id_colciencias;
		ELSE 
			SET msg = concat('Aun no existe la investigación que desea actualizar'); 
				SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_investigacion_datos;
DELIMITER $$
CREATE PROCEDURE borrar_investigacion_datos(
    IN documento_egresado INT,
    IN id_colciencias INT)
BEGIN 
	DELETE FROM investigacion_del_egresado 
		WHERE inv_documento_egresado = documento_egresado AND inv_id_colciencias = id_colciencias;
END $$
DELIMITER ;

-- PA para empresa y administrador
DROP PROCEDURE IF EXISTS insertar_convocatoria_datos;
DELIMITER $$
CREATE PROCEDURE insertar_convocatoria_datos(
    IN operacion INT,
    IN id_empresa INT,
    IN nombre_cargo VARCHAR(45),
    IN habilidades VARCHAR(45),
    IN competencias VARCHAR(45),
    IN meses_experiencia INT,
    IN numero_vacantes VARCHAR(45),
    IN salario INT,
    IN jornada_trabajo ENUM('MEDIA', 'COMPLETA', 'HORAS'),
    IN horario_trabajo MEDIUMTEXT,
    IN teletrabajo ENUM('Si', 'No'),
    IN pais_convocatoria VARCHAR(45),
    IN ciudad_convocatoria VARCHAR(45),
    IN fecha_convocatoria DATE,
    IN fecha_expiracion DATE
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO convocatoria (
            con_empresa_idNit, con_nombre_cargo, con_habilidades,
            con_competencias, con_meses_experiencia, con_numero_vacantes,
            con_salario, con_jornada_trabajo, con_horario_trabajo,
            con_teletrabajo, con_pais_convocatoria, con_ciudad_convocatoria,
            con_fecha_convocatoria, con_fecha_expiracion
        )
        VALUES (
            id_empresa, nombre_cargo, habilidades,
            competencias, meses_experiencia, numero_vacantes,
            salario, jornada_trabajo, horario_trabajo,
            teletrabajo, pais_convocatoria, ciudad_convocatoria,
            fecha_convocatoria, fecha_expiracion
        );
    ELSEIF operacion = 2 THEN
		IF (SELECT count(*) FROM convocatoria  WHERE 
            con_id = id_convocatoria AND con_empresa_idNit = id_empresa)!=0 THEN
			UPDATE convocatoria
			SET 
				con_nombre_cargo = nombre_cargo,
				con_habilidades = habilidades,
				con_competencias = competencias,
				con_meses_experiencia = meses_experiencia,
				con_numero_vacantes = numero_vacantes,
				con_salario = salario,
				con_jornada_trabajo = jornada_trabajo,
				con_horario_trabajo = horario_trabajo,
				con_teletrabajo = teletrabajo,
				con_pais_convocatoria = pais_convocatoria,
				con_ciudad_convocatoria = ciudad_convocatoria,
				con_fecha_convocatoria = fecha_convocatoria,
				con_fecha_expiracion = fecha_expiracion
			WHERE 
				con_id = id_convocatoria AND con_empresa_idNit = id_empresa;
		ELSE 
			SET msg = concat('Aun no existe la convocatoria que desea actualizar '); 
			SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para empresa y administrador
DROP PROCEDURE IF EXISTS borrar_convocatoria_datos;
DELIMITER $$
CREATE PROCEDURE borrar_convocatoria_datos(
    IN id_convocatoria INT,
    IN id_empresa INT)
BEGIN 
	DELETE FROM convocatoria WHERE con_id = id_convocatoria AND con_empresa_idNit = id_empresa;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_convocatorias_aplicadas_datos;
DELIMITER $$
CREATE PROCEDURE insertar_convocatorias_aplicadas_datos(
    IN id_convocatoria_aplicada INT,
    IN id_empresa_convocatoria INT,
    IN documento_identidad INT,
    IN fecha_aplicacion DATETIME
)
BEGIN 
	DECLARE msg varchar(255); 
	INSERT INTO convocatorias_aplicadas (
		con_apl_id, con_apl_emp_idNit, conv_documento_identidad, conv_apl_fecha_aplicacion
	)
	VALUES (
		id_convocatoria_aplicada, id_empresa_convocatoria, documento_identidad, fecha_aplicacion
	);
END $$
DELIMITER ;

-- PA para empresa y administrador (y empresa?)
DROP PROCEDURE IF EXISTS borrar_convocatorias_aplicadas_datos;
DELIMITER $$
CREATE PROCEDURE borrar_convocatorias_aplicadas_datos(
    IN id_convocatoria_aplicada INT,
    IN id_empresa_convocatoria INT,
    IN documento_identidad INT)
BEGIN
DELETE FROM convocatorias_aplicadas
	WHERE con_apl_id = id_convocatoria_aplicada 
    AND con_apl_emp_idNit = id_empresa_convocatoria 
    AND conv_documento_identidad = documento_identidad;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_trabajo_datos;
DELIMITER $$
CREATE PROCEDURE insertar_trabajo_datos(
	IN id INT,
    IN documento_egresado INT,
    IN nombre_cargo VARCHAR(45),
    IN ocupacion VARCHAR(45),
    IN tipo_vinculacion VARCHAR(45),
    IN area_desempeno VARCHAR(45),
    IN rango_salario VARCHAR(45),
    IN fecha_inicio DATE,
    IN fecha_finalizacion DATE,
    IN pais VARCHAR(45),
    IN departamento VARCHAR(45),
    IN municipio VARCHAR(45),
    IN id_empresa INT,
    IN trabajo_actual TINYINT
)
BEGIN 
	INSERT INTO trabajo (
		tra_id,tra_egr_documento_egresado, tra_nombre_cargo, tra_ocupacion, 
		tra_tipo_vinculacion, tra_area_desempeno, tra_rango_salario, 
		tra_fecha_inicio, tra_fecha_finalizacion, tra_pais, 
		tra_departamento, tra_municipio, tra_emp_id_Nit, tra_trabajo_actual
	)
	VALUES (
		id,documento_egresado, nombre_cargo, ocupacion, 
		tipo_vinculacion, area_desempeno, rango_salario, 
		fecha_inicio, fecha_finalizacion, pais, 
		departamento, municipio, id_empresa, trabajo_actual
	);
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_trabajo_datos;
DELIMITER $$
CREATE PROCEDURE borrar_trabajo_datos(
	IN id INT,
    IN documento_egresado INT)
BEGIN 
	DELETE FROM trabajo WHERE tra_id= id AND tra_egr_documento_egresado = documento_egresado;
END $$
DELIMITER ;
    
-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_jefe_datos;
DELIMITER $$
CREATE PROCEDURE insertar_jefe_datos(
    IN id_jefe INT,
    IN documento_egresado INT,
    IN nombre VARCHAR(45),
    IN primer_apellido VARCHAR(45),
    IN segundo_apellido VARCHAR(45),
    IN telefono BIGINT
)
BEGIN 
	INSERT INTO jefe (
		jef_id, jef_documento_egresado, jef_nombre, 
		jef_primer_apellido, jef_segundo_apellidos, jef_telefono
	)
	VALUES (
		id_jefe, documento_egresado, nombre, 
		primer_apellido, segundo_apellido, telefono
	);
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_jefe_datos;
DELIMITER $$
CREATE PROCEDURE borrar_jefe_datos(
    IN id_jefe INT,
    IN documento_egresado INT)
BEGIN
	DELETE FROM jefe WHERE jef_id = id_jefe AND jef_documento_egresado = documento_egresado;
END $$
DELIMITER ;

-- PA para bibliotecario y administrador
DROP PROCEDURE IF EXISTS insertar_libro_datos;
DELIMITER $$
CREATE PROCEDURE insertar_libro_datos(
    IN id_libro INT,
    IN titulo VARCHAR(45),
    IN biblioteca VARCHAR(45),
    IN autor VARCHAR(45),
    IN estante VARCHAR(45)
)
BEGIN 
	INSERT INTO libro (
		lib_id_libro, lib_titulo, lib_biblioteca, lib_autor, lib_estante
	)
	VALUES (
		id_libro, titulo, biblioteca, autor, estante
	);
END $$
DELIMITER ;

-- PA para bibliotecario y administrador
DROP PROCEDURE IF EXISTS borrar_libro_datos;
DELIMITER $$
CREATE PROCEDURE borrar_libro_datos(IN id_libro INT)
BEGIN 
DELETE FROM libro WHERE lib_id_libro = id_libro;
END $$
DELIMITER ;

-- PA para bibliotecario, egresado y administrador
DROP PROCEDURE IF EXISTS insertar_prestamo_datos;
DELIMITER $$
CREATE PROCEDURE insertar_prestamo_datos(
    IN numero_documento_identidad INT,
    IN id_libro INT
)
BEGIN 
	INSERT INTO prestamo (
		pre_egr_numero_documento_identidad, pre_lib_id, 
		pre_fecha_prestamo, pre_fecha_vencimiento
	)
	VALUES (
		numero_documento_identidad, id_libro, 
		current_timestamp(), TIMESTAMPADD(DAY, 15, NOW())
	);
END $$
DELIMITER ;

-- PA para bibliotecario,egresado y administrador
DROP PROCEDURE IF EXISTS borrar_prestamo_datos;
DELIMITER $$
CREATE PROCEDURE borrar_prestamo_datos(
	IN numero_documento_identidad INT,
    IN id_libro INT)
BEGIN 
	DELETE FROM prestamo 
	WHERE 
		pre_egr_numero_documento_identidad = numero_documento_identidad 
		AND pre_lib_id = id_libro;
END $$
DELIMITER ;

-- PA para pregrado y administrador
DROP PROCEDURE IF EXISTS estudiante_pregrado_datos;
DELIMITER $$
CREATE PROCEDURE estudiante_pregrado_datos(
    IN operacion INT,
    IN numero_identificacion INT,
    IN nombre VARCHAR(45),
    IN primer_apellido VARCHAR(45),
    IN segundo_apellido VARCHAR(45),
    IN facultad VARCHAR(45),
    IN carrera VARCHAR(45),
    IN admision_especial ENUM('Paes', 'Peama'),
    IN solicitud TINYINT
)
BEGIN 
	DECLARE msg varchar(255); 
    IF operacion = 1 THEN
        INSERT INTO estudiante_pregrado (
            est_pre_numero_de_identificacion, est_pre_nombre, est_pre_primer_apellido,
            est_pre_segundo_apellido, est_pre_facultad, est_pre_carrera,
            est_pre_admision_especial, est_pre_solicitud 
        )
        VALUES (
            numero_identificacion, nombre, primer_apellido,
            segundo_apellido, facultad, carrera,
            admision_especial, solicitud
        );
    ELSEIF operacion = 2  THEN
		IF (SELECT count(*) FROM estudiante_pregrado WHERE est_pre_numero_de_identificacion = numero_identificacion)!=0 THEN
			UPDATE estudiante_pregrado
			SET 
				est_pre_nombre = nombre,
				est_pre_primer_apellido = primer_apellido,
				est_pre_segundo_apellido = segundo_apellido,
				est_pre_facultad = facultad,
				est_pre_carrera = carrera,
				est_pre_admision_especial = admision_especial,
                est_pre_solicitud = solicitud
			WHERE 
				est_pre_numero_de_identificacion = numero_identificacion;
		ELSE 
		SET msg = concat('No existe el egresado con el id ', numero_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
		END IF;
    END IF;
END $$
DELIMITER ;

-- PA para pregrado y administrador
DROP PROCEDURE IF EXISTS borrar_estudiante_pregrado_datos;
DELIMITER $$
CREATE PROCEDURE borrar_estudiante_pregrado_datos(IN numero_identificacion INT)
BEGIN 
	DELETE FROM estudiante_pregrado WHERE est_pre_numero_de_identificacion = numero_identificacion;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_asesoria_datos;
DELIMITER $$
CREATE PROCEDURE insertar_asesoria_datos(
    IN numero_identificacion_egresado INT,
    IN numero_identificacion_estudiante_pregrado INT,
    IN solicitud TINYINT
)
BEGIN 
	DECLARE msg varchar(255); 
	IF solicitud =1 THEN
		INSERT INTO asesoria (
			ase_egr_numero_de_identificacion, ase_est_pre_numero_de_identificacion,
			ase_fecha_inicio, ase_fecha_finalizacion
		)
		VALUES (
			numero_identificacion_egresado, numero_identificacion_estudiante_pregrado,
			DATE_ADD(NOW(),INTERVAL 5 DAY), DATE_ADD(NOW(), INTERVAL 1 MONTH )
		);
		UPDATE estudiante_pregrado 
        SET est_pre_solicitud = 0 WHERE est_pre_numero_de_identificacion = numero_identificacion_estudiante_pregrado;
	ELSE 
    SET msg = concat('Este estudiante no está solicitando asesoría en este momento'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_asesoria_datos;
DELIMITER $$
CREATE PROCEDURE borrar_asesoria_datos(
	IN fecha_inicio INT,
	IN numero_identificacion_egresado INT,
    IN numero_identificacion_estudiante_pregrado INT)
BEGIN
	DELETE FROM asesoria 
        WHERE 
			ase_fecha_inicio = fecha_inicio 
            AND ase_egr_numero_de_identificacion = numero_identificacion_egresado
            AND ase_est_pre_numero_de_identificacion = numero_identificacion_estudiante_pregrado;
	UPDATE estudiante_pregrado 
        SET est_pre_solicitud = 1 WHERE est_pre_numero_de_identificacion = numero_identificacion_estudiante_pregrado;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS insertar_carnet_datos;
DELIMITER $$
CREATE PROCEDURE insertar_carnet_datos(
    IN operacion INT,
    IN numero_identificacion INT,
    IN solicitud TINYINT
)
BEGIN 
    IF operacion = 1 THEN
        INSERT INTO carnet (
            car_egr_numero_de_identificacion,
            car_egr_solicitud
        )
        VALUES (
            numero_identificacion,
            solicitud
        );
    ELSEIF operacion = 2 THEN
        UPDATE carnet SET 
        car_egr_solicitud = solicitud WHERE car_egr_numero_de_identificacion = numero_identificacion;
    END IF;
END $$
DELIMITER ;

-- PA para egresado y administrador
DROP PROCEDURE IF EXISTS borrar_carnet_datos; 
DELIMITER $$
CREATE PROCEDURE borrar_carnet_datos (IN numero_identificacion INT)
BEGIN 
	DELETE FROM carnet WHERE car_egr_numero_de_identificacion = numero_identificacion;
END $$
DELIMITER ;

-- PA para administrador
DROP PROCEDURE IF EXISTS Listar_usuarios_por_autorizar; 
DELIMITER $$
CREATE PROCEDURE Listar_usuarios_por_autorizar ()
BEGIN 
	SELECT * FROM usuarios_por_autorizar;
END $$
DELIMITER ;

-- PA para administrador
DROP PROCEDURE IF EXISTS Ingresar_usuario_por_autorizar; 
DELIMITER $$
CREATE PROCEDURE Ingresar_usuario_por_autorizar(IN documento BIGINT, IN rol VARCHAR(45), IN user_name VARCHAR(45), IN pwd TEXT)
BEGIN 
	INSERT INTO usuarios_por_autorizar VALUES (documento, rol, user_name, pwd);
END $$
DELIMITER ;

-- PA para administrador
DROP PROCEDURE IF EXISTS Autorizar_usuarios; 
DELIMITER $$
CREATE PROCEDURE Autorizar_usuarios(IN documento BIGINT)
BEGIN
	DECLARE usr_documento BIGINT;
    DECLARE usr_username VARCHAR(45);
    DECLARE usr_password TEXT;
    DECLARE usr_role VARCHAR(45);
	START TRANSACTION;
        SET usr_documento = documento;
        SET usr_username = (SELECT usr_aut_user_name FROM usuarios_por_autorizar WHERE usr_aut_documento = documento);
        SET usr_password = (SELECT usr_aut_password FROM usuarios_por_autorizar WHERE usr_aut_documento = documento);
        SET usr_role = (SELECT usr_aut_rol FROM usuarios_por_autorizar WHERE usr_aut_documento = documento);
		DELETE FROM usuarios_por_autorizar WHERE usr_aut_documento = documento;
        INSERT INTO usuarios VALUES (usr_documento, usr_username, usr_password, usr_role);
	COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prestar_libro;
DELIMITER $$
CREATE PROCEDURE prestar_libro(
	IN numero_documento_identidad INT,
    IN id_libro INT
)
BEGIN 
	DECLARE prestados INT;
    DECLARE fecha1 TIMESTAMP;
    DECLARE fecha2 TIMESTAMP;
	START TRANSACTION ;
		SELECT count(*) INTO prestados FROM prestamo
			WHERE  pre_egr_numero_documento_identidad= numero_documento_identidad
			AND	pre_lib_id = id_libro;
		IF prestados = 0 THEN 
			CALL insertar_prestamo_datos(numero_documento_identidad,id_libro);			
        ELSE 
			SET fecha1 =( SELECT pre_fecha_prestamo FROM prestamo 
            WHERE  pre_egr_numero_documento_identidad= numero_documento_identidad
			AND	pre_lib_id = id_libro
            ORDER BY pre_fecha_prestamo DESC LIMIT 1);
            SET fecha2 =( SELECT pre_fecha_vencimiento FROM prestamo 
            WHERE  pre_egr_numero_documento_identidad= numero_documento_identidad
			AND	pre_lib_id = id_libro
            ORDER BY  pre_fecha_vencimiento DESC LIMIT 1);
			IF NOT(current_timestamp() BETWEEN fecha1 AND fecha2) THEN
				CALL insertar_prestamo_datos(numero_documento_identidad,id_libro);
			ELSE 
				ROLLBACK;
			END IF;
		END IF;
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS borrar_egresado;
DELIMITER $$
CREATE PROCEDURE borrar_egresado(IN numero_identificacion INT)
BEGIN 
	DELETE FROM informacion_personal_egresado WHERE egr_numero_de_identificacion = numero_identificacion;
END $$
DELIMITER ;

