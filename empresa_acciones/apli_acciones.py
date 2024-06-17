from . import conexion_db

def read_apli(empresaId: int) -> None:
    """
    Lectura de todos las aplicaciones correspondientes a esta empresa.
    """
    info = []
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        with conexion.cursor() as cursor:
            try:
                pass #####
            except:
                return (1, f"Error en el procedimientoAlmacenado {str(error)}")
            else:
                return (0, info)
            finally:
                conexion.close()  # Cierre de la conexion con la base de datos.


def update_apli(estado: str) -> None:
    pass
