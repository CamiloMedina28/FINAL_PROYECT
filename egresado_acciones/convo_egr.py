from . import connect

def read_all_convo(proced: str, Id: int) -> None:
    """
    Lectura o delete de convocatoria
    """
    try:
        conexion = connect.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc(proced, (Id,))
                info = cursor.fetchall()
        except Exception as error:
            return (1, f"Error en el procedimientoAlmacenado {str(error)}")
        else:
            return (0, info)