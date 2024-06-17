db = client.db("Egresado");

db.createCollection("info_personal_basica_egresado", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "info_personal_basica_egresado",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "egr_tipo_identificacion": {
                    "bsonType": "string"
                },
                "egr_primer_nombre": {
                    "bsonType": "string"
                },
                "egr_primer_apellido": {
                    "bsonType": "string"
                },
                "egr_segundo_apellido": {
                    "bsonType": "string"
                },
                "egr_discapacidad": {
                    "bsonType": "string"
                },
                "egr_admision_especial": {
                    "bsonType": "string"
                },
                "egr_pais_nacimiento": {
                    "bsonType": "string"
                },
                "egr_telefono": {
                    "bsonType": "string"
                },
                "egr_correo": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "egr_numero_identificacion",
                "egr_primer_nombre"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("residencia", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "residencia",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "res_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "res_departamento": {
                    "bsonType": "string"
                },
                "res_pais": {
                    "bsonType": "string"
                },
                "res_municipio": {
                    "bsonType": "string"
                },
                "res_ciudad": {
                    "bsonType": "string"
                },
                "res_direccion": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "res_egr_numero_identificacion"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("idioma", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "idioma",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "idi_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "idioma_nombre": {
                    "bsonType": "string"
                },
                "idioma_nivel": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});