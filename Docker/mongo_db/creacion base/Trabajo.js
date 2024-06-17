db = client.db("Trabajo");

db.createCollection("trabajo", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "trabajo",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "tra_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "tra_emp_id": {
                    "bsonType": "number"
                },
                "tra_jef_documento": {
                    "bsonType": "number"
                },
                "tra_nombre_cargo": {
                    "bsonType": "string"
                },
                "tra_ocupacion": {
                    "bsonType": "string"
                },
                "tra_tipo_vinculacion": {
                    "bsonType": "string"
                },
                "tra_area_desempeno": {
                    "bsonType": "string"
                },
                "tra_rango_salario": {
                    "bsonType": "string"
                },
                "tra_fecha_inicio": {
                    "bsonType": "string"
                },
                "tra_fecha_finalizacion": {
                    "bsonType": "string"
                },
                "tra_pais": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("jefe", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "jefe",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "jef_documento": {
                    "bsonType": "number"
                },
                "jef_nombre": {
                    "bsonType": "string"
                },
                "jef_primer_apelldio": {
                    "bsonType": "string"
                },
                "jef_segundo_apellido": {
                    "bsonType": "string"
                },
                "jef_telefono": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("convocatoria", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "convocatoria",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "con_id": {
                    "bsonType": "number"
                },
                "con_emp_id": {
                    "bsonType": "number"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("empresa", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "empresa",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "emp_id": {
                    "bsonType": "number"
                },
                "emp_correo": {
                    "bsonType": "string"
                },
                "emp_direccion": {
                    "bsonType": "string"
                },
                "emp_telefono": {
                    "bsonType": "string"
                },
                "emp_actividad_economica": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "emp_id"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("empresa_adicional", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "empresa_adicional",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "adi_emp_id": {
                    "bsonType": "number"
                },
                "adi_emp_razon_social": {
                    "bsonType": "string"
                },
                "adi_numero_empleados": {
                    "bsonType": "string"
                },
                "adi_representante_legal": {
                    "bsonType": "string"
                },
                "adi_emp_matricula_mercantil": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("convocatorias_aplicadas", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "convocatorias_aplicadas",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "apli_con_id": {
                    "bsonType": "number"
                },
                "apli_egr_numero_identificacion": {
                    "bsonType": "number"
                },
                "apli_fecha_aplicacion": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});