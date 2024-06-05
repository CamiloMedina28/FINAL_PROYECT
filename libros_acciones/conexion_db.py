import pymysql

def conexion_base_de_datos():
    connection = pymysql.connect(
        host = '127.0.0.1',
        port = 3306,
        user = 'root',
        password = '',
        database = 'egresado_db',
        cursorclass = pymysql.cursors.DictCursor 
    )
    return connection