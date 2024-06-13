from flask import session
from werkzeug.security import check_password_hash
from flask_login import UserMixin, login_user, logout_user, login_manager
from . import conectar_db


class User(UserMixin):
    def __init__(self, documento, username, password, rol) -> None:
        self.id = documento
        self.username = username
        self.password = password
        self.role = rol

    def info(self):
        pass


def iniciar_sesion_de_usuario(username: str, contrasenia: str, role: str) -> bool:
    """Función para la gestión del inicio de sesión de usuarios

    Args:
        username (str): Usuario que desea iniciar la sesión
        contrasenia (str): Contraseña del inicio de sesión

    Returns:
        bool: True si el inicio de sesión es válido. De lo contrario False
    """
    session['rol_usuario'] = None  # Limpieza de la variable de sesion rol_usuario
    session['doc_usuario'] = None
    conexion = conectar_db.conexion_base_de_datos()
    with conexion.cursor() as cursor:
        sql = 'SELECT * FROM usuarios WHERE usr_username = %s'
        cursor.execute(sql, (username,))
        datos_usuario = cursor.fetchone()
    if datos_usuario and check_password_hash(datos_usuario['usr_password'], contrasenia) and datos_usuario['usr_role'] == role:
        user = User(datos_usuario['usr_documento'],
                    datos_usuario['usr_username'],
                    datos_usuario['usr_password'],
                    datos_usuario['usr_role'])  # Modelo de datos
        # Guardado el rol del usuario
        session['rol_usuario'] = datos_usuario['usr_role']
        session['doc_usuario'] = datos_usuario['usr_documento']
        login_user(user)  # Inicio de sesion
        return True
    return False


def cierre_de_sesion_de_usuario():
    logout_user()
