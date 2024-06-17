db = client.db("Info_academica_adicional");

db.createCollection("beca", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "beca",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "bec_aca_programa": {
                    "bsonType": "string"
                },
                "bec_aca_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "bec_nombre": {
                    "bsonType": "string"
                },
                "bec_entidad": {
                    "bsonType": "string"
                },
                "bec_fecha_inicio": {
                    "bsonType": "date"
                },
                "bec_fecha_finalizacion": {
                    "bsonType": "date"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("disticion", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "disticion",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "dis_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "dis_ano": {
                    "bsonType": "date"
                },
                "dis_nombre": {
                    "bsonType": "string"
                },
                "dis_descripcion": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});