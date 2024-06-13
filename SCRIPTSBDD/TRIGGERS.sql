USE egresado_db;

DROP TRIGGER IF EXISTS egresado_insert_constraint;
DELIMITER $$
CREATE TRIGGER egresado_insert_constraint BEFORE INSERT ON informacion_personal_egresado FOR EACH ROW
BEGIN
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.egr_numero_de_identificacion ;
    IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe egresado con id ', NEW.egr_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS egresado_update_constraint;
DELIMITER $$
CREATE TRIGGER egresado_update_constraint BEFORE UPDATE ON informacion_personal_egresado FOR EACH ROW
BEGIN 
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.egr_numero_de_identificacion ;
	IF existe= 0  THEN 
		SET msg = concat('No existe el egresado con el id ',NEW.egr_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS informacion_residencia_insert_constraint;
DELIMITER $$
CREATE TRIGGER informacion_residencia_insert_constraint BEFORE INSERT ON informacion_residencia
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_egresado INT;
    DECLARE existe INT;

    -- Verificar que el egresado exista
    SELECT COUNT(*) INTO existe_egresado 
    FROM informacion_personal_egresado 
    WHERE egr_numero_de_identificacion = NEW.inf_res_egr_numero_de_identificacion;

    IF existe_egresado = 0 THEN 
        SET msg = CONCAT('No existe el egresado con id ', NEW.inf_res_egr_numero_de_identificacion); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;

    -- Verificar que no exista ya un registro de residencia para el mismo egresado
    SELECT COUNT(*) INTO existe
    FROM informacion_residencia 
    WHERE inf_res_egr_numero_de_identificacion = NEW.inf_res_egr_numero_de_identificacion;

    IF existe != 0 THEN 
        SET msg = CONCAT('Ya existe una residencia registrada para el egresado con id ', NEW.inf_res_egr_numero_de_identificacion); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS contacto_insert_constraint;
DELIMITER $$
CREATE TRIGGER contacto_insert_constraint BEFORE INSERT ON contacto
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_egresado INT;
    DECLARE existe_contacto INT;

    -- Verificar que el egresado exista
    SELECT COUNT(*) INTO existe_egresado 
    FROM informacion_personal_egresado 
    WHERE egr_numero_de_identificacion = NEW.con_egr_numero_de_identificacion;

    IF existe_egresado = 0 THEN 
        SET msg = CONCAT('No existe el egresado con id ', NEW.con_egr_numero_de_identificacion); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;

    -- Verificar que no exista ya un registro de contacto para el mismo egresado
    SELECT COUNT(*) INTO existe_contacto 
    FROM contacto 
    WHERE con_egr_numero_de_identificacion = NEW.con_egr_numero_de_identificacion;

    IF existe_contacto != 0 THEN 
        SET msg = CONCAT('Ya existe un contacto registrado para el egresado con id ', NEW.con_egr_numero_de_identificacion); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS distincion_insert_constraint;
DELIMITER $$
CREATE TRIGGER distincion_insert_constraint BEFORE INSERT ON distincion
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_egresado INT;
    DECLARE existe_distincion INT;

    -- Verificar que el egresado exista
    SELECT COUNT(*) INTO existe_egresado 
    FROM informacion_personal_egresado 
    WHERE egr_numero_de_identificacion = NEW.dis_documento_egresado;

    IF existe_egresado = 0 THEN 
        SET msg = CONCAT('No existe el egresado con id ', NEW.dis_documento_egresado); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;

    -- Verificar que no exista ya un registro de distinción para el mismo egresado
    SELECT COUNT(*) INTO existe_distincion 
    FROM distincion 
    WHERE dis_documento_egresado = NEW.dis_documento_egresado;

    IF existe_distincion != 0 THEN 
        SET msg = CONCAT('Ya existe una distinción registrada para el egresado con id ', NEW.dis_documento_egresado); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS hijo_egresado_insert_constraint;
DELIMITER $$
CREATE TRIGGER hijo_egresado_insert_constraint BEFORE INSERT ON hijo_egresado
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_hijo INT;

    -- Verificar que no exista ya un registro de hijo con el mismo documento
    SELECT COUNT(*) INTO existe_hijo 
    FROM hijo_egresado 
    WHERE hij_documento = NEW.hij_documento;

    IF existe_hijo != 0 THEN 
        SET msg = CONCAT('Ya existe un hijo registrado con el documento ', NEW.hij_documento); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS familiar_insert_constraint;
DELIMITER $$
CREATE TRIGGER familiar_insert_constraint BEFORE INSERT ON familiar
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_egresado INT;
    DECLARE existe_hijo INT;
    DECLARE existe_familiar INT;
    -- Verificar que el egresado exista
    SELECT COUNT(*) INTO existe_egresado 
    FROM informacion_personal_egresado 
    WHERE egr_numero_de_identificacion = NEW.fam_egr_numero_documento_identidad;
	-- Verificar que el hijo del egresado exista
    SELECT COUNT(*) INTO existe_hijo 
    FROM hijo_egresado 
    WHERE hij_documento = NEW.fam_hijo_egresado_documento;
	IF existe_egresado = 0 AND existe_hijo = 0 THEN 
		SET msg = CONCAT('No existe ni egresado ni hijo con ids indicados'); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    ELSEIF existe_egresado = 0 AND existe_hijo != 0 THEN 
        SET msg = CONCAT('No existe el egresado con id ', NEW.fam_egr_numero_documento_identidad); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    ELSEIF existe_hijo = 0 AND existe_egresado != 0 THEN 
        SET msg = CONCAT('No existe el hijo del egresado con documento ', NEW.fam_hijo_egresado_documento); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
    -- Verificar que no exista ya un registro duplicado para la misma combinación de egresado e hijo
    SELECT COUNT(*) INTO existe_familiar 
    FROM familiar 
    WHERE fam_egr_numero_documento_identidad = NEW.fam_egr_numero_documento_identidad
    AND fam_hijo_egresado_documento = NEW.fam_hijo_egresado_documento;

    IF existe_familiar != 0 THEN 
        SET msg = CONCAT('Ya existe un registro de familiar para el egresado con id ', NEW.fam_egr_numero_documento_identidad, 
                         ' y el hijo con documento ', NEW.fam_hijo_egresado_documento); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS estudio_insert_constraint;
DELIMITER $$
CREATE TRIGGER estudio_insert_constraint BEFORE INSERT ON estudio_realizado FOR EACH ROW
BEGIN
	DECLARE existe_egresado INT;
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe_egresado FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.est_documento_egresado;
    IF existe_egresado=0 THEN
		SET msg = concat('No existe el egresado con id ',NEW.est_documento_egresado); 
        SIGNAL sqlstate '45000' SET message_text = msg; 
    END IF;
    SELECT count(*) INTO existe FROM estudio_realizado WHERE est_documento_egresado = NEW.est_documento_egresado  AND est_programa = NEW.est_programa;
    IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe este estudio'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS beca_insert_constraint;
DELIMITER $$
CREATE TRIGGER beca_insert_constraint BEFORE INSERT ON beca FOR EACH ROW
BEGIN
	DECLARE existe_programa INT;
	DECLARE existe_egresado INT;
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe_programa FROM estudio_realizado WHERE est_programa= NEW.bec_est_programa_formativo ;
    SELECT count(*) INTO existe_egresado FROM estudio_realizado WHERE est_documento_egresado= NEW.bec_est_documento_egresado;
    IF existe_programa= 0 AND existe_egresado=0 THEN 
		SET msg = concat('No existe el programa ',NEW.bec_est_programa_formativo,' ni el egresado con id ',NEW.bec_est_documento_egresado); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_programa =0 AND existe_egresado!=0 THEN
		SET msg = concat('No existe el programa ',NEW.bec_est_programa_formativo); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_programa !=0 AND existe_egresado=0 THEN
		SET msg = concat('No existe el egresado con id ',NEW.bec_est_documento_egresado); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
	SELECT count(*) INTO existe FROM beca
		WHERE bec_est_programa_formativo = NEW.bec_est_programa_formativo AND bec_est_documento_egresado = NEW.bec_est_documento_egresado;
    IF existe!=0 THEN 
		SET msg = concat('No se pueden ubicar 2 becas con el mismo programa'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS idioma_insert_constraint;
DELIMITER $$
CREATE TRIGGER idioma_insert_constraint BEFORE INSERT ON idioma
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_idioma INT;

    -- Verificar que no exista ya un registro con el mismo nombre de idioma
    SELECT COUNT(*) INTO existe_idioma 
    FROM idioma 
    WHERE idi_nombre = NEW.idi_nombre;

    IF existe_idioma != 0 THEN 
        SET msg = CONCAT('Ya existe un idioma registrado con el id ', NEW.idi_nombre); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS idioma_egresado_insert_constraint;
DELIMITER $$
CREATE TRIGGER idioma_egresado_insert_constraint BEFORE INSERT ON idioma_egresado
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_egresado INT;
    DECLARE existe_idioma INT;
    DECLARE existe_relacion INT;

    -- Verificar que el egresado exista
    SELECT COUNT(*) INTO existe_egresado 
    FROM informacion_personal_egresado 
    WHERE egr_numero_de_identificacion = NEW.idi_egr_numero_de_identificacion;
	-- Verificar que el idioma exista
    SELECT COUNT(*) INTO existe_idioma 
    FROM idioma 
    WHERE idi_idioma_id = NEW.idi_egr_idi_idioma_id;
	
	IF existe_egresado = 0 AND existe_idioma = 0 THEN
		SET msg = CONCAT('No existe ni el egresado ni idioma con ids presentados '); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    ELSEIF existe_egresado = 0 AND existe_idioma != 0 THEN 
        SET msg = CONCAT('No existe el egresado con id ', NEW.idi_egr_numero_de_identificacion); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    ELSEIF existe_idioma = 0 AND existe_egresado != 0 THEN 
        SET msg = CONCAT('No existe el idioma con id ', NEW.idi_egr_idi_idioma_id); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
    -- Verificar que no exista ya una relación para el mismo egresado e idioma
    SELECT COUNT(*) INTO existe_relacion 
    FROM idioma_egresado 
    WHERE idi_egr_numero_de_identificacion = NEW.idi_egr_numero_de_identificacion
    AND idi_egr_idi_idioma_id = NEW.idi_egr_idi_idioma_id;

    IF existe_relacion != 0 THEN 
        SET msg = CONCAT('Ya existe una relación registrada para el egresado con id ', NEW.idi_egr_numero_de_identificacion, 
                         ' y el idioma con id ', NEW.idi_egr_idi_idioma_id); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS proyecto_insert_constraint;
DELIMITER $$
CREATE TRIGGER proyecto_insert_constraint BEFORE INSERT ON proyecto_de_investigacion
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_proyecto INT;

    -- Verificar que no exista ya un proyecto con el mismo ID de Colciencias
    SELECT COUNT(*) INTO existe_proyecto 
    FROM proyecto_de_investigacion 
    WHERE pro_inv_id_colciencias = NEW.pro_inv_id_colciencias;

    IF existe_proyecto != 0 THEN 
        SET msg = CONCAT('Ya existe un proyecto de investigación registrado con el ID de Colciencias ', NEW.pro_inv_id_colciencias); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS investigacion_del_egresado_insert_constraint;
DELIMITER $$
CREATE TRIGGER investigacion_del_egresado_insert_constraint BEFORE INSERT ON investigacion_del_egresado
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_egresado INT;
    DECLARE existe_proyecto INT;
    DECLARE existe_relacion INT;

    -- Verificar que el egresado exista
    SELECT COUNT(*) INTO existe_egresado 
    FROM informacion_personal_egresado 
    WHERE egr_numero_de_identificacion = NEW.inv_documento_egresado;
	-- Verificar que el proyecto de investigación exista
    SELECT COUNT(*) INTO existe_proyecto 
    FROM proyecto_de_investigacion 
    WHERE pro_inv_id_colciencias = NEW.inv_id_colciencias;

	IF  existe_egresado = 0 AND existe_proyecto = 0 THEN
		SET msg = CONCAT('No existe ni el egresado ni el proyecto con id datos'); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    ELSEIF existe_egresado = 0 AND existe_proyecto != 0 THEN 
        SET msg = CONCAT('No existe el egresado con documento ', NEW.inv_documento_egresado); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
	ELSEIF existe_proyecto = 0 AND existe_egresado != 0 THEN 
        SET msg = CONCAT('No existe el proyecto de investigación con id ', NEW.inv_id_colciencias); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;

    -- Verificar que no exista ya una relación para el mismo egresado y proyecto de investigación
    SELECT COUNT(*) INTO existe_relacion 
    FROM investigacion_del_egresado 
    WHERE inv_documento_egresado = NEW.inv_documento_egresado
    AND inv_id_colciencias = NEW.inv_id_colciencias;

    IF existe_relacion != 0 THEN 
        SET msg = CONCAT('Ya existe una relación registrada para el egresado con documento ', NEW.inv_documento_egresado, 
                         ' y el proyecto de investigación con id ', NEW.inv_id_colciencias); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS empresa_insert_constraint;
DELIMITER $$
CREATE TRIGGER empresa_insert_constraint BEFORE INSERT ON empresa FOR EACH ROW
BEGIN 
	
	DECLARE existe INT;
	DECLARE msg varchar(255); 
	SELECT count(*) INTO existe FROM empresa WHERE emp_idNit= NEW.emp_idNit;
	IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe la empresa con id ',NEW.emp_idNit); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS convocatoria_insert_constraint;
DELIMITER $$
CREATE TRIGGER convocatoria_insert_constraint BEFORE INSERT ON convocatoria FOR EACH ROW
BEGIN
	DECLARE existe_empresa INT;
	DECLARE existe INT;
    DECLARE msg varchar(255); 
	SELECT count(*) INTO existe_empresa FROM empresa WHERE emp_idNit= NEW.con_empresa_idNit;
    IF existe_empresa=0 THEN
		SET msg = concat('No existe la empresa con id ',NEW.con_empresa_idNit); 
        SIGNAL sqlstate '45000' SET message_text = msg; 
    END IF;
    SELECT count(*) INTO existe FROM convocatoria WHERE con_id= NEW.con_id;
	IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe la convocatoria con id ',NEW.con_id); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS convocatorias_aplicadas_insert_constraint;
DELIMITER $$
CREATE TRIGGER convocatorias_aplicadas_insert_constraint BEFORE INSERT ON convocatorias_aplicadas FOR EACH ROW 
BEGIN 
    DECLARE msg varchar(255); 
    DECLARE existe INT;
	DECLARE existe_convocatoria INT;
    DECLARE existe_egresado INT;
    SELECT count(*) INTO existe_convocatoria FROM convocatoria WHERE con_id= NEW.con_apl_id AND con_empresa_idNit= NEW.con_apl_emp_idNit ;
    SELECT count(*) INTO existe_egresado FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.conv_documento_identidad;
    IF existe_convocatoria= 0 AND existe_egresado=0 THEN 
		SET msg = concat('No existe la convocatoria, ni el egresado con id ', NEW.conv_documento_identidad); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_convocatoria =0 AND existe_egresado!=0 THEN
		SET msg = concat('No existe la convocatoria'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_convocatoria !=0 AND existe_egresado=0 THEN
		SET msg = concat('No existe el egresado con id ', NEW.conv_documento_identidad); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
	SELECT count(*) INTO existe FROM convocatorias_aplicadas
		WHERE con_apl_id= NEW.con_apl_id
        AND con_apl_emp_idNit= NEW.con_apl_emp_idNit 
		AND  conv_documento_identidad= NEW.conv_documento_identidad;
    IF existe!=0 THEN 
		SET msg = concat('Ya existe una aplicación a la misma convocatoria y empresa'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS trabajo_insert_constraint;
DELIMITER $$
CREATE TRIGGER trabajo_insert_constraint BEFORE INSERT ON trabajo FOR EACH ROW
BEGIN
	DECLARE existe_egresado INT;
	DECLARE existe INT;
    DECLARE msg varchar(255); 
	SELECT count(*) INTO existe_egresado FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.tra_egr_documento_egresado;
    IF existe=0 THEN
		SET msg = concat('No existe el egresado con id ',NEW.tra_egr_documento_egresado); 
        SIGNAL sqlstate '45000' SET message_text = msg; 
    END IF;
    SELECT count(*) INTO existe FROM trabajo WHERE tra_id = NEW.tra_id AND tra_egr_documento_egresado =NEW.tra_egr_documento_egresado ;
	IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya fue agregado este trabajo'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS jefe_insert_constraint;
DELIMITER $$
CREATE TRIGGER jefe_insert_constraint BEFORE INSERT ON jefe
FOR EACH ROW 
BEGIN 
    DECLARE msg VARCHAR(255); 
    DECLARE existe_trabajo INT;
    DECLARE existe_jefe INT;

    -- Verificar que el egresado exista en la tabla trabajo
    SELECT COUNT(*) INTO existe_trabajo 
    FROM trabajo 
    WHERE tra_id = NEW.jef_id AND tra_egr_documento_egresado = NEW.jef_documento_egresado;

    IF existe_trabajo = 0 THEN 
        SET msg = CONCAT('No existe un registro en la tabla trabajo para el egresado con documento ', NEW.jef_documento_egresado); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;

    -- Verificar si ya hay un jefe con esas llaves primarias
    SELECT COUNT(*) INTO existe_jefe 
    FROM Jefe 
    WHERE jef_id = NEW.jef_id AND jef_documento_egresado = NEW.jef_documento_egresado;

    IF existe_jefe != 0 THEN 
        SET msg = CONCAT('Ya existe un jefe registrado con las mismas llaves primarias'); 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg; 
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS libro_insert_constraint;
DELIMITER $$
CREATE TRIGGER libro_insert_constraint BEFORE INSERT ON libro FOR EACH ROW
BEGIN
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe FROM libro WHERE lib_id_libro= NEW.lib_id_libro ;
    IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe el libro ', NEW.lib_id_libro); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS prestamo_insert_constraint;
DELIMITER $$
CREATE TRIGGER prestamo_insert_constraint BEFORE INSERT ON prestamo FOR EACH ROW
BEGIN
	DECLARE existe INT;
	DECLARE existe_libro INT;
    DECLARE existe_egresado INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe_libro FROM libro WHERE lib_id_libro= NEW.pre_lib_id ;
    SELECT count(*) INTO existe_egresado FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.pre_egr_numero_documento_identidad;
    IF existe_libro= 0 AND existe_egresado=0 THEN 
		SET msg = concat('No existe el libro con id ',NEW.pre_lib_id,' ni el egresado con id ',NEW.pre_egr_numero_documento_identidad); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_libro =0 AND existe_egresado!=0 THEN
		SET msg = concat('No existe el libro con id ',NEW.pre_lib_id); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_libro !=0 AND existe_egresado=0 THEN
		SET msg = concat('No existe el egresado con id ',NEW.pre_egr_numero_documento_identidad); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
    SELECT count(*) INTO existe FROM prestamo 
		WHERE pre_lib_id= NEW.pre_lib_id AND
			pre_egr_numero_documento_identidad= NEW.pre_egr_numero_documento_identidad and
            pre_fecha_prestamo= NEW. pre_fecha_prestamo;
    IF existe != 0 THEN
    SET msg = concat('Ya existe un prestamo del libro ',NEW.pre_lib_id,' para el egresado con id ',NEW.pre_egr_numero_documento_identidad,
    'en la fecha',NEW. pre_fecha_prestamo); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS estudiante_pregrado_insert_constraint;
DELIMITER $$
CREATE TRIGGER estudiante_pregrado_insert_constraint BEFORE INSERT ON estudiante_pregrado FOR EACH ROW
BEGIN 
	DECLARE existe INT;
	DECLARE msg varchar(255); 
	SELECT count(*) INTO existe FROM estudiante_pregrado WHERE est_pre_numero_de_identificacion= NEW.est_pre_numero_de_identificacion;
	IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe el egresado con id ',NEW.est_pre_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS estudiante_pregrado_update_constraint;
DELIMITER $$
CREATE TRIGGER estudiante_pregrado_update_constraint BEFORE UPDATE ON estudiante_pregrado FOR EACH ROW
BEGIN 
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe FROM estudiante_pregrado WHERE est_pre_numero_de_identificacion = NEW.est_pre_numero_de_identificacion ;
	IF existe= 0  THEN 
		SET msg = concat('No existe el estudiante de pregrado con el id ',NEW.est_pre_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS asesoria_insert_constraint;
DELIMITER $$
CREATE TRIGGER asesoria_insert_constraint BEFORE INSERT ON asesoria FOR EACH ROW 
BEGIN 
    DECLARE msg varchar(255); 
    DECLARE existe INT;
	DECLARE existe_pregrado INT;
    DECLARE existe_egresado INT;
    SELECT count(*) INTO existe_pregrado FROM estudiante_pregrado WHERE est_pre_numero_de_identificacion= NEW.ase_est_pre_numero_de_identificacion ;
    SELECT count(*) INTO existe_egresado FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.ase_egr_numero_de_identificacion;
    IF existe_pregrado= 0 AND existe_egresado=0 THEN 
		SET msg = concat('No existe el estudiante de pregrado con id ',NEW.ase_est_pre_numero_de_identificacion,' ni el egresado con id ',NEW.ase_egr_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_pregrado =0 AND existe_egresado!=0 THEN
		SET msg = concat('No existe el estudiante de pregrado con id ',NEW.ase_est_pre_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	ELSEIF existe_pregrado !=0 AND existe_egresado=0 THEN
		SET msg = concat('No existe el egresado con id ',NEW.ase_egr_numero_de_identificacion); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
	SELECT count(*) INTO existe FROM asesoria 
		WHERE ase_fecha_inicio=NEW.ase_fecha_inicio
        AND ase_egr_numero_de_identificacion= NEW.ase_egr_numero_de_identificacion
        AND ase_est_pre_numero_de_identificacion=NEW.ase_est_pre_numero_de_identificacion;
    IF existe!=0 THEN 
		SET msg = concat('No se pueden ubicar 2 asesorias en la misma fecha'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS carnet_insert_constraint;
DELIMITER $$
CREATE TRIGGER carnet_insert_constraint BEFORE INSERT ON carnet FOR EACH ROW
BEGIN
	DECLARE existe_egresado INT;
	DECLARE existe INT;
    DECLARE msg varchar(255); 
    SELECT count(*) INTO existe_egresado FROM informacion_personal_egresado WHERE egr_numero_de_identificacion= NEW.car_egr_numero_de_identificacion;
    IF existe_egresado=0 THEN
		SET msg = concat('No existe el egresado con id ',NEW.car_egr_numero_de_identificacion); 
        SIGNAL sqlstate '45000' SET message_text = msg; 
    END IF;
    SELECT count(*) INTO existe FROM carnet WHERE car_egr_numero_de_identificacion= NEW.car_egr_numero_de_identificacion ;
    IF existe != 0 THEN 
		SET msg = concat('En la base de datos ya existe la solicitud'); 
		SIGNAL sqlstate '45000' SET message_text = msg; 
	END IF;
END $$
DELIMITER ;

