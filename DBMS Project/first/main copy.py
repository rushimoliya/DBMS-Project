from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from sqlalchemy import text
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user

local_server=True
app = Flask(__name__) 
app.secure_key='rushi'

app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/hms'
db=SQLAlchemy(app)


class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    email=db.Column(db.String(100))

class Userinfo(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))


@app.route("/")
def index():
    return render_template('index.html')

@app.route("/doctors")
def doctors():
    return render_template('doctor.html')

@app.route("/patients")
def patients():
    return render_template('patient.html')

@app.route("/bookings")
def bookings():
    return render_template('booking.html')

@app.route('/signup' , methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get('username')
        email=request.form.get('email')
        password=request.form.get('password')
        user=Userinfo.query.filter_by(email=email).first()
        if user:
            print("email already exist")
            return render_template('signup.html')
        encpassword=generate_password_hash(password)
        with db.engine.begin() as conn:
            result = conn.execute(text(f"INSERT INTO `userinfo` (`username`,`email`,`password`) VALUES ('{username}','{email}','{encpassword}');")) 
            conn.commit() 
        # new_user=Userinfo(username=username,email=email,password=encpassword)
        # db.session.add(new_user)
        # db.session.commit()
        return render_template('login.html')
        # print(username,email,password) 
        # print("this is post method")
    else:
        print("this is get method")
    return render_template('signup.html')
  
@app.route('/login' , methods=['POST','GET'])
def login():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        # user=Userinfo.query.filter_by(email=email).first()
        print(email,password)
    return render_template('login.html')

@app.route("/logout")
def logout():
    return render_template('login.html')

@app.route("/test")
def test():
    try:
        Test.query.all
        return 'test successfull'
    except:
        return 'test not successfull'
        # return render_template('test.html')

@app.route("/home")
def home():
    return 'this is my HOME'

app.run(debug=True)