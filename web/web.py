import MySQLdb,user
from contextlib import closing
from flask import Flask, request, session, redirect, url_for, abort,render_template, flash, g,jsonify
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
gv_oqueue = {}
gv_transhis = {}

def update_gv(cid = 'contract_id'):
    global gv_contract
    with closing(_connect_db()) as db:
        cur = db.cursor()
        ocur = db.cursor()
        cur.execute("SELECT contract_id,concat(name,DATE_FORMAT(settledate,'%y%m')),status,btc_multi,DATE_FORMAT(opendate,'%Y-%m-%d'), \
                    latestpoint,DATE_FORMAT(settledate,'%Y-%m-%d'),leverage,discription FROM contract WHERE STATUS = 'O' AND contract_id ="+str(cid))
        for row in cur.fetchall():
            gv_contract[row[0]] = dict(name=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=row[6],leverage=row[7],discription=row[8])
            #utemp    open order queue
            temp = {}
            ocur.execute("SELECT order_id,price,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY price DESC ,createtime LIMIT 0,10",row[0])
            temp['B'] = [dict(order_id=orow[0],price=float(orow[1]),rm_lots=orow[2]) for orow in ocur.fetchall()]
            ocur.execute("SELECT order_id,price,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY price ,createtime LIMIT 0,10",row[0])
            temp['S'] = [dict(order_id=orow[0],price=float(orow[1]),rm_lots=orow[2]) for orow in ocur.fetchall()]
            gv_oqueue[row[0]]=temp
            ocur.execute("SELECT t.price,t.lots,DATE_FORMAT(TIMESTAMP,'%%d/%%H:%%m'),direct FROM trans t,orders o WHERE t.buy_oid = o.order_id AND o.contract_id = %s ORDER BY TIMESTAMP DESC LIMIT 0,5",row[0])
            gv_transhis[row[0]] = [dict(price=float(orow[0]),lots=orow[1],time=orow[2],dir=orow[3]) for orow in ocur.fetchall()]

@app.context_processor
def inject_cont():
    return dict(cont = gv_contract)

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
@app.route('/_contdata')
def contdata():
    cont = request.args.get('c', 0, type=int)
    if cont not in gv_contract.keys():
        abort(401)
    return jsonify(gv_contract[cont],q = gv_oqueue[cont],t = gv_transhis[cont])


@app.route('/_marketdata')
def marketdata():
    oqu = request.args.get('c', 0, type=int)
    cont = request.args.getlist('p', type=int)
    if (oqu > 0 and oqu not in gv_oqueue.keys()) or not reduce(lambda x, y: x and y, [c in gv_contract.keys() for c in cont]):
        abort(401)
    latestp,oqt = {},{}
    for c in cont:
        latestp[c] =  gv_contract[c]['latestpoint']
    if oqu > 0:
        oqt[oqu] = gv_oqueue[oqu]
        return jsonify(oq = oqt,lp = latestp)
    else:
        return jsonify(lp = latestp)
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
                return redirect(url_for('trade',c = session['positions'][0]['contract_id']))
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


@app.route('/trade', methods=['GET','POST'])
def trade():
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
        contract_id = request.args.get('c', 0, type=int)
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


