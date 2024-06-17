db = client.db("Biblioteca");

db.createCollection("prestamo", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "prestamo",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "pre_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "pre_lib_id": {
                    "bsonType": "number"
                },
                "pre_fecha_prestamo": {
                    "bsonType": "string"
                },
                "pre_fecha_vencimiento": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("libro", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "libro",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "lib_id": {
                    "bsonType": "number"
                },
                "lib_titulo": {
                    "bsonType": "string"
                },
                "lib_biblioteca": {
                    "bsonType": "string"
                },
                "lib_autor": {
                    "bsonType": "string"
                },
                "lib_estante": {
                    "bsonType": "number"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});