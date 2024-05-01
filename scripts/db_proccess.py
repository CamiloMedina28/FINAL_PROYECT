import sqlite3

def ejecutar_query(*args) -> bool:
    """Función que ejecuta querys sobre la base de datos

    Args:
        query (str): Query a ejecutar sobre la base de datos
        parametros (tuple): Parametros que tiene el query

    Returns:
        bool: Retorna el valor de verdad según el éxito de la ejecución de la dunción
    """
    try:
        conexion = sqlite3.connect('db_egresados.db')
        cursor = conexion.cursor()
        cursor.execute(*args)
        conexion.commit()
        conexion.close()
    except:
        return False
    else:
        return cursor
    

def borrar_info():
    pass

def crear_bdd():
    pass

