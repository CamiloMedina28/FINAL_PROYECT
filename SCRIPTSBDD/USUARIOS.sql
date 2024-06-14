SELECT * FROM egresado_db.usuarios;
INSERT INTO usuarios VALUES 
(111, 'cmedinasa', 'scrypt:32768:8:1$BTVfdDXu77UaPD7q$a8e120f2fdebaa5c4b8f396741f2f9c3c8f230305c31b83cf588a81797e6f200aaafe6eac668553b1e84a90b533ee7914a6803a26e0749ba24fa148b3516f349', 'Administrador'), 
(222, 'sisuarezc', 'scrypt:32768:8:1$BTVfdDXu77UaPD7q$a8e120f2fdebaa5c4b8f396741f2f9c3c8f230305c31b83cf588a81797e6f200aaafe6eac668553b1e84a90b533ee7914a6803a26e0749ba24fa148b3516f349', 'Administrador'), 
(333, 'jramirezes', 'scrypt:32768:8:1$BTVfdDXu77UaPD7q$a8e120f2fdebaa5c4b8f396741f2f9c3c8f230305c31b83cf588a81797e6f200aaafe6eac668553b1e84a90b533ee7914a6803a26e0749ba24fa148b3516f349', 'Administrador');


INSERT INTO usuarios_por_autorizar (usr_aut_documento,usr_aut_user_name,usr_aut_password,usr_aut_rol) VALUES 
(2000000001, 'lagarcia', 'scrypt:32768:8:1$HzSBW2gBXyGi0oTo$78a8dbc18bb3c486690373329ea0f396923c1488b9680ba4df9070a70f261eacd351f94435d79d95f46b5415e5a5e0ba84fa3b72285c8bb4d5fcbfa30bafe1b4', 'Pregradousuarios_por_autorizar'),
(1000000001, 'juperez' , 'scrypt:32768:8:1$T6pg5fmcHOJaLOMS$e822d3fb310e6a8ed4bc7c0e3427e59d213743f4f0c27b0b18c24c1d2e814ea69c2bd1faf7698fab029be2a207e09cb97052f49b5bc70b189ba5dd87321d12f5', 'Egresado');
