from . import conexion_db

def read_all_convo(proced: str, Id: int) -> None:
    """
    Lectura o delete de convocatoria
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc(proced, (Id,))
                info = cursor.fetchall()
        except Exception as error:
            return (1, f"Error en el procedimientoAlmacenado {str(error)}")
        else:
            return (0, info)
        
def RD_convo(proced: str, IdConvo: int, IdUser: int) -> None:
    """
    Lectura o delete de convocatoria
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc(proced, (IdConvo, IdUser))
                conexion.commit()
                info = "Exitoso"
        except Exception as error:
            return (1, f"Error en el procedimientoAlmacenado {str(error)}")
        else:
            return (0, info)
        
def R_convo(proced: str, IdConvo: int, IdUser: int) -> None:
    """
    Lectura o delete de convocatoria
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc(proced, (IdConvo, IdUser))
                info = cursor.fetchall()
        except Exception as error:
            return (1, f"Error en el procedimientoAlmacenado {str(error)}")
        else:
            return (0, info)

def R_info_(proced: str, IdElement: int) -> None:
    """
    Lectura elemento specifico
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor() as cursor:
                cursor.callproc(proced, (IdElement))
                info = cursor.fetchall()
        except Exception as error:
            return (1, f"Error en el procedimientoAlmacenado {str(error)}")
        else:
            return (0, info)

def U_apli(id_con: int,id_emp: int, id_egr: int, estado: str) -> None:
    """
    Update de convocatoria aplicadas
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            proced = "update_estado_convocatoria"
            with conexion.cursor() as cursor:
                cursor.callproc(proced, (id_con, id_emp, id_egr, estado))
                conexion.commit()
                info = "Exitoso"
        except Exception as error:
            return (1, f"Error en el procedimientoAlmacenado {str(error)}")
        else:
            return (0, info)

def create_convo(
                empresa_id: int, cargo: str, habilidades: str,
                competencias: str, experiencia: int, vacantes: int,
                salario: int, jornada: str, horario: str,
                teletrabajo: str, pais: str, ciudad: str,
                fechaIN: str, fechaOUT: str
                ) -> tuple:
    """Función para la inserción de libros en la base de datos. 
    """
    try:
        conexion = conexion_db.conexion_base_de_datos()
    except Exception as error:
        print(str(error))
        return (1, f"Error en la conexión con la base de datos {str(error)}")
    else:
        try:
            with conexion.cursor()as cursor:
                cursor.callproc('insertar_convocatoria_datos',
                                (
                                empresa_id, cargo, habilidades,
                                competencias, experiencia, vacantes,
                                salario, jornada, horario,
                                teletrabajo, pais, ciudad,
                                fechaIN, fechaOUT))
                conexion.commit()
        except Exception as error:
            print(str(error))
            return (1, f"Error en la creación del registro: {str(error)}")
        else:
            return (0, "El registro ha sido insertado exitosamente en la base de datos.")

