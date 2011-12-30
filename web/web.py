import MySQLdb,user
from contextlib import closing
from flask import Flask, request, session, redirect, url_for, abort,render_template, flash, g
from basefunc import validateEmail,generate_csrf_token,addordercheck

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

#================================================================
gv_contract = {}
gv_oqueue_b = {}
gv_oqueue_s = {}

def update_gv():
    global gv_contract
    with closing(_connect_db()) as db:
        cur = db.cursor()
        ocur = db.cursor()
        cur.execute("SELECT contract_id,concat(name,DATE_FORMAT(settledate,'%y%m')),status,btc_multi,opendate,latestpoint,settledate,leverage,discription FROM contract WHERE STATUS = 'O'")
        for row in cur.fetchall():
            gv_contract[row[0]] = dict(contract_id=row[0],name=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=row[6],leverage=row[7],discription=row[8])
            #update this contract 's open order queue
            ocur.execute("SELECT order_id,price,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY price DESC ,createtime LIMIT 0,10",row[0])
            gv_oqueue_b[row[0]] = [dict(order_id=orow[0],price=orow[1],rm_lots=orow[2]) for orow in ocur.fetchall()]
            ocur.execute("SELECT order_id,price,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY price ,createtime LIMIT 0,10",row[0])
            gv_oqueue_s[row[0]] = [dict(order_id=orow[0],price=orow[1],rm_lots=orow[2]) for orow in ocur.fetchall()]

@app.context_processor
def inject_contract():
    return dict(contract = gv_contract)

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
                user.update_session(user_id)
                flash('You were logged in')
                return redirect(url_for('trade',contract_id = session['positions'][0]['contract_id']))
            else:
                error = 'Login Failed.'
    return render_template('home.html',error = error)

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('home'))

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


@app.route('/trade/<int:contract_id>', methods=['GET','POST'])
def trade(contract_id):
    if request.method == 'POST':
        if 'b_s' in request.form:   #---Add order---
            if addordercheck(request.form['contract_id'], request.form['point'], request.form['lots']):
                g.cur.callproc('addorder',(request.form['contract_id'], session['user_id'], request.form['b_s'], request.form['point'], request.form['lots']))
                user.update_session(session['user_id'])
                flash('Order Added Succeed.')
            else:
                flash('Order Added Failed.')
        else:   #---Cancel order---
            if long(request.form['orderid']) in session['orders']:
                g.cur.callproc('exchange',(request.form['orderid'],'C'))
                user.update_session(session['user_id'])
                flash('Cancel Order Successfully.')
            else:
                flash('Cancel Order Failed.')
        return redirect(url_for('trade',contract_id = session['positions'][0]['contract_id']))
    else:
        return render_template('trade.html',default_cid = contract_id )

@app.route('/account', methods=['GET','POST'])
def account():
    return render_template('account.html')


@app.route('/test', methods=['GET','POST'])
def test():
    update_gv()
    return str('gv_xj')


if __name__ == '__main__':
    update_gv()
    app.run()


