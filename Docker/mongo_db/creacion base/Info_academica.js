db = client.db("Info_Academica");

db.createCollection("estudio_realizado", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "estudio_realizado",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "aca_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "aca_programa": {
                    "bsonType": "string"
                },
                "aca_institucion_educativa": {
                    "bsonType": "string"
                },
                "aca_sede": {
                    "bsonType": "string"
                },
                "aca_fecha_inicio": {
                    "bsonType": "string"
                },
                "aca_fecha_finalizacion": {
                    "bsonType": "string"
                },
                "aca_estado_formacion": {
                    "bsonType": "string"
                },
                "aca_nivel_educativo": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("investigacion_del_egresado", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "investigacion_del_egresado",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "inv_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "inv_pro_colciencias": {
                    "bsonType": "number"
                },
                "inv_rol_en_grupo": {
                    "bsonType": "string"
                },
                "inv_fecha_inicio": {
                    "bsonType": "string"
                },
                "inv_fecha_finalizacion": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("proyecto_de_investigacion", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "proyecto_de_investigacion",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "pro_invid_colciencias": {
                    "bsonType": "number"
                },
                "pro_inv_nombre_grupo": {
                    "bsonType": "string"
                },
                "pro_inv_descripcion": {
                    "bsonType": "string"
                },
                "pro_inv_institucion": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "pro_invid_colciencias"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});