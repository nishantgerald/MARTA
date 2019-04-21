import pymysql.cursors
from flask import Flask, session, redirect, url_for, escape, request, render_template, jsonify
import json

from flask import Flask
app = Flask(__name__, template_folder='template')

user_email = ""
user_type = ""
employee_type = ""
username = ""
employee_info = []

def make_db_connection():
    connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='Beltline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    return connection

def close_db_connection(connection):
    connection.close()

@app.route('/')
def index():
    return render_template('/s01_login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if "login" in request.form:
        user_email = request.form['username']
        password = request.form['password']

        try:
            connection = make_db_connection()
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
                        if len(pass_result) == 0:
                            return "Incorrect password"
                        output = [row for row in pass_result]
                        user_type = output[0]["UserType"]
                        user_status = output[0]["Status"]
                        if user_status != "Approved":
                            return "Sorry, your account is not approved for login"
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
            close_db_connection(connection)
            
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

@app.route('/register_user', methods=['GET', 'POST'])
def register_user():
    if "register" in request.form:
        connection = make_db_connection()
        username = request.form['UserName']
        password = request.form['password'] #NEED TO HASH PASSWORD
        #NEED TO CONFIRM PASSWORD IS SAME AS CONFIRM FIELD
        firstname = request.form['FirstName']
        lastname = request.form['LastName']
        values = [username, password, 'Pending', firstname, lastname, 'User']
        query = "INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (%s,%s,%s,%s,%s,%s)"
        with connection.cursor() as cursor:
            cursor.execute(query, values)
            connection.commit()
            #NEED TO TAKE IN EMAILS HERE

            close_db_connection(connection)
            return "Thank you for registering! You will be able to login once your account is approved."

    elif "back" in request.form:
        return render_template('s02_registerNavigation.html')

@app.route('/register_visitor', methods=['GET', 'POST'])
def register_visitor():
    if "register" in request.form:
        connection = make_db_connection()
        username = request.form['UserName']
        password = request.form['password'] #NEED TO HASH PASSWORD
        #NEED TO CONFIRM PASSWORD IS SAME AS CONFIRM FIELD
        firstname = request.form['FirstName']
        lastname = request.form['LastName']
        values = [username, password, 'Pending', firstname, lastname, 'Visitor']
        query = "INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (%s,%s,%s,%s,%s,%s)"
        with connection.cursor() as cursor:
            cursor.execute(query, values)
            connection.commit()
            #NEED TO TAKE IN EMAILS HERE

            close_db_connection(connection)
            return "Thank you for registering! You will be able to login once your account is approved."

    elif "back" in request.form:
        return render_template('s02_registerNavigation.html')

#EVERYTHING UNTIL THIS POINT WORKS----------------------------------------------------

@app.route('/employee', methods=['GET', 'POST'])
def register_employee():
    if "Register" in request.form:
        connection = make_db_connection()
        username = request.form['UserName']
        password = request.form['password'] #NEED TO HASH PASSWORD
        #NEED TO CONFIRM PASSWORD IS SAME AS CONFIRM FIELD
        firstname = request.form['FirstName']
        lastname = request.form['LastName']
        phone = request.forn['phone']
        address = request.form['address']
        city = request.form['city']
        state = request.form['state']
        zipcode = request.form['zipcode']
        etype = request.form['EmployeeType']
        user_values = [username, password, 'Pending', firstname, lastname, 'Employee']
        user_query = "INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (%s,%s,%s,%s,%s,%s)"
        employee_info = [username, 'EID', phone, address, city, state, zipcode, etype]
        with connection.cursor() as cursor:
            cursor.execute(user_query, values)
            connection.commit()
            #NEED TO TAKE IN EMAILS HERE

            close_db_connection(connection)
            return "Thank you for registering! You will be able to login once your account is approved."

    elif "back" in request.form:
        return render_template('s02_registerNavigation.html')

@app.route('/register_employee_visitor', methods=['GET', 'POST'])
def register_employee_visitor():
    if "register" in request.form:
        connection = make_db_connection()
        username = request.form['UserName']
        password = request.form['password'] #NEED TO HASH PASSWORD
        #NEED TO CONFIRM PASSWORD IS SAME AS CONFIRM FIELD
        firstname = request.form['FirstName']
        lastname = request.form['LastName']
        phone = request.forn['phone']
        address = request.form['address']
        city = request.form['city']
        state = request.form['state']
        zipcode = request.form['zipcode']
        etype = request.form['EmployeeType']
        user_values = [username, password, 'Pending', firstname, lastname, 'Employee, Visitor']
        user_query = "INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (%s,%s,%s,%s,%s,%s)"
        employee_info = [username, 'EID', phone, address, city, state, zipcode, etype]
        with connection.cursor() as cursor:
            cursor.execute(user_query, values)
            connection.commit()
            #NEED TO TAKE IN EMAILS HERE
            
            close_db_connection(connection)
            return "Thank you for registering! You will be able to login once your account is approved."

    elif "back" in request.form:
        return render_template('s02_registerNavigation.html')

#Navigation (below screens) work!!!--------------------------------------

@app.route('/user_functionality', methods=['GET', 'POST'])
def user_functionality():
    if "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "back" in request.form:
        return render_template('s01_login.html') 

@app.route('/admin_functionality', methods=['GET', 'POST'])
def admin_functionality():
    if "manage_profile" in request.form:
        return render_template('s17_manageProfile.html')
    elif "manage_user" in request.form:
        return render_template('s18_adminManageUser.html')
    elif "manage_transit" in request.form:
        return render_template('s22_adminManageTransit.html')
    elif "manage_site" in request.form:
        return render_template('s19_adminManageSite.html')
    elif "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "back" in request.form:
        return render_template('s01_login.html')

@app.route('/admin_visitor_functionality', methods=['GET', 'POST'])
def admin_visitor_functionality():
    if "manage_profile" in request.form:
        return render_template('s17_manageProfile.html')
    elif "manage_user" in request.form:
        return render_template('s18_adminManageUser.html')
    elif "manage_transit" in request.form:
        return render_template('s22_adminManageTransit.html')
    elif "manage_site" in request.form:
        return render_template('s19_adminManageSite.html')
    elif "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_visit_history" in request.form:
        return render_template('s38_visitorVisitHistory')
    elif "view_transit_history" in request.form:
        return prepare_transit_screen()
    elif "explore_site" in request.form:
        return render_template('s35_visitorExploreSite.html')
    elif "explore_event" in request.form:
        return render_template('s33_visitorExploreEvent.html')
    elif "back" in request.form:
        return render_template('s01_login.html')

@app.route('/manager_functionality', methods=['GET', 'POST'])
def manager_functionality():
    if "manage_profile" in request.form:
        return render_template('s17_manageProfile.html')
    elif "manage_event" in request.form:
        return render_template('s25_managerManageEvent.html')
    elif "view_staff" in request.form:
        return render_template('s28_managerManageStaff.html')
    elif "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "view_site_report" in request.form:
        return render_template('s29_managerSiteReport.html')
    elif "back" in request.form:
        return render_template('s01_login.html')

@app.route('/manager_visitor_functionality', methods=['GET', 'POST'])
def manager_visitor_functionality():
    if "manage_profile" in request.form:
        return render_template('s17_manageProfile.html')
    elif "manage_event" in request.form:
        return render_template('s25_managerManageEvent.html')
    elif "explore_event" in request.form:
        return render_template('s33_visitorExploreEvent.html')
    elif "explore_site" in request.form:
        return render_template('s35_visitorExploreSite.html')
    elif "view_staff" in request.form:
        return render_template('s28_managerManageStaff.html')
    elif "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "view_visit_history" in request.form:
        return render_template('s38_visitorVisitHistory')
    elif "view_site_report" in request.form:
        return render_template('s29_managerSiteReport.html')
    elif "back" in request.form:
        return render_template('s01_login.html')

@app.route('/staff_functionality', methods=['GET', 'POST'])
def staff_functionality():
    if "manage_profile" in request.form:
        return render_template('s17_manageProfile.html')
    elif "view_schedule" in request.form:
        return render_template('s31_staffViewSchedule.html')
    elif "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "back" in request.form:
        return render_template('s01_login.html')

@app.route('/staff_visitor_functionality', methods=['GET', 'POST'])
def staff_visitor_functionality():
    if "manage_profile" in request.form:
        return render_template('s17_manageProfile.html')
    elif "view_schedule" in request.form:
        return render_template('s31_staffViewSchedule.html')
    elif "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "explore_event" in request.form:
        return render_template('s33_visitorExploreEvent.html')
    elif "explore_site" in request.form:
        return render_template('s35_visitorExploreSite.html')
    elif "view_visit_history" in request.form:
        return render_template('s38_visitorVisitHistory')
    elif "back" in request.form:
        return render_template('s01_login.html')  

@app.route('/visitor_functionality', methods=['GET', 'POST'])
def visitor_functionality():
    if "take_transit" in request.form:
        return render_template('s15_userTakeTransit.html')
    elif "view_transit_history" in request.form:
        return render_template('s16_userTransitHistory.html')
    elif "explore_event" in request.form:
        return render_template('s33_visitorExploreEvent.html')
    elif "explore_site" in request.form:
        return render_template('s35_visitorExploreSite.html')
    elif "view_visit_history" in request.form:
        return render_template('s38_visitorVisitHistory')
    elif "back" in request.form:
        return render_template('s01_login.html')

#End navigation screens-----------------------------------------

def prepare_transit_screen():
    connection = make_db_connection()
    with connection.cursor() as site_cursor:
        site_query = "SELECT DISTINCT SiteName FROM Beltline.site;"
        site_cursor.execute(site_query)
        site_list = [row for row in cursor.fetchall()]
    with connection.cursor() as transit_cursor:
        transit_type_query = "SELECT DISTINCT TransitType FROM Beltline.transit;"
        transit_cursor.execute(site_query)
        transit_type_list = [row for row in cursor.fetchall()]
    close_db_connection(connection)
    return render_template('s15_userTakeTransit.html', site_list, transit_type_list)

@app.route('/user_take_transit', methods=['GET', 'POST'])
def user_take_transit():
    if "Filter" in request.form:
        return
    elif "back" in request.form:
        render.template('success.html')



if __name__ == '__main__':
        # Connect to the database
    app.run(debug=True)









