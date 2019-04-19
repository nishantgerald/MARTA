import pymysql.cursors
from flask import Flask, session, redirect, url_for, escape, request, render_template
import json

from flask import Flask
app = Flask(__name__, template_folder='template')
# Connect to the database


@app.route('/')
def index():
    return render_template('/login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='Beltline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    username = request.form['username']
    password = request.form['password']

    try:
        with open('MARTA.sql', 'r') as sql:
            procs = sql.read().split(';')
            with connection.cursor() as cursor:
                #EVERYTHING UNTIL THIS POINT WORKS-----------------
             # Read a single record
                result = cursor.execute("SELECT * FROM user")
                return json.dumps(result)
                

    except:
        return "ERROR"
        
    finally:
        connection.close()

if __name__ == '__main__':
    app.run(debug=True)