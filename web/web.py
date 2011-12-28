import MySQLdb,user
from contextlib import closing
from flask import Flask, request, session, g, redirect, url_for, abort,render_template, flash
from basefunc import validateEmail,generate_csrf_token

app = Flask(__name__)
app.config.from_object('config')
app.config.from_envvar('FLASKR_SETTINGS', silent=True)
app.jinja_env.globals['csrf_token'] = generate_csrf_token

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
    if request.method == "POST":
        token = session.pop('_csrf_token', None)
        if not token or token != request.form.get('_csrf_token'):
            abort(403)
    #"""Make sure we are connected to the database each request."""
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


@app.route('/v/<code>', methods=['GET'])
def validate(code):
    user_id = user.activeuser(code)
    if user_id:
        flash('Your account had been activated.')
        return render_template('active.html')
    else:
        abort(401)


@app.route('/trade', methods=['GET','POST'])
def trade():
    if request.method == 'POST':
        pass
    else:
        g.cur.execute("SELECT contract_id,NAME,btc_multi,opendate,settledate,leverage FROM contract WHERE STATUS = 'O'")
        contracts = [dict(contract_id=row[0],name=row[1],btc_multi=row[2],opendate=row[3],settledate=row[4],leverage=row[5]) for row in g.cur.fetchall()]
        return render_template('trade.html',contracts=contracts)

@app.route('/account', methods=['GET','POST'])
def account():
    g.cur.execute('SELECT contract_id,contract_name,buy_sell,lots,cost,marketvalue,margin FROM v_pos WHERE user_id=%s', session['user_id'])
    pos = [dict(contract_id=row[0],contract_name=row[1],buy_sell=row[2],lots=row[3],cost=row[4],marketvalue=row[5],margin=row[6]) for row in g.cur.fetchall()]
    return render_template('account.html',pos = pos)


@app.route('/', methods=['GET','POST'])
def home():
    error = None
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            error = 'Not validate Email'
        #elif len(request.form['password']) < 6:
        #    error = 'Password too Short'
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


