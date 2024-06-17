from . import connect


def retrieve_informacion_personal(id=None):
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
            else:
                return cursor.fetchall()


def retrieve_informacion_contacto(id=None):
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


def retrieve_datos_familiares(id=None):
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


def retrieve_informacion_residencia_egresado(id=None):
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


def retrieve_informacion_distinciones(id=None):
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


def eliminar_info_egresado(proc, id):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc(proc, (id,))
                conexion.commit()
            return "El egresado ha sido eliminado exitosamente de la base de datos."
        except Exception as error:
            return f"Error, el egresado no ha podido ser ingresado en la base de datos: {str(error)}"


def agregar_info_contacto(accion, documento, telefono_principal, correo_principal, telefono_adicional, correo_adicional):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:

                cursor.callproc('insertar_contacto_datos', (accion, documento,
                                telefono_principal, correo_principal, telefono_adicional, correo_adicional))
                conexion.commit()

            return "La información de contacto ha sido agregada exitosamente"
        except Exception as error:
            return f"Ha ocurrido un error: {str(error)}"


def existe_info_contacto(id):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:
                sql = "SELECT * FROM contacto WHERE con_egr_numero_de_identificacion = %s"
                cursor.execute(sql, (id,))
                datos = cursor.fetchone()
            return datos
        except Exception as error:
            return "Ha ocurrido un error: " + str(error)

def agregar_info_residencia(accion, documento, pais, departamento, municipio, ciudad, direccion):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:

                cursor.callproc('insertar_residencia_datos', (accion, documento,
                                pais, departamento, municipio, ciudad, direccion))
                conexion.commit()

            return "La información de residencia ha sido agregada exitosamente"
        except Exception as error:
            return f"Ha ocurrido un error: {str(error)}"


def existe_info_residencia(id):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:
                sql = "SELECT * FROM informacion_personal_egresado WHERE egr_numero_de_identificacion = %s"
                cursor.execute(sql, (id,))
                datos = cursor.fetchone()
            return datos
        except Exception as error:
            return "Ha ocurrido un error: " + str(error)

def agregar_info_familiar(
        accion, docmento_hijo, nombre_hijo, 
        pri_ape_hijo, seg_ape_hijo, anio_nacimiento_hijo,
        direccion_residencia_hijo
    ):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:

                cursor.callproc('insertar_hijos_egresado_datos', (
                accion, docmento_hijo, nombre_hijo, 
                pri_ape_hijo, seg_ape_hijo, anio_nacimiento_hijo,
                direccion_residencia_hijo))
                conexion.commit()

            return "La información de familiar ha sido agregada exitosamente"
        except Exception as error:
            return f"Ha ocurrido un error: {str(error)}"

def existe_info_familiar(id):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:
                sql = "SELECT * FROM familiar WHERE fam_egr_numero_documento_identidad = %s"
                cursor.execute(sql, (id,))
                datos = cursor.fetchone()
            return datos
        except Exception as error:
            return "Ha ocurrido un error: " + str(error)

def agregar_info_distincion(
        accion,documento, anio, nombre_distincion, descripcion
    ):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:

                cursor.callproc('distincion_datos', (
                accion, documento, anio, nombre_distincion, descripcion))
                conexion.commit()

            return "La información de familiar ha sido agregada exitosamente"
        except Exception as error:
            return f"Ha ocurrido un error: {str(error)}"

def existe_info_distincion(id):
    try:
        conexion = connect.conexion_base_de_datos()
    except:
        pass
    else:
        try:
            with conexion.cursor() as cursor:
                sql = "SELECT * FROM distincion WHERE dis_documento_egresado = %s"
                cursor.execute(sql, (id,))
                datos = cursor.fetchone()
            return datos
        except Exception as error:
            return "Ha ocurrido un error: " + str(error)