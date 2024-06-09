from . import conexion_db


def delete_loan(documento: int, id_libro: int) -> None:
    """Eliminar registros de prestamos

    Args:
        documento (int) : Identificador único del egresado
        id (int): Identificador del prestamo a eliminar
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc('borrar_prestamo_datos', (documento, id_libro))
                conexion.commit()
        except Exception as error:
            return (1, f"Error al eliminar prestamo en la base de datos {str(error)}")


def read_loan() -> None:
    """Lectura de todos los registros accerca de los prestamos
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                sql = 'SELECT * FROM prestamo'
                cursor.execute(sql)
                return (0, cursor.fetchall())
        except Exception as error:
            return (1, f"Error en la obtención de información {str(error)}")


def create_loan(documento_egresado: int, id_libro: int, fecha_prestamo: str, fecha_vencimiento: str) -> tuple:
    """Funció para la inserción de prestamos en la base de datos

    Args:
        documento_egresado (int): Identificador único del egresado
        id_libro (int): Identificador único del libro.
        fecha_prestamo (str): Momento en que se realiza el préstamo del libro
        fecha_vencimiento (str):Momento en que se vence el préstamo del libro

    Returns:
        tuple: tupla con el código de error y mensaje
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc('insertar_prestamo_datos',
                                (documento_egresado, id_libro, fecha_prestamo, fecha_vencimiento))
                conexion.commit()
        except Exception as error:
            return (1, f"Error en la inserción de los datos {str(error)}")
        else:
            (0, "El dato ha sido ingresado con exito en la base de datos.")
