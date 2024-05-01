from db_proccess import ejecutar_query

class User:
    def __init__(self, id) -> None:
        self.id = id
    
    def info(self):
        pass

def login():
    value = ejecutar_query("SELECT * FROM users WHERE ID = ?", (1212, ))
    print(value)
    pass

def logout():
    pass

def create_user(*args):
    pass

login()