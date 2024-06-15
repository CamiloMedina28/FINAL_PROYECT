#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
Manejo de todas las funcionalidades del programa
"""
from flask import redirect, render_template, request, url_for
from flask_login import login_required
import localsettings as app
from flask import session
from pymongo import MongoClient
import egresados as egr
import biblio_acciones as biblio
import pregra_acciones as pregrado
import usuarios
import egresado_acciones as egresado

app.instanciate_app(__name__)
client = MongoClient("mongodb://root:root@my_mongo_db:27017/")
db = client['mongo']

tabla_permisos = {
    'Administrador': ['eliminar-libros', 'ver-libros', 'ver-pregrado', 'inicio-bibliotecario', 'ver-solicitudes-acceso'],
    'Bibliotecario': ['eliminar-libros', 'ver-libros', 'inicio-bibliotecario', 'crear-prestamo'],
    'Egresado': ['ver-libros', 'ver-asesoria'],
    'Pregrado': ['ver-pregrado']
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
        resultado_login = usuarios.sesiones_usuarios.iniciar_sesion_de_usuario(
            username, contrasenia, rol)
        if resultado_login:
            if session['rol_usuario'] == 'Administrador':
                return redirect(url_for('admin_dash'))
            elif session['rol_usuario'] == 'Egresado':
                return redirect(url_for('render_inicioEgreados'))
            elif session['rol_usuario'] == 'Bibliotecario':
                return redirect(url_for('render_inicioBiblio'))
            elif session['rol_usuario'] == 'Pregrado':
                return redirect(url_for('render_pregrado'))
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
    usuarios.sesiones_usuarios.cierre_de_sesion_de_usuario()
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


@app.app.route('/informacion_personal_egresados')
@login_required
def render_info_personal_egr():
    if session['rol_usuario'] == "Egresado":
        info = egresado.informacion_egresado.retrieve_informacion_personal(session['doc_usuario'])
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_personal()
    return render_template('informacion_personal_egresados.html', datos_egresados = info)


@app.app.route('/informacion_contacto_egr')
@login_required
def render_info_contacto():
    if session['rol_usuario'] == "Egresado":
        info = egresado.informacion_egresado.retrieve_informacion_contacto(session['doc_usuario'])
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_contacto()
    return render_template('contacto.html', datos_contacto = info)


@app.app.route('/informacion_familiar')
@login_required
def render_informacion_familiar():
    if session['rol_usuario'] == "Egresado":
        info = egresado.informacion_egresado.retrieve_datos_familiares(session['doc_usuario'])
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_datos_familiares()
    return render_template('info_familiar.html', datos_familia= info)


@app.app.route('/info_residencia')
@login_required
def render_info_residencia():
    if session['rol_usuario'] == "Egresado":
        info = egresado.informacion_egresado.retrieve_informacion_residencia_egresado(session['doc_usuario'])
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_residencia_egresado()
    return render_template('informacion_residencia.html', datos_residencia= info)


@app.app.route('/distinciones')
@login_required
def render_distinciones():
    if session['rol_usuario'] == "Egresado":
        info = egresado.informacion_egresado.retrieve_informacion_distinciones(session['doc_usuario'])
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_distinciones()
    return render_template('distinciones.html', datos_distinciones= info)


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
@login_required
def render_inicioBiblio():
    if 'inicio-bibliotecario' in tabla_permisos[session['rol_usuario']]:
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


@app.app.route('/egresados/prestamo', methods=['POST', 'GET'])
@app.app.route('/bibliotecario/libros', methods=['POST', 'GET'])
@login_required
def render_libros():
    if session['rol_usuario'] == 'Bibliotecario':

        info_libros = biblio.acciones_libros.read_book(0)
        if info_libros[0] == 1:
            return render_template('biblioLibros.html', mensaje=info_libros[1])
        else:
            return render_template('biblioLibros.html', datos_libros=info_libros[1],  eliminar=1)
    elif session['rol_usuario'] == 'Egresado':
        estudiante = session['doc_usuario']
        info_libros = biblio.acciones_libros.read_book(estudiante)
        if info_libros[0] == 1:
            return render_template('egresadosLibros.html', mensaje=info_libros[1])
        else:
            return render_template('egresadosLibros.html', datos_libros=info_libros[1], libros_prestados=info_libros[2], solicitar=1)
    else:
        return redirect('/logout_user')


@app.app.route('/ver-solicitudes-acceso')
@login_required
def render_solicitudes():
    if 'ver-solicitudes-acceso' in tabla_permisos[session['rol_usuario']]:
        usuarios_por_autorizar = usuarios.admin_users.usuarios_por_autorizar()
        print(usuarios_por_autorizar)
        return render_template('listar_usuarios_autorizar.html', usuarios_por_autorizar=usuarios_por_autorizar)
    else:
        pass


@app.app.route('/autorizar_usuario')
@login_required
def auth_user():
    documento = request.args.get('documento')
    resultados = usuarios.admin_users.autorizar_usuario(documento)
    return resultados


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


@app.app.route('/bibliotecario/prestamo', methods=['POST', 'GET'])
@login_required
def render_prestamo():
    info_prestamos = biblio.acciones_prestamo.read_loan()
    if info_prestamos[0] == 1:
        return render_template('biblioPrestamo.html', mensaje=info_prestamos[1])
    else:
        return render_template('biblioPrestamo.html', prestamos=info_prestamos[1])


@app.app.route('/egresados/prestamo/crear')
@app.app.route('/bibliotecario/prestamo/crear')
@login_required
def crear_prestamo():
    if session['rol_usuario'] == 'Bibliotecario':
        documento = int(request.args.get('documento'))
        id_libro = int(request.args.get('id_libro'))
        insercion_resultado = biblio.acciones_prestamo.create_loan(
            documento, id_libro)
        return insercion_resultado[1]
    elif session['rol_usuario'] == 'Egresado':
        documento = session['doc_usuario']
        id_libro = int(request.args.get('id_libro'))
        print(id_libro)
        insercion_resultado = biblio.acciones_prestamo.create_loan(
            documento, id_libro)
        print(insercion_resultado)
        return insercion_resultado[1]
    else:
        return redirect('/logout_user')

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
    return render_template('pregradoIndex.html')


@app.app.route('/pregrado/asesoria/<int:id>', methods=['POST', 'GET'])
@app.app.route('/egresados/asesoria/<int:id>', methods=['POST', 'GET'])
@login_required
def render_asesoria(id):
    if session['rol_usuario'] == 'Pregrado':
        info_pregrado = pregrado.pregrado_acciones.read_student(id)
        if info_pregrado[0] == 1:
            return render_template('pregradoAsesoria.html', mensaje=info_pregrado[1])
        else:
            if len(info_pregrado[1]) == 0:
                return render_template('pregradoAsesoria.html')
            else:
                return render_template('pregradoAsesoria.html', datos_pregrado=info_pregrado[1])

    elif session['rol_usuario'] == 'Egresado':
        info_pregrado = pregrado.pregrado_acciones.read_student(0)
        if info_pregrado[0] == 1:
            return render_template('egresadosAsesoria.html', mensaje=info_pregrado[1])
        else:
            return render_template('egresadosAsesoria.html', datos_pregrados=info_pregrado[1])

    else:
        return redirect('/logout_user')


@app.app.route('/egresados/asesoria/crear')
def render_asesoria_crear():
    if 'ver-asesoria' in tabla_permisos[session['rol_usuario']]:
        documento_egresado = session['doc_usuario']
        documento_pregrado = request.args.get('documento_pregrado')
        solicitud = request.args.get('solicitud')
        resultado = pregrado.pregrado_acciones.add_consulting(
            documento_egresado, documento_pregrado, solicitud)
        return resultado[1]
    else:
        return redirect('/logout_user')


@app.app.route('/registrarse', methods=['GET', 'POST'])
def registrarse_en_sistema():
    if request.method == 'POST':
        rol = request.form.get('rol')
        identificacion = request.form.get('identificacion')
        nombre = request.form.get('nombre')
        password = request.form.get('contrasenia')
        try:
            resultado = usuarios.creacion_usuarios.create_temporal_user(
                rol, int(identificacion), nombre, password)
            return render_template('registrarse_en_sistema.html', mensaje=resultado)
        except Exception as error:
            return render_template('registrarse_en_sistema.html', mensaje="Error al registrarse, revise argumentos")
    else:
        return render_template('registrarse_en_sistema.html')


if __name__ == '__main__':
    app.app.run(port=5010)
