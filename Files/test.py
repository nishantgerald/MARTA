import pymysql.cursors
from flask import Flask, session, redirect, url_for, escape, request, render_template
import json

from flask import Flask
app = Flask(__name__, template_folder='template')
# Connect to the database


@app.route('/')
def index():
    return render_template('/s01_login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='Beltline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    if "login" in request.form:
        username = request.form['username']
        password = request.form['password']

        try:
            with open('MARTA.sql', 'r') as sql:
                procs = sql.read().split(';')
                with connection.cursor() as cursor:
                    
                 # Read a single record
                    result = cursor.execute("SELECT Username FROM emails WHERE Email = %s;", [username])
                    user_result = cursor.fetchone()
                    return json.dumps(user_result)
                    #EVERYTHING UNTIL THIS POINT WORKS-----------------
                #if user_result:
                #    with connection.cursor() as cursor2:
                #        pass_result = cursor.execute("SELECT UserType FROM user WHERE Username in SELECT Username FROM emails WHERE Email = %s) AND Password = %s;", [username, password])
                #        return json.dumps(cursor.fetchone())
                #else:
                #    return "ERROR: Invalid Username"

        except:
            return "ERROR"
            
        finally:
            connection.close()
    elif "register" in request.form:
        return render_template('s02_registerNavigation.html')

@app.route('/register_navigation', methods=['GET', 'POST'])
def register_navigation():
    if "user_only" in request.form:
        return render_template('s03_registerUserOnly.html')
    elif "visitor_only" in request.form:
        return render.template('s04_registerVisitorOnly.html')
    elif "employee_only" in request.form:
        return render.template('s05_registerEmployeeOnly.html')
    elif "employee_visitor" in request.form:
        return render.template('s06_registerEmployeeVisitor.html')
    elif "back" in request.form:
        return render.template('s01_login.html')    

if __name__ == '__main__':
    app.run(debug=True)