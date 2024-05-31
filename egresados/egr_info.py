from . import conectar_db as connect

def ejecutar_pass_info_egr(id:int, nombre_proc:str) -> tuple:
    info = []
    conexion = connect.conexion_base_de_datos()
    with conexion.cursor() as cursor:
        try:
            cursor.callproc(nombre_proc, id)
            for result in cursor.stored_results():
                info.append(result.fetchall())
        except: 
            return (1, [])
        else:
            return (0, info)
        finally: 
            conexion.close() # Cierre de la conexion con la base de datos.
