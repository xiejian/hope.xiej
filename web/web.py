import user,MySQLdb
from contextlib import closing
from flask import Flask, request, session, redirect, url_for, abort,render_template, flash, g,jsonify
from basefunc import validateEmail,generate_csrf_token,addordercheck

app = Flask(__name__)
app.config.from_object('config')
app.config.from_envvar('FLASKR_SETTINGS', silent=True)
app.jinja_env.globals['csrf_token'] = generate_csrf_token
app.jinja_env.globals['gu'] = user.get_userinfo

def _connect_db():
    """Returns a new connection to the database."""
    return MySQLdb.connect(host=app.config['DB']['host'], user=app.config['DB']['user'], passwd=app.config['DB']['passwd'],db=app.config['DB']['db'])
#================================================================
gv_contract = {}

def update_gv(cid = 'contract_id',type = 'I'):
    with closing(_connect_db()) as db:
        cur = db.cursor()
        ocur = db.cursor()
        cur.execute("SELECT contract_id,concat(name,DATE_FORMAT(settledate,'%y%m')),status,btc_multi,DATE_FORMAT(opendate,'%Y-%m-%d'), \
                    latestpoint,DATE_FORMAT(settledate,'%Y-%m-%d'),leverage,discription FROM contract WHERE STATUS = 'O' AND contract_id ="+str(cid))
        for row in cur.fetchall():
            gv_contract[row[0]] = dict(name=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=row[6],leverage=row[7],discription=row[8])
            #update order queues
            ocur.execute("SELECT order_id,price,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY price DESC ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['B'] = [dict(order_id=orow[0],price=float(orow[1]),rm_lots=orow[2]) for orow in ocur.fetchall()]
            ocur.execute("SELECT order_id,price,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY price ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['S'] = [dict(order_id=orow[0],price=float(orow[1]),rm_lots=orow[2]) for orow in ocur.fetchall()]
            #update transactions history
            if type != 'C':
                ocur.execute("SELECT t.price,t.lots,DATE_FORMAT(TIMESTAMP,'%%d/%%H:%%m'),direct FROM trans t,orders o WHERE t.buy_oid = o.order_id AND o.contract_id = %s ORDER BY TIMESTAMP DESC LIMIT 0,5",row[0])
                gv_contract[row[0]]['T'] = [dict(price=float(orow[0]),lots=orow[1],time=orow[2],dir=orow[3]) for orow in ocur.fetchall()]

@app.context_processor
def inject_cont():
    return dict(cont = gv_contract)

@app.before_request
def before_request():
    g.db  = _connect_db()
    g.cur = g.db.cursor()
    if request.method == "POST":
        token = session.pop('_csrf_token', None)
        if not token or token != request.form.get('_csrf_token'):
            abort(403)
    #"""Make sure we are connected to the database each request."""


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
    cls = request.args.getlist('cl[]', type=int)
    if cls:
        temp = {}
        for cl in cls:
            if cl in gv_contract.keys():
                temp[cl] = gv_contract[cl]
                del temp[cl]['B']
                del temp[cl]['S']
                del temp[cl]['T']
        return jsonify(temp)
    cont = request.args.get('c', 0, type=int)
    if cont not in gv_contract.keys():
        abort(401)
    session['latestcont'] = cont
    return jsonify(gv_contract[cont])

@app.route('/_userdata')
def userdata():
    if 'user_id' not in session:
        abort(401)
    return jsonify(user.get_userinfo(session['user_id']))

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
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            flash('Not validate Email','err')
        else:
            user_id = user.loginuser(request.form['username'],request.form['password'])
            if user_id:
                session['user_id'] = user_id
                flash('You were logged in','suc')
                return redirect(url_for('trade'))
            else:
                flash('Login Failed.','err')
    return render_template('home.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('You were logged out','suc')
    return redirect(url_for('home'))

@app.route('/register', methods=['GET','POST'])
def register():
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            flash('Not validate Email','err')
        elif request.form['password'] <> request.form['password2']:
            flash('Password not Match','err')
        elif len(request.form['password']) < 6:
            flash('Password too Short','err')
        else:
            res = user.createuser(request.form['username'],request.form['password'])
            if res == True:
                flash('New Account was successfully created','suc')
                return redirect(url_for('home'))
            else:
                flash(res,'err')
    else:
        vcode = request.args.get('v', False)
        if vcode:
            user_id = user.activeuser(vcode)
            if user_id:
                flash('Your account had been activated.','suc')
                session['user_id'] = user_id
                return render_template('active.html')
            else:
                abort(401)
    return render_template('register.html')


@app.route('/trade', methods=['GET','POST'])
def trade():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        if 'b_s' in request.form:   #---Add order---
            if addordercheck(request.form['contract_id'], request.form['point'], request.form['lots']):
                g.cur.callproc('addorder',(request.form['contract_id'], session['user_id'], request.form['b_s'], request.form['point'], request.form['lots']))
                result = g.cur.fetchone()
                if result[0] != 'err':
                    if result[1] == 'Deal had been Made.':
                        update_gv(request.form['contract_id'])
                    else:
                        update_gv(request.form['contract_id'],'C')
                flash(result[1] ,result[0] )
            else:
                flash('Order Added Failed.','err')
        else:   #---Cancel order---
            if long(request.form['orderid']) in session['orders']:
                g.cur.callproc('exchange',(request.form['orderid'],'C'))
                result = g.cur.fetchone()
                if result[0] != 'err':
                    update_gv(request.form['contract_id'],'C')
                flash(result[1] ,result[0] )
            else:
                flash('Cancel Order Failed.','err')
        return redirect(url_for('trade'))
    else:
        session.update(user.get_userinfo())
        contract_id = request.args.get('c', 0, type=int)
        if contract_id == 0 and 'latestcont' in session:
            contract_id = session['latestcont']
        return render_template('trade.html',default_cid = contract_id )

@app.route('/account', methods=['GET','POST'])
def account():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if 'address' not in session:
        g.cur.execute("SELECT address FROM btc_account WHERE account = %s",session['email'])
        for orow in g.cur.fetchone():
            session.update(dict(address=orow))
    return render_template('account.html')

@app.route('/market', methods=['GET','POST'])
def market():
    return "Market"

@app.route('/test', methods=['GET','POST'])
def test():
    if hasattr(g, 'u'):
        g.u += 1
    else:
        g.u = 0
    return str(g.u)


if __name__ == '__main__':
    update_gv()
    app.run()


