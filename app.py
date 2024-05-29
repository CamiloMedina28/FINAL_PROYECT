# pip install -r requirements.txt
# conda install -r requirements.txt

from flask import redirect, render_template, request, url_for
from flask_login import login_required
from usuarios import sesiones_usuarios
import localsettings as app
from flask import session
from pymongo import MongoClient

app.instanciate_app(__name__)

client = MongoClient("mongodb://root:root@my_mongo_db:27017/")
db = client['mongo']


@app.app.route('/')
def index():
    return render_template('index.html')


@app.app.route('/login')
def login():
    return render_template('login.html')


@app.app.route('/login_user', methods=['POST', 'GET'])
def login_user():
    if request.method == 'POST':
        username = request.form.get('usuario')
        contrasenia = request.form.get('contraseña')
        rol = request.form.get('rol')
        resultado_login = sesiones_usuarios.iniciar_sesion_de_usuario(
            username, contrasenia, rol)
        if resultado_login:
            if session['rol_usuario'] == 'administrador':
                return redirect(url_for('admin_dash'))
            else:
                pass
        else:
            return render_template('login.html', mensaje_error="El inicio de sesión ha sido incorrecto")


@app.app.route('/logout_user')
# @login_required
def logout_user():
    sesiones_usuarios.cierre_de_sesion_de_usuario()
    return redirect(url_for('login'))


@app.app.route('/admin_dash')
# @login_required
def admin_dash():
    return render_template('admin_dashboard.html')


@app.app.route('/Personal_Info')
def render_personal_info():
    return render_template('datosEgresadoAdmin.html')


@app.app.route('/bibliotecario')
def render_bibliotecario():
    return render_template('datos_bibliotecario.html')


if __name__ == '__main__':
    app.app.run(port=5010)
