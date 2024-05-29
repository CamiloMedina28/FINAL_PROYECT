from flask import Flask
from datetime import timedelta
from flask_login import LoginManager
from flask_login import UserMixin
from usuarios import conectar_db

app_name = ''

def instanciate_app(name):
    global app_name
    app_name = name
    
app = Flask(app_name)

app.secret_key = '192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf'

app.config['DEBUG'] = True
app.config['TEMPLATES_AUTO_RELOAD'] = True

class User(UserMixin):
    def __init__(self, documento, username, password, rol) -> None:
        self.id = documento
        self.username = username
        self.password = password
        self.role = rol
    
    def info(self):
        pass

    def get(self):
        pass


app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(hours=4)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
app.config['REMEMBER_COOKIE_DURATION'] = timedelta(hours=4)

@login_manager.user_loader
def load_user(user_id) -> User or None: # type: ignore
    conexion = conectar_db.conexion_base_de_datos()
    with conexion.cursor() as cursor:
        sql = 'SELECT * FROM Usuarios WHERE usr_documento = %s'
        cursor.execute(sql, (user_id,))
        user_data = cursor.fetchone()
    if user_data:
        return User(*user_data)
    return None
