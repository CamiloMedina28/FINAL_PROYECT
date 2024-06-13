INSERT INTO egresado_db.informacion_personal_egresado (
  egr_numero_de_identificacion, 
  egr_primer_nombre, 
  egr_primer_apellido, 
  egr_segundo_apellido, 
  egr_sexo, 
  egr_estrato, 
  egr_grupo_etnico, 
  egr_estado_civil, 
  egr_discapacidad, 
  egr_admision_especial, 
  egr_victima_conflicto_armado, 
  egr_tipo_identificacion, 
  egr_pais_nacimiento, 
  egr_departamento_nacimiento, 
  egr_municipio_nacimiento, 
  egr_segundo_nombre
) VALUES
(1000000001, 'Juan', 'Perez', 'Gomez', 'Masculino', 3, 'Ninguno', 'Soltero', 'Ninguna', 'Ninguna', 'No', 'Cédula de Ciudadanía', 'Colombia', 'Cundinamarca', 'Bogotá', 'Carlos'),
(1000000002, 'Maria', 'Lopez', 'Martinez', 'Femenino', 4, 'Afro', 'Casado', 'Visual', 'Peama', 'No', 'Cédula de Ciudadanía', 'Colombia', 'Antioquia', 'Medellín', 'Luisa'),
(1000000003, 'Pedro', 'Garcia', 'Rodriguez', 'Masculino', 2, 'Indigena', 'Union libre', 'Fisica', 'Paes', 'Si', 'Tarjeta de Identidad', 'Colombia', 'Santander', 'Bucaramanga', 'Jose'),
(1000000004, 'Luisa', 'Rodriguez', 'Suarez', 'Femenino', 5, 'Raizal del archipielago de San Andres Providencia y Santa Catalina', 'Divorciado', 'Auditiva', 'Ninguna', 'No', 'Cédula de Ciudadanía', 'Colombia', 'San Andres', 'San Andres', 'Isabel'),
(1000000005, 'Carlos', 'Fernandez', 'Ramirez', 'Masculino', 1, 'Rom/Gitano', 'Soltero', 'Psicosocial', 'Ninguna', 'No', 'Cédula de Ciudadanía', 'Colombia', 'Valle del Cauca', 'Cali', 'Miguel'),
(1000000006, 'Ana', 'Gomez', 'Hernandez', 'Femenino', 3, 'Negro', 'Casado', 'Sordomudismo', 'Paes', 'Si', 'Cédula de Extranjería', 'Colombia', 'Bolivar', 'Cartagena', 'Maria'),
(1000000007, 'Jose', 'Martinez', 'Lopez', 'Masculino', 4, 'Ninguno', 'Viudo', 'Multiples', 'Ninguna', 'No', 'Cédula de Ciudadanía', 'Colombia', 'Atlántico', 'Barranquilla', 'Alberto'),
(1000000008, 'Elena', 'Sanchez', 'Mendoza', 'Femenino', 2, 'Afro', 'Soltero', 'Intelectual', 'Peama', 'No', 'Cédula de Ciudadanía', 'Colombia', 'Cundinamarca', 'Soacha', 'Lucia'),
(1000000009, 'Miguel', 'Ruiz', 'Diaz', 'Masculino', 5, 'Palenquero', 'Union libre', 'Visual', 'Paes', 'Si', 'Pasaporte', 'Colombia', 'Cesar', 'Valledupar', 'Andres'),
(1000000010, 'Sofia', 'Ramirez', 'Gutierrez', 'Femenino', 1, 'Ninguno', 'Casado', 'Sordoceguera', 'Ninguna', 'No', 'Cédula de Ciudadanía', 'Colombia', 'Huila', 'Neiva', 'Camila');

INSERT INTO egresado_db.informacion_residencia (
  inf_res_egr_numero_de_identificacion,
  inf_res_pais_residencia,
  inf_res_departamento_residencia,
  inf_res_municipio_residencia,
  inf_res_ciudad_residencia,
  inf_res_direccion_residencia
) VALUES
(1000000001, 'Colombia', 'Cundinamarca', 'Bogotá', 'Bogotá D.C.', 'Carrera 10 #20-30'),
(1000000002, 'Colombia', 'Antioquia', 'Medellín', 'Medellín', 'Calle 20 #30-40'),
(1000000003, 'Colombia', 'Santander', 'Bucaramanga', 'Bucaramanga', 'Avenida 30 #40-50'),
(1000000004, 'Colombia', 'San Andres', 'San Andres', 'San Andres', 'Carrera 40 #50-60'),
(1000000005, 'Colombia', 'Valle del Cauca', 'Cali', 'Cali', 'Calle 50 #60-70');

INSERT INTO egresado_db.contacto (
  con_egr_numero_de_identificacion,
  con_numero_telefono_principal,
  con_correo_electronico_principal,
  con_numero_telefono_adicional,
  con_correo_adicional
) VALUES
(1000000001, 12345678, 'juan.perez@example.com', 987654321, 'jperez@example.com'),
(1000000002, 23456789, 'maria.lopez@example.com', NULL, NULL),
(1000000003, 34567890, 'pedro.garcia@example.com', NULL, NULL),
(1000000004, 45678901, 'luisa.rodriguez@example.com', 876543210, 'lrodriguez@example.com'),
(1000000005, 56789012, 'carlos.fernandez@example.com', NULL, NULL);

INSERT INTO egresado_db.distincion (
  dis_documento_egresado,
  dis_año,
  dist_nombre_distincion,
  dist_descripcion
) VALUES
(1000000001, 2020, 'Premio Excelencia Académica', 'Reconocimiento al mejor promedio académico del año.'),
(1000000002, 2019, 'Premio Investigación', 'Premio por la mejor investigación en ciencias sociales.'),
(1000000003, 2018, 'Premio Innovación', 'Reconocimiento por el desarrollo de una aplicación innovadora.'),
(1000000004, 2021, 'Premio Compromiso Social', 'Premio por contribuciones destacadas a la comunidad.'),
(1000000005, 2019, 'Premio Liderazgo', 'Reconocimiento por habilidades de liderazgo en proyectos estudiantiles.');

INSERT INTO egresado_db.hijo_egresado (
  hij_documento,
  hij_nombre,
  hij_primer_apellido,
  hij_segundo_apellido,
  hij_año_nacimiento,
  hij_direccion_residencia
) VALUES
(0000000001, 'Ana', 'Perez', 'Gomez', 2010, 'Calle 123 #45-67'),
(0000000002, 'Luis', 'Lopez', 'Martinez', 2012, 'Carrera 8 #12-34'),
(0000000003, 'Carlos', 'Garcia', 'Rodriguez', 2009, 'Avenida 10 #20-30'),
(0000000004, 'Maria', 'Rodriguez', 'Suarez', 2011, 'Calle 50 #15-25'),
(0000000005, 'Jorge', 'Fernandez', 'Ramirez', 2013, 'Carrera 1 #2-3');

INSERT INTO egresado_db.familiar (fam_egr_numero_documento_identidad, fam_hijo_egresado_documento)
VALUES
(1000000001, 0000000001),
(1000000002, 0000000002),
(1000000002, 0000000003),
(1000000004, 0000000004),
(1000000005, 0000000005);


INSERT INTO egresado_db.estudio_realizado (
  est_documento_egresado,
  est_programa,
  est_institucion_educativa,
  est_sede,
  est_facultad,
  est_fecha_inicio,
  est_fecha_finalizacion,
  est_estado_formación,
  est_nivel_educativo
) VALUES
(1000000001, 'Ingenieria de Sistemas', 'Universidad Nacional de Colombia', 'Sede Bogotá', 'Facultad de Ingeniería', '2016-07-15', '2021-12-20', 'Finalizada', 'Pregrado'),
(1000000008, 'Administración de Empresas', 'Universidad de Los Andes', 'Sede Bogotá', 'Escuela de Administración', '2017-02-10', '2021-11-30', 'Finalizada', 'Pregrado'),
(1000000003, 'Derecho', 'Universidad Externado de Colombia', 'Sede Bogotá', 'Facultad de Derecho', '2015-08-20', '2020-06-25', 'Finalizada', 'Pregrado'),
(1000000004, 'Medicina', 'Universidad de Antioquia', 'Sede Medellín', 'Facultad de Medicina', '2016-01-05', '2022-03-15', 'Finalizada', 'Pregrado'),
(1000000006, 'Psicología', 'Pontificia Universidad Javeriana', 'Sede Bogotá', 'Facultad de Psicología', '2018-03-12', '2022-07-10', 'Finalizada', 'Pregrado');

INSERT INTO egresado_db.beca (
  bec_est_programa_formativo,
  bec_est_documento_egresado,
  bec_nombre_beca,
  bec_entidad_otorga,
  bec_fecha_inicio,
  bec_fecha_finalizacion,
  bec_duracion
) VALUES
('Ingenieria de Sistemas', 1000000001, 'Beca de Excelencia Académica', 'Colfuturo', '2017-01-15', '2021-12-20', '5 años'),
('Administración de Empresas', 1000000008, 'Beca Liderazgo', 'ICETEX', '2018-03-01', '2021-11-30', '4 años'),
('Derecho', 1000000003, 'Beca Justicia Social', 'Banco de la República', '2016-08-20', '2020-06-25', '4 años'),
('Medicina', 1000000004, 'Beca Investigación en Salud', 'Minciencias', '2017-01-05', '2022-03-15', '5 años'),
('Psicología', 1000000006, 'Beca Talento Javeriano', 'Pontificia Universidad Javeriana', '2019-03-12', '2022-07-10', '3 años');

INSERT INTO egresado_db.idioma (idi_nombre)
VALUES
('Español'),
('Inglés'),
('Francés'),
('Alemán'),
('Italiano'),
('Portugués'),
('Mandarín'),
('Japonés'),
('Ruso'),
('Árabe');

INSERT INTO egresado_db.idioma_egresado (idi_egr_numero_de_identificacion, idi_egr_idi_idioma_id, idi_egr_nivel)
VALUES
(1000000001, 1, 'Nativo'),  
(1000000002, 2, 'Avanzado'), 
(1000000003, 3, 'Intermedio'), 
(1000000004, 4, 'Básico'), 
(1000000001, 2, 'Intermedio'), 
(1000000005, 5, 'Avanzado'), 
(1000000006, 6, 'Básico'), 
(1000000007, 7, 'Intermedio'), 
(1000000002, 8, 'Básico'), 
(1000000003, 9, 'Avanzado');

INSERT INTO egresado_db.proyecto_de_investigacion (pro_inv_id_colciencias, pro_inv_nombre_grupo, pro_inv_descripcion, pro_inv_institucion)
VALUES
(1, 'Grupo de Investigación en Ciencias Computacionales', 'Investigación sobre algoritmos de aprendizaje automático y sus aplicaciones.', 'Universidad Nacional de Colombia'),
(2, 'Grupo de Investigación en Biotecnología', 'Estudios avanzados en biotecnología y sus aplicaciones en la industria.', 'Universidad de los Andes'),
(3, 'Grupo de Investigación en Salud Pública', 'Proyectos enfocados en la mejora de la salud pública y prevención de enfermedades.', 'Universidad del Rosario'),
(4, 'Grupo de Investigación en Economía', 'Análisis de políticas económicas y su impacto en la sociedad.', 'Universidad EAFIT'),
(5, 'Grupo de Investigación en Ingeniería', 'Desarrollo de nuevas tecnologías y soluciones en el campo de la ingeniería.', 'Pontificia Universidad Javeriana'),
(6, 'Grupo de Investigación en Ciencias Sociales', 'Estudios sobre dinámicas sociales y su influencia en el desarrollo comunitario.', 'Universidad del Valle'),
(7, 'Grupo de Investigación en Química', 'Investigaciones en química orgánica e inorgánica y sus aplicaciones.', 'Universidad de Antioquia'),
(8, 'Grupo de Investigación en Física', 'Proyectos sobre física teórica y experimental en diversas áreas.', 'Universidad Industrial de Santander'),
(9, 'Grupo de Investigación en Educación', 'Investigación sobre metodologías educativas y su impacto en el aprendizaje.', 'Universidad de Caldas'),
(10, 'Grupo de Investigación en Medio Ambiente', 'Estudios sobre conservación ambiental y sostenibilidad.', 'Universidad del Norte');

INSERT INTO egresado_db.investigacion_del_egresado (inv_documento_egresado, inv_id_colciencias, inv_rol_en_grupo, inv_fecha_inicio, inv_fecha_finalizacion)
VALUES
(1000000001, 1, 'Investigador Principal', '2020-01-01', '2022-01-01'),
(1000000002, 2, 'Colaborador', '2021-05-01', '2023-05-01'),
(1000000003, 3, 'Asistente de Investigación', '2019-07-15', '2021-07-15'),
(1000000004, 4, 'Investigador Principal', '2022-09-01', '2024-09-01'),
(1000000005, 5, 'Colaborador', '2020-11-01', '2022-11-01');

INSERT INTO egresado_db.empresa (
  emp_idNit, 
  emp_matricula_mercantil, 
  emp_razon_social, 
  emp_direccion, 
  emp_telefono, 
  emp_actividad_economica, 
  emp_numero_empleados, 
  emp_representante_legal, 
  emp_correo
) VALUES
(101, '123456789', 'Tech Solutions', 'Avenida 1 #10-20', 1234567, 'Tecnología', 150, 'Carlos Perez', 'info@techsolutions.com'),
(102, '987654321', 'Innovate Corp', 'Calle 2 #20-30', 2345678, 'Consultoría', 200, 'Ana Martinez', 'contacto@innovatecorp.com'),
(103, '456789123', 'Creative Minds', 'Carrera 3 #30-40', 3456789, 'Publicidad', 100, 'Luis Gomez', 'support@creativeminds.com'),
(104, '789123456', 'Future Vision', 'Avenida 4 #40-50', 4567890, 'Finanzas', 300, 'María Rodriguez', 'info@futurevision.com'),
(105, '321654987', 'Global Tech', 'Calle 5 #50-60', 5678901, 'Tecnología', 250, 'Juan Fernandez', 'contact@globaltech.com');


INSERT INTO egresado_db.convocatoria (
  con_id, 
  con_empresa_idNit, 
  con_nombre_cargo, 
  con_habilidades, 
  con_competencias, 
  con_meses_experiencia, 
  con_numero_vacantes, 
  con_salario, 
  con_jornada_trabajo, 
  con_horario_trabajo, 
  con_teletrabajo, 
  con_pais_convocatoria, 
  con_ciudad_convocatoria, 
  con_fecha_convocatoria, 
  con_fecha_expiracion
) VALUES
(1, 101, 'Desarrollador Web', 'HTML, CSS, JavaScript', 'Trabajo en equipo, Comunicación', 24, '2', 3000000, 'COMPLETA', 'Lunes a Viernes, 9am - 6pm', 'No', 'Colombia', 'Bogotá', '2024-05-01', '2024-06-01'),
(2, 102, 'Analista de Datos', 'SQL, Python', 'Análisis crítico, Resolución de problemas', 36, '1', 4000000, 'COMPLETA', 'Lunes a Viernes, 8am - 5pm', 'No', 'Colombia', 'Medellín', '2024-05-01', '2024-06-01'),
(3, 103, 'Diseñador Gráfico', 'Photoshop, Illustrator', 'Creatividad, Atención al detalle', 18, '3', 2500000, 'MEDIA', 'Lunes a Viernes, 1pm - 5pm', 'Si', 'Colombia', 'Cali', '2024-05-01', '2024-06-01'),
(4, 104, 'Ingeniero de Software', 'Java, Spring Boot', 'Liderazgo, Adaptabilidad', 48, '1', 5000000, 'COMPLETA', 'Lunes a Viernes, 9am - 6pm', 'No', 'Colombia', 'Barranquilla', '2024-05-01', '2024-06-01'),
(5, 105, 'Gerente de Proyectos', 'Gestión de proyectos, Scrum', 'Liderazgo, Organización', 60, '1', 6000000, 'COMPLETA', 'Lunes a Viernes, 9am - 6pm', 'No', 'Colombia', 'Cartagena', '2024-05-01', '2024-06-01');

INSERT INTO egresado_db.convocatorias_aplicadas (
  con_apl_id, 
  con_apl_emp_idNit, 
  conv_documento_identidad, 
  conv_apl_fecha_aplicacion
) VALUES
(1, 101, 1000000001, '2024-05-15'),
(2, 102, 1000000002, '2024-05-16'),
(3, 103, 1000000003, '2024-05-17'),
(4, 104, 1000000004, '2024-05-18'),
(5, 105, 1000000005, '2024-05-19'),
(1, 101, 1000000006, '2024-05-20'),
(2, 102, 1000000007, '2024-05-21'),
(3, 103, 1000000008, '2024-05-22'),
(4, 104, 1000000009, '2024-05-23'),
(5, 105, 1000000010, '2024-05-24');



INSERT INTO egresado_db.trabajo (
  tra_id,
  tra_egr_documento_egresado,
  tra_nombre_cargo,
  tra_ocupacion,
  tra_tipo_vinculacion,
  tra_area_desempeño,
  tra_rango_salario,
  tra_fecha_inicio,
  tra_fecha_finalizacion,
  tra_pais,
  tra_departamento,
  tra_municipio,
  tra_emp_id_Nit,
  tra_trabajo_actual
) VALUES
(1,1000000001, 'Analista de Sistemas', 'Analista', 'Contrato indefinido', 'TI', '4000000-5000000', '2020-01-15', NULL, 'Colombia', 'Cundinamarca', 'Bogotá', 101, 1),
(1,1000000002, 'Gerente de Proyecto', 'Gerente', 'Contrato a término fijo', 'Proyectos', '7000000-8000000', '2019-03-01', '2023-02-28', 'Colombia', 'Antioquia', 'Medellín', 102, 0),
(1,1000000003, 'Desarrollador de Software', 'Desarrollador', 'Contrato indefinido', 'Desarrollo', '5000000-6000000', '2021-05-10', NULL, 'Colombia', 'Santander', 'Bucaramanga', 103, 1),
(1,1000000004, 'Diseñador Gráfico', 'Diseñador', 'Contrato a término fijo', 'Marketing', '3000000-4000000', '2022-07-01', '2024-06-30', 'Colombia', 'San Andres', 'San Andres', 104, 0),
(1,1000000005, 'Consultor Financiero', 'Consultor', 'Contrato indefinido', 'Finanzas', '6000000-7000000', '2018-10-15', NULL, 'Colombia', 'Valle del Cauca', 'Cali', 105, 1);

INSERT INTO egresado_db.jefe(
  jef_id,
  jef_documento_egresado,
  jef_nombre,
  jef_primer_apellido,
  jef_segundo_apellidos,
  jef_telefono
) VALUES
(1,1000000001, 'Carlos', 'Gomez', 'Hernandez', 1234567890),
(1,1000000002, 'Maria', 'Lopez', NULL, 2345678901),
(1,1000000003, 'Juan', 'Martinez', 'Gomez', 3456789012),
(1,1000000004, 'Ana', 'Rodriguez', NULL, 4567890123),
(1,1000000005, 'Pedro', 'Garcia', 'Suarez', 5678901234);

INSERT INTO egresado_db.carnet (car_egr_numero_de_identificacion)
VALUES
(1000000001),
(1000000003),
(1000000005),
(1000000007),
(1000000009);

INSERT INTO egresado_db.estudiante_pregrado (
  est_pre_numero_de_identificacion,
  est_pre_nombre,
  est_pre_primer_apellido,
  est_pre_segundo_apellido,
  est_pre_facultad,
  est_pre_carrera,
  est_pre_admision_especial
) VALUES
(2000000001, 'Laura', 'Garcia', 'Lopez', 'Facultad de Ingeniería', 'Ingeniería de Sistemas', 'Peama'),
(2000000002, 'Juan', 'Rodriguez', 'Martinez', 'Facultad de Ciencias', 'Biología', NULL),
(2000000003, 'Andrea', 'Lopez', 'Gomez', 'Facultad de Ingeniería', 'Ingeniería Industrial', 'Paes'),
(2000000004, 'Carlos', 'Martinez', 'Hernandez', 'Facultad de Arquitectura', 'Arquitectura', NULL),
(2000000005, 'Sofia', 'Perez', 'Fernandez', 'Facultad de Administración', 'Mercadeo', 'Paes');

INSERT INTO egresado_db.asesoria (
  ase_egr_numero_de_identificacion,
  ase_est_pre_numero_de_identificacion,
  ase_fecha_inicio,
  ase_fecha_finalizacion
) VALUES
(1000000001, 2000000001,  '2023-01-15', '2023-05-30'),
(1000000002, 2000000002,  '2022-09-01', '2023-01-31'),
(1000000002, 2000000003,  '2022-11-10', '2023-03-15'),
(1000000004, 2000000004,  '2023-02-20', '2023-06-30'),
(1000000005, 2000000005,  '2022-12-05', '2023-04-15');

INSERT INTO egresado_db.libro (lib_id_libro, lib_titulo, lib_biblioteca, lib_autor, lib_estante)
VALUES
(1, 'Cien años de soledad', 'Biblioteca Central', 'Gabriel García Márquez', 'Ficción'),
(2, 'El principito', 'Biblioteca Central', 'Antoine de Saint-Exupéry', 'Infantil'),
(3, 'La sombra del viento', 'Biblioteca Central', 'Carlos Ruiz Zafón', 'Misterio'),
(4, '1984', 'Biblioteca Central', 'George Orwell', 'Distopía'),
(5, 'Orgullo y prejuicio', 'Biblioteca Central', 'Jane Austen', 'Romance');

INSERT INTO egresado_db.prestamo (pre_egr_numero_documento_identidad, pre_lib_id, pre_fecha_prestamo, pre_fecha_vencimiento)
VALUES
(1000000001, 1, '2024-05-01 10:00:00', '2024-05-15 10:00:00'),
(1000000002, 2, '2024-05-02 11:00:00', '2024-05-16 11:00:00'),
(1000000003, 3, '2024-05-03 12:00:00', '2024-05-17 12:00:00'),
(1000000004, 4, '2024-05-04 13:00:00', '2024-05-18 13:00:00'),
(1000000005, 5, '2024-05-05 14:00:00', '2024-05-19 14:00:00');

