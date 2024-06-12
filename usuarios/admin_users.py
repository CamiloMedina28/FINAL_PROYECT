from . import conectar_db as connect

def usuarios_por_autorizar():
    try:
        conexion = connect.conexion_base_de_datos()
    except Exception as error:
        return (1, str(error))
    else:
        with conexion.cursor() as cursor:
            cursor.callproc('Listar_usuarios_por_autorizar')
            return cursor.fetchall()
        

def autorizar_usuario(documento):
    try:
        conexion = connect.conexion_base_de_datos()
    except Exception as error:
        return (1, str(error))
    else:
        with conexion.cursor() as cursor:
            cursor.callproc('Autorizar_usuarios', (documento,))