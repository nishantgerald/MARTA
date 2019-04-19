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
                
             # Read a single record
                result = cursor.execute("SELECT Username FROM emails WHERE Email = %s;", [username])
                user_result = cursor.fetchone()
                #EVERYTHING UNTIL THIS POINT WORKS-----------------
            if user_result:
                with connection.cursor() as cursor2:
                    pass_result = cursor.execute("SELECT UserType FROM user WHERE Username in SELECT Username FROM emails WHERE Email = %s) AND Password = %s;", [username, password])
                    return json.dumps(cursor.fetchone())
            else:
                return "ERROR: Invalid Username"

    except:
        return "ERROR"
        
    finally:
        connection.close()

if __name__ == '__main__':
    app.run(debug=True)