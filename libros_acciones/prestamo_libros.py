from . import conexion_db


def ver_prestamos():
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        with conexion.cursor() as cursor:
            cursor.execute("SELECT * FROM prestamo")
            datos =  cursor.fetchall()
            print(datos)
            return (0, datos)


def ingresar_prestamo(documento_egresado:int, id_libro:int) -> tuple:
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc('insertar_prestamo_datos', (documento_egresado, id_libro))
                conexion.commit()
        except Exception as error:
            return (1, f"Error en la inserción de los datos {str(error)}")
        else: 
            (0, "El dato ha sido ingresado con exito en la base de datos.")