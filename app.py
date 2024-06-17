#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
Manejo de todas las funcionalidades del programa
"""
from flask import redirect, render_template, request, url_for, jsonify
from flask_login import login_required
import localsettings as app
from flask import session
import egresados as egr
import biblio_acciones as biblio
import pregra_acciones as pregrado
import empresa_acciones as emp
import usuarios
from datetime import datetime
from flask_mail import Mail, Message
import egresado_acciones as egresado

app.instanciate_app(__name__)

tabla_permisos = {
    'Administrador': [
        'eliminar-libros', 'ver-libros', 'ver-pregrado', 'inicio-bibliotecario',
        'ver-solicitudes-acceso', 'ver-convocatorias', 'eliminar-convo',
        'read-apli', 'update-apli'],
    'Bibliotecario': ['eliminar-libros', 'ver-libros', 'inicio-bibliotecario', 'crear-prestamo'],
    'Egresado': ['ver-libros', 'ver-asesoria'],
    'Pregrado': ['ver-pregrado'],
    'Empresa': ['ver-convocatorias', 'eliminar-convo', 'update-apli']
}

# Configuración de Flask-Mail
app.app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.app.config['MAIL_PORT'] = 587
app.app.config['MAIL_USE_TLS'] = True
app.app.config['MAIL_USE_SSL'] = False
app.app.config['MAIL_USERNAME'] = 'sie.unal.bogota@gmail.com'
app.app.config['MAIL_PASSWORD'] = 'hjlic2746'
app.app.config['MAIL_DEFAULT_SENDER'] = 'sie.unal.bogota@gmail.com'

mail = Mail(app.app)


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
@app.app.route('/egresados')
def render_inicioEgreados():
    return render_template('egresadosIndex.html')

# INFO PERSONAL -----------------------------------
@app.app.route('/informacion_personal_egresados')
@login_required
def render_info_personal_egr():
    if session['rol_usuario'] == "Egresado":
        info = []
        info.append(egresado.informacion_egresado.retrieve_informacion_personal(
            session['doc_usuario']))
    elif session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_personal()
    return render_template('informacion_personal_egresados.html', datos_egresados=info)

# Ver detalles info personal egresado
@app.app.route('/informacion_personal_egresados/<int:id_egre>', methods=['POST', 'GET'])
@login_required
def detail_info_personal_egr(id_egre: int):
    if session['rol_usuario'] == "Egresado":
        datos_egresados = []
        datos_egresados.append(
            egresado.informacion_egresado.retrieve_informacion_personal(
            session['doc_usuario']))
    elif session['rol_usuario'] == "Administrador":
        datos_egresados = egresado.informacion_egresado.retrieve_informacion_personal()
    else:
        return redirect('/logout_user')
    for egre in datos_egresados:
        if (int(egre['egr_numero_de_identificacion']) == id_egre):
            convo_to_update = egre
            break
    nombres_display = [
    "Número de Identificación", "Primer Nombre", "Primer Apellido", "Segundo Apellido",
    "Sexo", "Estrato", "Grupo Étnico", "Estado Civil", "Discapacidad", "Admisión Especial",
    "Víctima del Conflicto Armado", "Tipo de Identificación", "País de Nacimiento",
    "Departamento de Nacimiento", "Municipio de Nacimiento", "Segundo Nombre"]
    convo_to_update = list(convo_to_update.values())
    toDisplay = list(zip(nombres_display, convo_to_update))
    return render_template('info_egre_ConDetail.html', datos_convo=toDisplay)

# Update Info personal egresados
@app.app.route('/agregar-info-personal_egresados')
@login_required
def agregar_informacion_personal_egresado():
    num_id = request.args.get('num_id')
    prim_nom = request.args.get('prim_nom')
    prim_ape = request.args.get('prim_ape')
    seg_ape = request.args.get('seg_ape')
    sexo = request.args.get('sexo')
    estrato = request.args.get('estrato')
    grupo_etn = request.args.get('grupo_etn')
    est_civil = request.args.get('est_civil')
    discap = request.args.get('discap')
    adm_esp = request.args.get('adm_esp')
    vict_conf = request.args.get('vict_conf')
    tipo_id = request.args.get('tipo_id')
    pais_nac = request.args.get('pais_nac')
    depto_nac = request.args.get('depto_nac')
    mun_nac = request.args.get('mun_nac')
    seg_nom = request.args.get('seg_nom')

    existe = egresado.informacion_egresado.existe_info_egresado(num_id)
    accion = 2 if existe else 1
    info = egresado.informacion_egresado.agregar_info_egresado(
        accion, num_id, prim_nom, prim_ape, seg_ape, sexo, estrato, grupo_etn,
        est_civil, discap, adm_esp, vict_conf, tipo_id, pais_nac, depto_nac,
        mun_nac, seg_nom)
    return info

@app.app.route('/eliminar_egresado')
@login_required
def eliminar_egresado():
    id_egresado = request.args.get('id_egresado')
    if session['rol_usuario'] in ('Egresado', 'Administrador'):
        info = egresado.informacion_egresado.eliminar_info_egresado(
            'borrar_egresado', id_egresado)
        return info

# CONTACTO EGRESADO ------------------------------------------------
@app.app.route('/informacion_contacto_egr')
@login_required
def render_info_contacto():
    if session['rol_usuario'] == "Egresado":
        info = []
        info.append(egresado.informacion_egresado.retrieve_informacion_contacto(
            session['doc_usuario']))
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_contacto()
    return render_template('contacto.html', datos_contacto=info)


@app.app.route('/agregar-info-contacto')
@login_required
def agregar_informacion_contacto_egresado():
    documento = request.args.get('documento')
    telefono_principal = request.args.get('telefono-principal')
    correo_principal = request.args.get('correo')
    telefono_adicional = request.args.get('telefono-adicional')
    correo_adicional = request.args.get('correo-adicional')
    existe = egresado.informacion_egresado.existe_info_contacto(documento)
    accion = 2 if existe else 1
    info = egresado.informacion_egresado.agregar_info_contacto(accion,
                                                               documento, telefono_principal, correo_principal, telefono_adicional, correo_adicional)
    print(info)
    return info

# FAMILIAR -----------------------------------------------------
@app.app.route('/informacion_familiar')
@login_required
def render_informacion_familiar():
    if session['rol_usuario'] == "Egresado":
        info = []
        info.append(egresado.informacion_egresado.retrieve_datos_familiares(
            session['doc_usuario']))
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_datos_familiares()
    return render_template('info_familiar.html', datos_familia=info)

@app.app.route('/eliminar_familiar')
@login_required
def eliminar_familiar():
    id_egresado = request.args.get('id_egresado')
    if session['rol_usuario'] in ('Egresado', 'Administrador'):
        info = egresado.informacion_egresado.eliminar_info_egresado(
            'borrar_hijos_egresado_datos', id_egresado)
        return info

@app.app.route('/agregar-informacion-familiar')
@login_required
def agregar_familiar():
    documento = request.args.get('documento')
    docmento_hijo = request.args.get('docmento_hijo')
    nombre_hijo = request.args.get('nombre_hijo')
    pri_ape_hijo = request.args.get('pri_ape_hijo')
    seg_ape_hijo = request.args.get('seg_ape_hijo')
    anio_nacimiento_hijo = request.args.get('anio_nacimiento_hijo')
    direccion_residencia_hijo = request.args.get('direccion_residencia_hijo')
    existe = egresado.informacion_egresado.existe_info_familiar(documento)
    accion = 2 if existe else 1
    info = egresado.informacion_egresado.agregar_info_familiar(
        accion, docmento_hijo, nombre_hijo, 
        pri_ape_hijo, seg_ape_hijo, anio_nacimiento_hijo,
        direccion_residencia_hijo)
    print(info)
    return info

# RESIDENCIA -----------------------------   
@app.app.route('/info_residencia')
@login_required
def render_info_residencia():
    if session['rol_usuario'] == "Egresado":
        info = []
        info.append(egresado.informacion_egresado.retrieve_informacion_residencia_egresado(
            session['doc_usuario']))
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_residencia_egresado()
    return render_template('informacion_residencia.html', datos_residencia=info)

@app.app.route('/eliminar_residencia')
@login_required
def eliminar_residencia():
    id_egresado = request.args.get('id_egresado')
    if session['rol_usuario'] in ('Egresado', 'Administrador'):
        info = egresado.informacion_egresado.eliminar_info_egresado(
            'borrar_residencia_datos', id_egresado)
        return info

@app.app.route('/agregar-info-residencia')
@login_required
def agregar_informacion_residencia_egresado():

    documento = request.args.get('documento')
    pais = request.args.get('pais')
    departamento = request.args.get('departamento')
    municipio = request.args.get('municipio')
    ciudad = request.args.get('ciudad')
    direccion = request.args.get('direccion')
    existe = egresado.informacion_egresado.existe_info_residencia(documento)
    accion = 2 if existe else 1
    info = egresado.informacion_egresado.agregar_info_residencia
    (accion,documento, pais, departamento, 
    municipio, ciudad, direccion)
    print(info)
    return info

# DISTINCIONES -----------------------------

@app.app.route('/distinciones')
@login_required
def render_distinciones():
    if session['rol_usuario'] == "Egresado":
        info = []
        info.append(egresado.informacion_egresado.retrieve_informacion_distinciones(
            session['doc_usuario']))
    if session['rol_usuario'] == "Administrador":
        info = egresado.informacion_egresado.retrieve_informacion_distinciones()
    return render_template('distinciones.html', datos_distinciones=info)


@app.app.route('/eliminar_distincion')
@login_required
def eliminar_distincion():
    id_egresado = request.args.get('id_egresado')
    if session['rol_usuario'] in ('Egresado', 'Administrador'):
        info = egresado.informacion_egresado.eliminar_info_egresado(
            'borrar_distincion_datos', id_egresado)
        return info

@app.app.route('/agregar-info-distincion')
@login_required
def agregar_distincion():
    documento = request.args.get('documento')
    anio = request.args.get('anio')
    nombre_distincion = request.args.get('nombre_distincion')
    descripcion = request.args.get('descripcion')
    existe = egresado.informacion_egresado.existe_info_distincion(documento)
    accion = 2 if existe else 1
    info = egresado.informacion_egresado.agregar_info_distincion
    (accion,documento, anio, nombre_distincion, descripcion)
    print(info)
    return info

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
    if session['rol_usuario'] in ('Bibliotecario', 'Administrador'):
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
@login_required
def render_empresa():
    return render_template('empresaIndex.html')

# ------------------------- Convocatorias

# Vista rapida convocatorias


@app.app.route('/empresa/convocatorias', methods=['POST', 'GET'])
@login_required
def render_convo_short():
    if 'ver-convocatorias' in tabla_permisos[session['rol_usuario']]:
        pas = "emp_vista_convocatorias"
        id_empresa = session['doc_usuario']
        info_convo = emp.convo_acciones.read_all_convo(pas, id_empresa)
        if info_convo[0] == 1:
            return render_template('empresaConvocatorias.html', mensaje_error=info_convo[1])
        else:
            return render_template('empresaConvocatorias.html', datos_convo=info_convo[1])
    else:
        return redirect('/logout_user')

# Ver detalles convocatoria
@app.app.route('/empresa/convo-info/<int:id_convo>', methods=['POST', 'GET'])
@login_required
def detail_convo(id_convo: int):
    if 'ver-convocatorias' in tabla_permisos[session['rol_usuario']]:
        pas = "emp_vista_convocatorias"
        id_empresa = session['doc_usuario']
        info_convo = emp.convo_acciones.read_all_convo(pas,id_empresa)
        for convo in info_convo[1]:
            if (int(convo['con_id']) == id_convo):
                convo_to_update = convo
                break
        nombres_display = [
            "ID","ID de la Empresa","Nombre del Cargo","Habilidades",
            "Competencias", "Meses de Experiencia", "Número de Vacantes",
            "Salario", "Jornada de Trabajo", "Horario de Trabajo",
            "Teletrabajo","País","Ciudad","Fecha de Convocatoria",
            "Fecha de Expiración"]
        convo_to_update = list(convo_to_update.values())
        toDisplay = list(zip(nombres_display, convo_to_update))
        for con in toDisplay:
            print(con)
        if info_convo[0] == 1:
            return render_template('empresaConDetail.html', mensaje_error=info_convo[1])
        else:
            return render_template('empresaConDetail.html', datos_convo=toDisplay)
    else:
        return redirect('/logout_user')


# Eliminar convocatoria
@app.app.route('/empresa/convocatorias/eliminar')
@login_required
def eliminar_convo():
    if 'eliminar-convo' in tabla_permisos[session['rol_usuario']]:
        pas = "borrar_convocatoria_datos"
        id_empresa = session['doc_usuario']
        id_convo = request.args.get('id')
        resultado = emp.convo_acciones.RD_convo(pas, id_convo, id_empresa)
        return resultado[1]
    else:
        return redirect('/logout_user')

# Ver todas aplicadas
@app.app.route('/empresa/aplicadas/<int:id_convo>', methods=['POST', 'GET'])
@login_required
def all_apli(id_convo):
    if 'read-apli' in tabla_permisos[session['rol_usuario']]:
        pas = "emp_aplicadas_convocatorias"
        id_empresa = session['doc_usuario']
        info_apli = emp.convo_acciones.R_convo(pas, id_convo, id_empresa)
        if info_apli[0] == 1:
            return render_template('empresaAplicantes.html', mensaje_error=info_apli[1])
        else:
            return render_template('empresaAplicantes.html', datos_apli=info_apli[1])
    else:
        return redirect('/logout_user')

# Ver detalles aplicate
# @app.app.route('/empresa/egresadp-info/<int:id_convo>', methods=['POST', 'GET'])
# @login_required
# def all_apli(id_convo):
#     if 'read-apli' in tabla_permisos[session['rol_usuario']]:
#         pas = "emp_aplicadas_convocatorias"
#         id_empresa = session['doc_usuario']
#         info_apli = emp.convo_acciones.R_convo(pas ,id_convo, id_empresa)
#         if info_apli[0] == 1:
#             return render_template('empresaAplicantes.html', mensaje_error=info_apli[1])
#         else:
#             return render_template('empresaAplicantes.html', datos_apli=info_apli[1])
#     else:
#         return redirect('/logout_user')


@app.app.route('/empresa/aplicadas/update')
@login_required
def update_apli():
    if 'update-apli' in tabla_permisos[session['rol_usuario']]:
        id_con = request.args.get('id_con')
        id_emp = session['doc_usuario']
        id_egr = request.args.get('id_egr')
        estado = request.args.get('estado')
        resultado = emp.convo_acciones.U_apli(id_con, id_emp, id_egr, estado)
        if (estado == 'ACEPTADA'):
            try:
                msg = Message("Hola desde Flask",
                            recipients=["jaredmijail32@gmail.com"])
                msg.body = "Este es el cuerpo del mensaje."
                msg.html = "<b>Este es el cuerpo del mensaje en HTML</b>"
                mail.send(msg)
                print("correo enviado")
                return ("Correo enviado! " + resultado[1])
            except Exception as e:
                return str(e)
        return resultado[1]
    else:
        return redirect('/logout_user')


# Crear convocatori
@app.app.route('/empresa/convocatorias/crear')
@login_required
def crear_convoca():
    empresa_id = session['doc_usuario']
    cargo = request.args.get('cargo')
    habilidades = request.args.get('habilidades')
    competencias = request.args.get('competencias')
    experiencia = request.args.get('experiencia')
    vacantes = request.args.get('vacantes')
    salario = request.args.get('salario')
    jornada = request.args.get('jornada')
    horario = request.args.get('horario')
    teletrabajo = request.args.get('teletrabajo')
    pais = request.args.get('pais')
    ciudad = request.args.get('ciudad')
    fechaIN = datetime.today().date()
    fechaOUT = request.args.get('fechaOUT')
    resultado = emp.convo_acciones.create_convo(
        empresa_id, cargo, habilidades,
        competencias, experiencia, vacantes,
        salario, jornada, horario,
        teletrabajo, pais, ciudad,
        fechaIN, fechaOUT
    )
    return resultado[1]

# ------------------------- Aplicantes


@app.app.route('/empresa/aplicantes')
@login_required
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
            return render_template('empresaConDetail.html', mensaje=info_pregrado[1])
        else:
            return render_template('empresaConDetail.html', datos_pregrados=info_pregrado[1])

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
