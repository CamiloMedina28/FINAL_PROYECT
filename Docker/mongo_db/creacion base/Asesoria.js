db = client.db("Asesoria");

db.createCollection("asesoria", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "asesoria",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "ase_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "ase_est_pre_numero_identificacion": {
                    "bsonType": "number"
                },
                "ase_nombre_proyecto_grado": {
                    "bsonType": "string"
                },
                "ase_fecha_inicio": {
                    "bsonType": "string"
                },
                "ase_fecha_finalizacion": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("estudiante_pregrado", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "estudiante_pregrado",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "est_pre_numero_identificacion": {
                    "bsonType": "number"
                },
                "est_pre_nombre": {
                    "bsonType": "string"
                },
                "est_pre_primer_apellido": {
                    "bsonType": "string"
                },
                "est_pre_segundo_apellido": {
                    "bsonType": "string"
                },
                "est_pre_carrera": {
                    "bsonType": "string"
                },
                "est_pre_admision_especial": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});