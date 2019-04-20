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
    if "register" in request.form:
        username = request.form['UserName']
        password = request.form['password'] #NEED TO HASH PASSWORD
        firstname = request.form['FirstName']
        lastname = request.form['LastName']
        with connection.cursor() as cursor:
            cursor.callproc('s03_register_user', [username, password, 'User', firstname, lastname])
            output = [row for row in pass_result]
        #NEED TO TAKE IN EMAILS HERE
    elif "login" in request.form:
        return render_template('s02_registerNavigation.html')

@app.route('/register_visitor', methods=['GET', 'POST'])
def register_visitor():
    return render_template('success.html')

@app.route('/register_employee', methods=['GET', 'POST'])
def register_employee():
    return render_template('success.html')

@app.route('/register_employee_visitor', methods=['GET', 'POST'])
def register_employee_visitor():
    return  render_template('success.html')

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
        return render_template('s16_userTransitHistory.html')
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

if __name__ == '__main__':
        # Connect to the database
    connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='Beltline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    app.run(debug=True)
    connection.close()









