from . import conexion_db


def delete_book(id:int) -> None:
    """Eliminar registros de libros

    Args:
        id (int): Identificador del libro a eliminar.
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return(1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc('borrar_libro_datos', id)
                conexion.commit()
        except Exception as error:
            return(1, f"Error al eliminar libros en la base de datos {str(error)}")


def read_book() -> None:
    """
    Lectura de todos los registros acerca de los libros.
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                sql = 'SELECT * FROM libro'
                cursor.execute(sql)
                return (0, cursor.fetchall())
        except Exception as error:
            return (1, f"Error en la obtención de información {str(error)}")
        

def crear_libro(id:int, titulo:str, biblioteca:str, autor:str, estante:str) -> tuple:
    """Función para la inserción de libros en la base de datos. 

    Args:
        id (int): Identificador único del libro.
        titulo (str): Titulo del libro a insertar.
        biblioteca (str): Biblioteca en la que está el libro.
        autor (str): Autor del libro.
        estante (str): Estanteria en la que el libro está ubicado.

    Returns:
        tuple: tupla con código de error y mensaje
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        print(str(error))
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor()as cursor:
                cursor.callproc('insertar_libro_datos', (id, titulo, biblioteca, autor, estante))
                conexion.commit()
        except Exception as error:
            print(str(error))
            return (1, f"Error en la creación del registro: {str(error)}")
        else:
            return(0, "El registro ha sido insertado exitosamente en la base de datos.")

