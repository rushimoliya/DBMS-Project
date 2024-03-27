from sqlalchemy import text
from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from flask_mail import Mail
import json

with open('config.json','r') as c:
    params = json.load(c)["params"]

# my db connection
local_server=True
app = Flask(__name__) 
app.secret_key='rushi'

app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/hms'
db=SQLAlchemy(app)

 
# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

# SMTP MAIL SERVER SETTINGS
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)

@login_manager.user_loader
def load_user(user_id):
    return Userinfo.query.get(int(user_id))

# my db tables import
class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    email=db.Column(db.String(100))

class Userinfo(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Patients(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50))
    disease=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    dept=db.Column(db.String(50))
    number=db.Column(db.String(50))

class Doctors(db.Model):
    did=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    doctorname=db.Column(db.String(50))
    dept=db.Column(db.String(50))

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/doctors", methods=['POST','GET'])
@login_required
def doctors():
    if request.method=="POST":
        email=request.form.get('email')
        doctorname=request.form.get('doctorname')
        dept=request.form.get('dept')
        with db.engine.begin() as conn:
            result = conn.execute(text(f"INSERT INTO `doctors` (`email`,`doctorname`,`dept`) VALUES ('{email}','{doctorname}','{dept}')"))
            conn.commit()
        # query=db.engine.execute(f"INSERT INTO `doctors` (`email`,`doctorname`,`dept`) VALUES ('{email}','{doctorname}','{dept}')")
        flash("Information is Stored","primary")

    return render_template('doctor.html')

@app.route("/patients" , methods=['POST','GET'])
@login_required
def patients():
    with db.engine.connect() as conn:
        doct = conn.execute(text("SELECT * FROM `doctors`"))
        conn.commit()
    # doct=db.engine.execute("SELECT * FROM `doctors`")
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        dept=request.form.get('dept')
        number=request.form.get('number')
        subject="HOSPITAL MANAGEMENT SYSTEM"
        with db.engine.begin() as conn:
            result = conn.execute(text(f"INSERT INTO `patients` (`email`,`name`,`gender`,`slot`,`disease`,`time`,`date`,`dept`,`number`) VALUES ('{email}','{name}','{gender}','{slot}','{disease}','{time}','{date}','{dept}','{number}')"))
            conn.commit() 

        # mail starts from here 
        mail.send_message(subject, sender=params['gmail-user'], recipients=[email],body=f"YOUR BOOKING IS CONFIRMED THANKS FOR CHOOSING US \nYour Entered Details are :\nName: {name}\nSlot: {slot}")
        flash("Booking Confirmed","info")
    return render_template('patient.html',doct=doct)

@app.route("/bookings")
@login_required
def bookings():
    em=current_user.email
    with db.engine.begin() as conn:
            result = conn.execute(text(f"SELECT * FROM `patients` WHERE email='{em}'")) 
            conn.commit()
    # query=db.engine.execute(f"SELECT * FROM `patients` WHERE email='{em}'")
    return render_template('booking.html',query=result)
    # return render_template('booking.html')

@app.route("/edit/<string:pid>",methods=['POST','GET'])
@login_required
def edit(pid):
    posts=Patients.query.filter_by(pid=pid).first()
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        dept=request.form.get('dept')
        number=request.form.get('number')

        with db.engine.begin() as conn:
            result = conn.execute(text(f"UPDATE `patients` SET `email` = '{email}', `name` = '{name}', `gender` = '{gender}', `slot` = '{slot}', `disease` = '{disease}', `time` = '{time}', `date` = '{date}', `dept` = '{dept}', `number` = '{number}' WHERE `patients`.`pid` = {pid}")) 
            conn.commit()
        flash("Slot is Updates","success")
        return redirect('/bookings')
    return render_template('edit.html',posts=posts)

@app.route("/delete/<string:pid>",methods=['POST','GET'])
@login_required
def delete(pid):
    with db.engine.begin() as conn:
            result = conn.execute(text(f"DELETE FROM `patients` WHERE `patients`.`pid`={pid}")) 
            conn.commit()
    # db.engine.execute(f"DELETE FROM `patients` WHERE `patients`.`pid`={pid}")
    flash("Slot Deleted Successful","danger")
    return redirect('/bookings')

@app.route('/signup' , methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get('username')
        email=request.form.get('email')
        password=request.form.get('password')
        user=Userinfo.query.filter_by(email=email).first()
        if user:
            # print("email already exist")
            flash("Email already exists","warning")
            return render_template('signup.html')
        encpassword=generate_password_hash(password)
        with db.engine.begin() as conn:
            result = conn.execute(text(f"INSERT INTO `userinfo` (`username`,`email`,`password`) VALUES ('{username}','{email}','{encpassword}');")) 
            conn.commit() 
        # new_user=Userinfo(username=username,email=email,password=encpassword)
        # db.session.add(new_user)
        # db.session.commit()
        flash("Sign Up Successfully, Please log in","success")           
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
        user=Userinfo.query.filter_by(email=email ).first()

        if user and check_password_hash(user.password,password):
            login_user(user)
            flash("Loged In sucessfully","primary")
            return redirect(url_for('index'))
        else:
            # print("invalid credentials")
            flash("Invalid Credentials","danger")
            return render_template('login.html')
    return render_template('login.html')



@app.route("/logout")
@login_required
def logout():
    logout_user()
    flash("Loged Out Successfully","success")
    return redirect(url_for('login'))

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

# username = current_user.username