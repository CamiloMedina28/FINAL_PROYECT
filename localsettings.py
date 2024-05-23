from flask import Flask
from datetime import timedelta
from flask_login import LoginManager

app_name = ''

def instanciate_app(name):
    global app_name
    app_name = name
    
app = Flask(app_name)

app.secret_key = '192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf'

app.config['DEBUG'] = True


login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
app.config['REMEMBER_COOKIE_DURATION'] = timedelta(hours=4)