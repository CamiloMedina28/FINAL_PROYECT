db = client.db("Egresado_Adicional");

db.createCollection("info_personal_adicional_egresado", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "info_personal_adicional_egresado",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "adi_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "adi_egr_segundo_nombre": {
                    "bsonType": "string"
                },
                "adi_egr_estado_civil": {
                    "bsonType": "string"
                },
                "adi_egr_victima_conflicto_armado": {
                    "bsonType": "string"
                },
                "adi_egr_departamento_nacimiento": {
                    "bsonType": "string"
                },
                "adi_egr_municipio_nacimiento": {
                    "bsonType": "string"
                },
                "edi_egr_sexo": {
                    "bsonType": "string"
                },
                "edi_egr_grupo_etnico": {
                    "bsonType": "string"
                },
                "edi_egr_estrato": {
                    "bsonType": "int"
                }
            },
            "additionalProperties": false,
            "required": [
                "adi_egr_numero_identificacion"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("contacto", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "contacto",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "con_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "con_numero_telefono_adicional": {
                    "bsonType": "long"
                },
                "con_correo_adicional": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "con_egr_numero_identificacion"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("hijos", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "hijos",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "hij_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "hij_numero_identificacion": {
                    "bsonType": "number"
                },
                "hij_nombre": {
                    "bsonType": "string"
                },
                "hij_primer_apellido": {
                    "bsonType": "string"
                },
                "hij_segundo_apellido": {
                    "bsonType": "string"
                },
                "hij_ano_nacimiento": {
                    "bsonType": "string"
                },
                "hij_direccion_residencia": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});