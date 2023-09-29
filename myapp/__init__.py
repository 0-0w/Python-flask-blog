from flask import Flask, render_template, request,session,redirect,abort,flash
from flask_sqlalchemy import SQLAlchemy
from datetime import date
from flask_mail import Mail
from werkzeug.utils import secure_filename
import imghdr
import os
import math
import json


with open('myapp/templates/config.json','r') as c:
    params= json.load(c)["params"]


app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_PATH']=params['uploader_location']
app.config['MAX_CONTENT_LENGTH'] = 1024 * 1024
app.config['UPLOAD_EXTENSIONS'] = ['.jpg', '.png', '.gif']
app.config.update(
    MAIL_SERVER="smtp.gmail.com",
    MAIL_PORT="465",
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail-user"],
    MAIL_PASSWORD=params["gmail-AppPassword"]
)
mail=Mail(app)

local_server=False
if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']


db = SQLAlchemy(app)
class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone = db.Column(db.String(12), nullable=False)
    mes = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(20), nullable=True)
    email = db.Column(db.String(20), nullable=False)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(500), nullable=False)
    img_file = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)



@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_post']))

    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)

    posts = posts[(page-1)*int(params['no_of_post']) : ( (page-1)*int(params['no_of_post'])+ int(params['no_of_post']) )]
    if  last==1:
        prev="#"
        next="#"
    elif page==1:
        prev = "#"
        next = "/?page="+ str(page+1)
    elif page==last:
        prev = "/?page="+ str(page-1)
        next = "#"
    else:
        prev = "/?page="+ str(page-1)
        next = "/?page="+ str(page+1)
    
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

@app.route("/about")
def about():
    return render_template('about.html',params=params)


@app.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    post= Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=post)


@app.route("/delete/<string:sno>" , methods=['GET', 'POST'])
def delete(sno):
    if ("user" in session and session['user']==params['admin_user']):
        post=Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route("/edit/<string:sno>" , methods=['GET', 'POST'])
def edit(sno):
    if ("user" in session and session['user']==params['admin_user']):
        if request.method=="POST":
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date_t = date.today()

            if sno=='0':
                post = Posts(title=box_title, slug=slug, content=content, tagline=tline, img_file=img_file, date=date_t)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.box_title = box_title
                post.tline = tline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = date_t
                db.session.commit()
                return redirect('/edit/'+sno)

    post = Posts.query.filter_by(sno=sno).first()
    return render_template('edit.html', params=params, post=post,sno=sno)


@app.route("/dashboard",methods=["GET","POST"])
def dashboard():
    if ('user' in session and session['user']==params['admin_user']):
        posts=Posts.query.all()
        return render_template('dashboard.html',params=params,posts=posts) 

    if request.method=="POST":
        username= request.form.get('uname')
        userpass= request.form.get('pass')
        if username==params['admin_user'] and userpass==params['admin_pass']:
            posts=Posts.query.all()
            session['loggedin']=True
            session['user']=username
            return render_template("dashboard.html",params=params,posts=posts)
        
    return render_template('login.html',params=params)


def validate_image(stream):
    header = stream.read(512)
    stream.seek(0) 
    format = imghdr.what(None, header)
    if not format:
        return None
    return '.' + (format if format != 'jpeg' else 'jpg')

@app.route("/uploader",methods=["GET","POST"])
def uploader():
    if ('user' in session and session['user']==params['admin_user']):
        if request.method=="POST":
            f= request.files["file1"]
            filename=secure_filename(f.filename)
            if filename != '':
                file_ext = os.path.splitext(filename)[1]
                if file_ext not in app.config['UPLOAD_EXTENSIONS'] or file_ext != validate_image(f.stream):
                    abort(400)
                f.save(os.path.join(app.config['UPLOAD_PATH'], filename))
                return "Uploaded successfully"


@app.route("/contact", methods = ['GET', 'POST'])
def contact():
    if(request.method=='POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, phone = phone, mes = message, date= date.today(),email = email )
        db.session.add(entry)
        db.session.commit()
        flash("Message sent successfully!")
        
        mail.send_message('New message from BlogPost' + name,
                        sender=email,
                        recipients=[params["gmail-user"]],
                        body= message + "\n" + phone
                        )
    return render_template('contact.html',params=params)

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect("/")

# app.run(debug=True)



