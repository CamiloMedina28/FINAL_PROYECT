from . import conexion_db
def create_book():
    pass

def delete_book(id):
    conexion = conexion_db.conexion_base_de_datos()
    with conexion.cursor() as cursor:
        cursor.callproc('borrar_libro_datos', id)
        conexion.commit()
        

def read_book():
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                sql = 'SELECT * FROM Libro'
                cursor.execute(sql)
                return (0, cursor.fetchall())
        except Exception as error:
            return (1, f"Error en la obtención de información {str(error)}")
        
def crear_libro(id:int, titulo:str, biblioteca:str, autor:str, estante:str) -> tuple:
    print("createlibro")
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
            print('pass')
    pass