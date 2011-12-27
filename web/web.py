import MySQLdb,user
import hashlib, base64
from contextlib import closing
from flask import Flask, request, session, g, redirect, url_for, abort,render_template, flash

app = Flask(__name__)
app.config.from_object('config')
app.config.from_envvar('FLASKR_SETTINGS', silent=True)

def _connect_db():
    """Returns a new connection to the database."""
    return MySQLdb.connect(host=app.config['DB']['host'], user=app.config['DB']['user'], passwd=app.config['DB']['passwd'],db=app.config['DB']['db'])

def init_db():
    """Creates the database tables."""
    with closing(_connect_db()) as db:
        with app.open_resource('schema.sql') as f:
            db.cursor().executescript(f.read())
        db.commit()

def _createuser(email, password):
    #check email is not registered
    resrows = g.db.cursor().execute('SELECT password from user where email=%s', email)
    if resrows > 0:
        return False
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = g.db.cursor().execute("INSERT INTO user(email, password)VALUES (%s, %s)",[email, c_pass])
    if resrows==1:
        return True
    else:
        return False

def _loginuser(email, password):
    resrows = g.db.cursor().execute('SELECT user_id,password from user where email=%s', email)
    if resrows != 1:
        return False
    result = g.db.cursor().fetchall()
    c_pass = base64.b64encode(hashlib.sha224(mykey, email + password).digest())
    if c_pass == result[0][1]:
        return result[0][0]
    else:
        return False


@app.before_request
def before_request():
    """Make sure we are connected to the database each request."""
    g.db  = __connect_db()

@app.teardown_request
def teardown_request(exception):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'db'):
        g.db.close()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/register')
def register():
    if request.method == 'POST':
        pass
    return render_template('register.html')


@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    g.db.execute('insert into entries (title, text) values (?, ?)',
        [request.form['title'], request.form['text']])
    g.db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if user.check_credential(request.form['username'],request.form['password']):
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('home'))
        else:
            error = 'Login Failed.'
    return render_template('login.html', error=error)


@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run()


