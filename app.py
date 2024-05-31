# pip install -r requirements.txt
# conda install -r requirements.txt

from flask import redirect, render_template, request, url_for
from flask_login import login_required
from usuarios import sesiones_usuarios
import localsettings as app
from flask import session
from pymongo import MongoClient
import egresados as egr

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
# @login_required
def render_personal_info():
    return render_template('egresadosDatosPerso.html')

@app.app.route('/informacion_personal_egresados/<int:id>')
# @login_required
def render_info_personal_egr(id):
    if session['rol_usuario'] == "Egresado":
        lista_info = egr.egr_info.ejecutar_pass_info_egr(id, 'ver_datos_personales')
        if lista_info[0] == 0:
            return render_template('informacion_personal_egresados.html',
                                   info = lista_info[1])
        else: 
            return render_template('informacion_personal_egresados.html',
                                   mensaje = "Los datos solicitados no puedieron ser encontrados.")
    if session['rol_usuaio'] == "Administrador":
        lista_info = egr.egr_info.ejecutar_pass_info_egr(id=0, nombre_proc='ver_datos_personales')
        if lista_info[0] == 0:
            return render_template('informacion_personal_egresados.html',
                                   info = lista_info)
        else:
            return render_template('informacion_personal_egresados.html',
                                   mensaje = "Los datos solicitados no puedieron ser encontrados.")

@app.app.route('/bibliotecario')
def render_bibliotecario():
    return render_template('bibliotecarioBase.html')


@app.app.route('/bibliotecario/libros')
def render_libros():
    return render_template('bibliotecarioLibros.html')


@app.app.route('/bibliotecario/prestamo')
def render_prestamo():
    return render_template('bibliotecarioPrestamo.html')


@app.app.route('/empresa')
def render_empresa():
    return render_template('empresaBase.html')


@app.app.route('/empresa/convocatorias')
def render_convocatorias():
    return render_template('empresaConvocatorias.html')


@app.app.route('/empresa/aplicantes')
def render_aplicantes():
    return render_template('empresaAplicantes.html')


@app.app.route('/pregrado')
def render_pregrado():
    return render_template('pregradoBase.html')


@app.app.route('/pregrado/asesoria')
def render_asesoria():
    return render_template('pregradoAsesoria.html')


if __name__ == '__main__':
    app.app.run(port=5010)
