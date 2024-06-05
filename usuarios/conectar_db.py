import mysql.connector
import time
from flask import current_app, g
import pymysql
import pymysql.cursors

def conexion():
    start_time =time.time()
    mydb = mysql.connector.connect(
      host="127.0.0.1",
      port="3306",
      user="root",
      password="", 
      database = "egresado_db")
    end_time = time.time()
    return mydb


def conexion_base_de_datos():
    connection = pymysql.connect(
        host = '127.0.0.1',
        port = 3306,
        user = 'root',
        password = '',
        database = 'egresado_db',
        cursorclass = pymysql.cursors.DictCursor 
    )
    return connection