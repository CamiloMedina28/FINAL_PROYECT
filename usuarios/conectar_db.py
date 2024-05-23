import mysql.connector

def conexion():
    mydb = mysql.connector.connect(
      host="127.0.0.1",
      port="5000",
      user="root",
      password="root", 
      database = "egresado_db"
    )

    return mydb


def cerrar_conexion(mydb):
    mydb.close()

