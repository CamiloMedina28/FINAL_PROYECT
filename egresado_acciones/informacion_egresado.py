from . import connect


def retrieve_informacion_personal(id = None):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        with conexion.cursor() as cursor:
            sql = "SELECT * FROM informacion_egresado"
            cursor.execute(sql)
            if id:
                for egresado in cursor.fetchall():
                    if egresado['egr_numero_de_identificacion'] == id:
                        return egresado
            else: return cursor.fetchall()


def retrieve_informacion_contacto(id = None):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        with conexion.cursor() as cursor:
            sql = "SELECT * FROM informacion_contacto"
            cursor.execute(sql)
            if id:
                for egr_info_contacto in cursor.fetchall():
                    if egr_info_contacto['egr_numero_de_identificacion'] == id:
                        return egr_info_contacto
            else:
                return cursor.fetchall()
            

def retrieve_datos_familiares(id = None):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        with conexion.cursor() as cursor:
            sql = "SELECT * FROM datos_familiares"
            cursor.execute(sql)
            if id:
                familia = []
                for datos_familia in cursor.fetchall():
                    if datos_familia['egr_numero_de_identificacion'] == id:
                        familia.append(datos_familia)
                return familia
            else:

                return cursor.fetchall()
            

def retrieve_informacion_residencia_egresado(id = None):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        with conexion.cursor() as cursor:
            sql = "SELECT * FROM informacion_residencia_egr"
            cursor.execute(sql)
            if id:
                for residencia in cursor.fetchall():
                    if residencia['egr_numero_de_identificacion'] == id:
                        return residencia
            else:
                return cursor.fetchall()
            

def retrieve_informacion_distinciones(id = None):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        with conexion.cursor() as cursor:
            sql = "SELECT * FROM distinciones"
            cursor.execute(sql)
            if id:
                distinciones = []
                for distincion in cursor.fetchall():
                    if distincion['egr_numero_de_identificacion'] == id:
                        distinciones.append(distincion)
                return distinciones
            else:
                return cursor.fetchall()   
