# import conectar_db as connect
from . import conectar_db as connect
from werkzeug.security import generate_password_hash


def create_temporal_user(rol, documento, user_name, password):
    conexion = connect.conexion_base_de_datos()
    with conexion.cursor() as cursor:
        query_existencia_1 = "SELECT * FROM usuarios_por_autorizar WHERE usr_aut_documento = %s;"
        query_existencia_2 = "SELECT * FROM usuarios WHERE usr_documento = %s;"
        cursor.execute(query_existencia_1, (str(documento),))
        if cursor.fetchone():
            return "El usuario se encuentra a la espera de aprobación."
        cursor.execute(query_existencia_2, (documento,))
        if cursor.fetchone():
            return "El usuario ya existe en la base de datos."
        # Creación del hash con la contraseña del usuario.
        user_password = generate_password_hash(password)
        cursor.callproc('Ingresar_usuario_por_autorizar',
                        (documento, rol, user_name, user_password))
        conexion.commit()
        return "El usuario ha enviado su solicitud para ingresar a la base de datos, esperando aprobación."


