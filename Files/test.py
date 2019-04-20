import pymysql.cursors
from flask import Flask, session, redirect, url_for, escape, request, render_template, jsonify
import json

from flask import Flask
app = Flask(__name__, template_folder='template')

user_email = ""
user_type = ""
employee_type = ""
username = ""
# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='Beltline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

@app.route('/')
def index():
    return render_template('/s01_login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if "login" in request.form:
        user_email = request.form['username']
        password = request.form['password']

        try:
            with open('MARTA.sql', 'r') as sql:
                procs = sql.read().split(';')
                with connection.cursor() as cursor:

                # Read a single record
                    cursor.callproc('s01_user_login_check_email', [user_email])
                    user_result = str(json.dumps(cursor.fetchone()))[-2]
                    
                if user_result == '1':
                    with connection.cursor() as cursor2:
                        cursor2.callproc('s01_user_login_check_password', [user_email, password])
                        pass_result = cursor2.fetchall()
                        output = [row for row in pass_result]
                        user_type = output[0]["UserType"]
                else:
                    return "ERROR: Invalid Username"

                if user_type == "Employee":
                    with connection.cursor() as cursor3:
                        cursor3.callproc('s01_employee_check_type', [user_email])
                        employee_result = cursor3.fetchall()
                        output = [row for row in employee_result]
                        employee_type = output[0]["EmployeeType"]
                    if employee_type == "Admin":
                        return render_template('s08_adminFunctionality.html')
                    elif employee_type == "Manager":
                        return render_template('s10_managerFunctionality.html')
                    elif employee_type == "Staff":
                        return render_template('s12_staffFunctionality.html')
                elif user_type == "Employee, Visitor":
                    with connection.cursor() as cursor3:
                        cursor3.callproc('s01_employee_check_type', [user_email])
                        employee_result = cursor3.fetchall()
                        output = [row for row in employee_result]
                        employee_type = output[0]["EmployeeType"]
                    if employee_type == "Admin":
                        return render_template('s09_adminVisitorFunctionality.html')
                    elif employee_type == "Manager":
                        return render_template('s11_managerVisitorFunctionality.html')
                    elif employee_type == "Staff":
                        return render_template('s13_staffVisitorFunctionality.html')
                elif user_type == "Visitor":
                    return render_template('s14_visitorFunctionality')
                elif user_type == "User":
                    return render_template('s07_userFunctionality')
                else: 
                    return "INVALID USER TYPE"

        except Exception as e:
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

#EVERYTHING UNTIL THIS POINT WORKS----------------------------------------------------

@app.route('/register_user', methods=['GET', 'POST'])
def register_user():
    return    

@app.route('/register_visitor', methods=['GET', 'POST'])
def register_visitor():
    return  

@app.route('/register_employee', methods=['GET', 'POST'])
def register_employee():
    return    

@app.route('/register_employee_visitor', methods=['GET', 'POST'])
def register_employee_visitor():
    return  

@app.route('/user_functionality', methods=['GET', 'POST'])
def user_functionality():
    return  

@app.route('/admin_functionality', methods=['GET', 'POST'])
def admin_functionality():
    return  

@app.route('/admin_visitor_functionality', methods=['GET', 'POST'])
def admin_visitor_functionality():
    return  

@app.route('/mamager_functionality', methods=['GET', 'POST'])
def manager_functionality():
    return  

@app.route('/manager_visitor_functionality', methods=['GET', 'POST'])
def manager_visitor_functionality():
    return  

@app.route('/staff_functionality', methods=['GET', 'POST'])
def staff_functionality():
    return  

@app.route('/staff_visitor_functionality', methods=['GET', 'POST'])
def staff_visitor_functionality():
    return  

@app.route('/visitor_functionality', methods=['GET', 'POST'])
def visitor_functionality():
    return  

if __name__ == '__main__':
    app.run(debug=True)









