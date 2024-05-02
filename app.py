from flask import Flask, render_template

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
