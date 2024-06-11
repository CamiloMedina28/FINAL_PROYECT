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
