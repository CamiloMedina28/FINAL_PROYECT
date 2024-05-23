from flask import Flask, render_template, request
from usuarios import sesiones_usuarios
from flask_sqlalchemy import SQLAlchemy
import localsettings as app

app.instanciate_app(__name__)
db = SQLAlchemy(app.app)

@app.app.route('/')
def index():
    return render_template('index.html')

@app.app.route('/login')
def login():
    return render_template('login.html')

@app.app.route('/settings')
def settings():
    return render_template('settings.html')

@app.app.route('/login_user', methods = ['POST', 'GET'])
def login_user():
    if request.method == 'POST':
        username = request.form.get('usuario')
        contrasenia = request.form.get('contraseña')
        # rol= request.form.get('rol')
        resultado_login = sesiones_usuarios.iniciar_sesion_de_usuario(username, contrasenia, 'administrador')
        if resultado_login:
            print("\033[33m", "Inicio de sesión validado", "\033[0m")
            return render_template('admin_dashboard.html') 
        else:
            return render_template('login.html', mensaje_error = "El inicio de sesión ha sido incorrecto")


if __name__ == '__main__':
    app.app.run(port=5010)