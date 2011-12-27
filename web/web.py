import MySQLdb,user
import hashlib, base64
from contextlib import closing
from flask import Flask, request, session, g, redirect, url_for, abort,render_template, flash
from basefunc import validateEmail,sendemail

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

@app.before_request
def before_request():
    """Make sure we are connected to the database each request."""
    g.db  = _connect_db()
    g.cur = g.db.cursor()

@app.teardown_request
def teardown_request(exception):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'cur'):
        g.cur.close()
    if hasattr(g, 'db'):
        g.db.close()

#=================================================================

@app.route('/register', methods=['GET','POST'])
def register():
    error = None
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            error = 'Not validate Email'
        elif request.form['password'] <> request.form['password2']:
            error = 'Password not Match'
        elif len(request.form['password']) < 6:
            error = 'Password too Short'
        else:
            res = user.createuser(request.form['username'],request.form['password'])
            if res == True:
                flash('New Account was successfully created')
                return redirect(url_for('home'))
            else:
                error = res
    return render_template('register.html', error = error)


@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    g.db.execute('insert into entries (title, text) values (?, ?)',
        [request.form['title'], request.form['text']])
    g.db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))


@app.route('/trade', methods=['GET','POST'])
def trade():
    return render_template('trade.html')


@app.route('/', methods=['GET','POST'])
def home():
    error = None
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            error = 'Not validate Email'
        elif len(request.form['password']) < 6:
            error = 'Password too Short'
        else:
            user_id = user.loginuser(request.form['username'],request.form['password'])
            if user_id:
                session['logged_in'] = True
                session['username'] = request.form['username']
                session['user_id'] = user_id
                flash('You were logged in')
                return redirect(url_for('trade'))
            else:
                error = 'Login Failed.'
    return render_template('home.html',error = error)


@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run()


