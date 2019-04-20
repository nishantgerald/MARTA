import pymysql.cursors
from flask import Flask, session, redirect, url_for, escape, request, render_template, jsonify
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
                    cursor.callproc('s01_user_login_check_email', [username])
                    user_result = str(json.dumps(cursor.fetchone()))[-2]
                    #EVERYTHING UNTIL THIS POINT WORKS-----------------
                if user_result == '1':
                    with connection.cursor() as cursor2:
                        cursor2.callproc('s01_user_login_check_password', [username, password])
                        pass_result = cursor2.fetchall()
                        output = [row for row in pass_result]
                        user_type = output[0]["UserType"]
                else:
                    return "ERROR: Invalid Username"

                if user_type == "Employee":
                    with connection.cursor() as cursor3:
                        cursor3.callproc('s01_employee_check_type', [username])
                        employee_result = cursor3.fetchall()
                        output = [row for row in pass_result]
                        employee_type = output[0]["EmployeeType"]
                    if employee_type == "Admin":
                        render_template('s08_adminFunctionality.html')
                    elif employee_type == "Manager":
                        render_template('s10_managerFunctionality.html')
                    elif employee_type == "Staff":
                        render_template('s12_staffFunctionality.html')
                elif userType == "Employee, Visitor":
                    with connection.cursor() as cursor3:
                        cursor3.callproc('s01_employee_check_type', [username])
                        employee_result = cursor3.fetchall()
                        output = [row for row in pass_result]
                        employee_type = output[0]["EmployeeType"]
                    if employee_type == "Admin":
                        render_template('s09_adminVisitorFunctionality.html')
                    elif employee_type == "Manager":
                        render_template('s11_managerVisitorFunctionality.html')
                    elif employee_type == "Staff":
                        render_template('s13_staffVisitorFunctionality.html')
                elif user_type == "Visitor":
                    render_template('s14_visitorFunctionality')
                elif user_type == "User":
                    render_template('s07_userFunctionality')

        except Exception as e:
            print(e)
            return str(e)
            
        finally:
            connection.close()
    elif "register" in request.form:
        return render_template('s02_registerNavigation.html')

@app.route('/register_navigation', methods=['GET', 'POST'])
def register_navigation():
    if "user_only" in request.form:
        return render_template('s03_registerUserOnly.html')
    elif "visitor_only" in request.form:
        return render_template('s04_registerVisitorOnly.html')
    elif "employee_only" in request.form:
        return render_template('s05_registerEmployeeOnly.html')
    elif "employee_visitor" in request.form:
        return render_template('s06_registerEmployeeVisitor.html')
    elif "back" in request.form:
        return render_template('s01_login.html')    

if __name__ == '__main__':
    app.run(debug=True)