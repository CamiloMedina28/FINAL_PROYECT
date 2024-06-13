from . import conexion_db


def read_student(id: int):
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc('ver_pregrado', (id,))
                info = cursor.fetchall()
                return (0, info)
        except Exception as error:
            return (1, f"Error en la obtención de información {str(error)}")


def add_consulting(documento_egresado: int, documento_pregrado: int, solicitud: int) -> tuple:
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc('insertar_asesoria_datos',
                                (documento_egresado, documento_pregrado, solicitud))
                conexion.commit()
        except Exception as error:
            return (1, f"Error en la inserción de los datos {str(error)}")
        else:
            return (0, "El dato ha sido ingresado con exito en la base de datos.")
