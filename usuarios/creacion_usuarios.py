import conectar_db as connect
from werkzeug.security import generate_password_hash

coneccion = connect.conexion()
cursor = coneccion.cursor()

cursor.execute("""
    CREATE TABLE IF NOT EXISTS Usuarios(
	usr_documento INT NOT NULL PRIMARY KEY, 
    usr_username VARCHAR(45) NOT NULL, 
    usr_password TEXT, 
    usr_role VARCHAR(45)
);
""")

documento = input('Ingrese el número de documento de identidad: ')
username = input('Ingrese el nombre de usuario: ')
password = input('Ingrese la contraseña: ')
user_password = generate_password_hash(password)

query_existencia_documento = 'SELECT * FROM Usuarios WHERE usr_documento = %s;'

query_existencia_nombre_de_usuario = 'SELECT * FROM Usuarios WHERE usr_username = %s;'
cursor.execute(query_existencia_nombre_de_usuario, [username])
if cursor.fetchone():
    raise ValueError(
        "El nombre de usuario ya se encuentra registrado en la base de datos.")


cursor.execute("INSERT INTO Usuarios VALUES(%s,%s,%s,'Administrador');",
               (documento, username, user_password))
coneccion.commit()
cursor.close()
