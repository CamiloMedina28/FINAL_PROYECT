from scripts import db_proccess

class User:
    def __init__(self, id) -> None:
        self.id = id
    
    def info(self):
        pass

def iniciar_sesion_de_usuario(username:str, contraseña:str) -> bool:
    """Función para la gestión del inicio de sesión de usuarios

    Args:
        username (str): Usuario que desea iniciar la sesión
        contrase (str): Contraseña del inicio de sesión

    Returns:
        bool: True si el inicio de sesión es válido. De lo contrario False
    """
    value = db_proccess.ejecutar_query("SELECT * FROM users WHERE ID = ?", (1212, ))
    print(value)
    print(username, contraseña)
    return True

def logout():
    pass

def create_user(*args):
    pass
