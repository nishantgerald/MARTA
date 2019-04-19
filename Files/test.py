import pymysql.cursors
from flask import Flask, session, redirect, url_for, escape, request, render_template
import json

from flask import Flask
app = Flask(__name__, template_folder='template')

@app.route('/')
def index():
    return render_template('/login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    # Connect to the database
    connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='Beltline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    print("yay!")

    """username_form = request.form["username"]

    try:
        with open('MARTA.sql', 'r') as sql:
            procs = sql.read().split(';')
            with connection.cursor() as cursor:
             # Read a single record
                result = cursor.execute(s01_user_login_check_email, [username_form])
                return json.dumps(result)
    except:
        print("ERROR")
    finally:"""
    connection.close()

if __name__ == '__main__':
    app.run(debug=True)