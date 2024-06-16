import pymysql

def conexion_base_de_datos():
    connection = pymysql.connect(
        host='127.0.0.1',
        port=5000,
        user='root',
        password='root',
        database='egresado_db',
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection
