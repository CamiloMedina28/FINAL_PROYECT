#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
Manejo de todas las funcionalidades del programa
"""
from flask import redirect, render_template, request, url_for
from flask_login import login_required
from usuarios import sesiones_usuarios
import localsettings as app
from flask import session
from pymongo import MongoClient
import egresados as egr
import biblio_acciones as biblio

app.instanciate_app(__name__)
client = MongoClient("mongodb://root:root@my_mongo_db:27017/")
db = client['mongo']

tabla_permisos = {
    'Administrador': ['eliminar-libros', 'ver-libros'],
    'Bibliotecario': ['eliminar-libros', 'ver-libros'],
    'Egresado' : ['ver-libros']
}


@app.app.route('/')
def index():
    """
    Renderizar la página principal
    """
    return render_template('index.html')


@app.app.route('/login')
def login():
    """
    Renderizar la página de inicio de sesión
    """
    return render_template('login.html')


@app.app.route('/login_user', methods=['POST', 'GET'])
def login_user():
    """
    Desarrollar el inicio de sesión de los usuarios
    """
    if request.method == 'POST':
        username = request.form.get('usuario')
        contrasenia = request.form.get('contraseña')
        rol = request.form.get('rol')
        resultado_login = sesiones_usuarios.iniciar_sesion_de_usuario(
            username, contrasenia, rol)
        if resultado_login:
            if session['rol_usuario'] == 'Administrador':
                return redirect(url_for('admin_dash'))
            else:
                pass
        else:
            return render_template('login.html', mensaje_error="El inicio de sesión ha sido incorrecto")


@app.app.route('/logout_user')
@login_required
def logout_user():
    """
    Cierre de la sesión del usuario que ha iniciado sesión
    """
    sesiones_usuarios.cierre_de_sesion_de_usuario()
    return redirect(url_for('login'))


@app.app.route('/admin_dash')
@login_required
def admin_dash():
    """
    Renderizar la página index del administrador
    """
    if session['rol_usuario'] == 'Administrador':
        return render_template('admin_dashboard.html')
    else:
        return redirect('/logout_user')


@app.app.route('/Personal_Info')
@login_required
def render_personal_info():
    if session['rol_usuario'] == 'Administrador' or session['rol_usuario'] == 'Egresado':
        return render_template('egresadosDatosPerso.html')
    else:
        return redirect('/logout_user')

# ----------------------------- Egresados ----------------------------------------


@app.app.route('/informacion_personal_egresados/<int:id>')
@login_required
def render_info_personal_egr(id):
    if session['rol_usuario'] == "Egresado":
        lista_info = egr.egr_info.ejecutar_pass_info_egr(
            id, 'ver_datos_personales')
        if lista_info[0] == 0:
            return render_template('informacion_personal_egresados.html',
                                   info=lista_info[1])
        else:
            return render_template('informacion_personal_egresados.html',
                                   mensaje="Los datos solicitados no puedieron ser encontrados.")
    if session['rol_usuario'] == "Administrador":
        lista_info = egr.egr_info.ejecutar_pass_info_egr(
            id=0, nombre_proc='ver_datos_personales')
        if lista_info[0] == 0:
            return render_template('informacion_personal_egresados.html',
                                   info=lista_info)
        else:
            return render_template('informacion_personal_egresados.html',
                                   mensaje="Los datos solicitados no puedieron ser encontrados.")


@app.app.route('/egresados')
def render_inicioEgreados():
    return render_template('egresadosIndex.html')


@app.app.route('/egresados/DatosPersonales')
def render_PersonalEgreados():
    return render_template('egresadosDatosPerso.html')


@app.app.route('/egresados/convocatorias')
def render_convocaEgreados():
    return render_template('egresadosConvocatorias.html')
# ----------------------------- bibliotecario ----------------------------------------


@app.app.route('/bibliotecario')
def render_inicioBiblio():
    return render_template('biblioIndex.html')


# ----------------bibliotecario - libros
@app.app.route('/bibliotecario/libros/eliminar')
@login_required
def eliminar_libro():
    if 'eliminar-libros' in tabla_permisos[session['rol_usuario']]:
        id_libro = request.args.get('id')
        resultado = biblio.acciones_libros.delete_book(id_libro)
        return resultado[1]
    else:
        return redirect('/logout_user')


@app.app.route('/bibliotecario/libros', methods=['POST', 'GET'])
@login_required
def render_libros():
    if 'ver-libros' in tabla_permisos[session['rol_usuario']]:
        info_libros = biblio.acciones_libros.read_book()
        if info_libros[0] == 1:
            return render_template('biblioLibros.html', mensaje=info_libros[1])
        else:
            return render_template('biblioLibros.html', datos_libros=info_libros[1])
    else:
        return redirect('/logout_user')


@app.app.route('/bibliotecario/libros/crear')
@login_required
def crear_libro():
    id_libro = request.args.get('id')
    titulo = request.args.get('titulo')
    biblioteca = request.args.get('biblioteca')
    autor = request.args.get('autor')
    estante = request.args.get('estante')
    resultado = biblio.acciones_libros.create_book(id_libro,
                                       titulo,
                                       biblioteca,
                                       autor,
                                       estante)
    return resultado[1]

# ----------------bibliotecario - prestamo

# @app.app.route('/bibliotecario/prestamo/eliminar')
# @login_required
# def eliminar_prestamo():
#     documento = request.args.get('documento')
#     id_libro = request.args.get('id_libro')
#     resultado = biblio.acciones_prestamo.delete_loan(documento, id_libro)
#     return resultado[1]


@app.app.route('/bibliotecario/prestamo', methods=['POST', 'GET'])
@login_required
def render_prestamo():
    info_prestamos = biblio.acciones_prestamo.read_loan()
    if info_prestamos[0] == 1:
        return render_template('biblioPrestamo.html', mensaje=info_prestamos[1])
    else:
        return render_template('biblioPrestamo.html', prestamos=info_prestamos[1])


@app.app.route('/bibliotecario/prestamo/crear')
@login_required
def crear_prestamo():
    documento = int(request.args.get('documento'))
    id_libro = int(request.args.get('id_libro'))
    insercion_resultado = biblio.acciones_prestamo.create_loan(documento, id_libro)
    print(insercion_resultado[1])
    return insercion_resultado[1]

# ----------------------------- empresa ----------------------------------------
@app.app.route('/empresa')
def render_empresa():
    return render_template('empresaBase.html')


@app.app.route('/empresa/convocatorias')
def render_convocatorias():
    return render_template('empresaConvocatorias.html')


@app.app.route('/empresa/aplicantes')
def render_aplicantes():
    return render_template('empresaAplicantes.html')

# ----------------------------- pregrado ----------------------------------------


@app.app.route('/pregrado')
def render_pregrado():
    return render_template('pregradoBase.html')


@app.app.route('/pregrado/asesoria')
def render_asesoria():
    return render_template('pregradoAsesoria.html')


if __name__ == '__main__':
    app.app.run(port=5010)
