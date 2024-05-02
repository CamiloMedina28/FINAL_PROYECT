from flask import Flask, render_template, request
from scripts import users_manage

app = Flask(__name__)

@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/settings')
def settings():
    return render_template('settings.html')

@app.route('/login_user', methods = ['POST', 'GET'])
def login_user():
    if request.method == 'POST':
        username = request.form.get('usuario')
        contraseña = request.form.get('contraseña')
        resultado_login = users_manage.iniciar_sesion_de_usuario(username, contraseña)
        if resultado_login:
            print("\033[33m", "Inicio de sesión validado", "\033[0m")
            return render_template('login.html') # Cambiar
        else:
            return render_template('login.html')
