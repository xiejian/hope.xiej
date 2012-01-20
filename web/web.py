import os,base64
from _db import _connect_db
from _data import gv_contract,_update_contract,_update_user,_add_order,_cancel_order
from _user import _activeuser,_activecode,_createuser,_loginuser,_loguser,_vali_cpass,_update_cpass,_invite,_dercode,_enrcode
from _mail import _send_mail
from _basefunc import validateEmail,webformat
from flask import Flask, request, session, redirect, url_for, abort,render_template, flash, g,jsonify
#from flaskext.mail import Mail


app = Flask(__name__)
app.config.from_object('config')
app.config.from_envvar('FLASKR_SETTINGS', silent=True)
#mail = Mail(app)

def generate_csrf_token():
    if '_csrf_token' not in session:
        session['_csrf_token'] =  base64.urlsafe_b64encode(os.urandom(8))
    return session['_csrf_token']
app.jinja_env.globals['csrf_token'] = generate_csrf_token
app.jinja_env.filters['f'] = webformat

#================================================================
@app.context_processor
def inject_cont():
    return dict(cont = gv_contract)

@app.before_first_request
def before_first_request():
    g.db  = _connect_db()
    _update_contract(g.db)

@app.before_request
def before_request():
    if request.method == "POST" and request.remote_addr not in app.config['INTERNAL_IP']:
        token = session.pop('_csrf_token', None)
        if not token or token != request.form.get('_csrf_token'):
            abort(403)
    g.db  = _connect_db()
@app.teardown_request
def teardown_request(exception):
    """Closes the database again at the end of the request."""
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
    return jsonify(_update_user(session['user_id']))

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
            user_id = _loginuser(g.db,request.form['username'],request.form['password'])
            if user_id:
                session['user_id'] = user_id
                session['email'] = request.form['username']
                flash('You were logged in','suc')
                _loguser(g.db,user_id,'Login',request.remote_addr)
                return redirect(url_for('trade'))
            else:
                flash('Login Failed.','err')
    g.u = _update_user(g.db,session)
    return render_template('home.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('You were logged out','suc')
    return redirect(url_for('home'))

@app.route('/register', methods=['GET','POST'])
def register():
    g.u = _update_user(g.db,session)
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            flash('Not validate Email','err')
        elif request.form['password'] <> request.form['password2']:
            flash('Password not Match','err')
        elif len(request.form['password']) < 6:
            flash('Password too Short','err')
        else:
            res = _createuser(g.db,request.form['username'],request.form['password'],request.form['referrer'])
            if res == True:
                _send_mail(request.form['username'],'activate',{'url':request.url_root+url_for('register',v=_activecode(g.db,request.form['username']))})
                flash('New Account was successfully created','suc')
                return redirect(url_for('home'))
            else:
                flash(res,'err')
    else:
        session.pop('user_id', None)
        vcode = request.args.get('v', False)
        if vcode:
            user_id = _activeuser(g.db,vcode)
            if user_id:
                flash('Your account had been activated.','suc')
                session['user_id'] = user_id
                return render_template('active.html')
            else:
                abort(401)
        rcode = request.args.get('r', False)
        ref = _dercode(rcode)
        session.update(ref)
    return render_template('register.html')
#todo register recommendation and friend trade volume contribution


@app.route('/trade', methods=['GET','POST'])
def trade():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        if 'b_s' in request.form:   #---Add order---
            res = _add_order(g.db,session,request.form['contract_id'],request.form['b_s'],request.form['o_c'], request.form['point'], request.form['lots'])
        else:   #---Cancel order---
            res = _cancel_order(g.db,session,request.form['orderid'])
        flash(res['msg'],res['category'])
        if res['category'] == 'suc':
            if 'Deal' in res['msg']:
                _update_contract(g.db,request.form['contract_id'],'D')
            else:
                _update_contract(g.db,request.form['contract_id'],'C')
        return redirect(url_for('trade'))
    else:
        g.u = _update_user(g.db,session)
        contract_id = request.args.get('c', 0, type=int)
        if contract_id == 0 and 'latestcont' in session:
            contract_id = session['latestcont']
        return render_template('trade.html',default_cid = contract_id )

@app.route('/account', methods=['GET','POST'])
def account():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST' and 'password' in request.form:
        if request.form['password'] <> request.form['password2']:
            flash('Password not Match','err')
        elif len(request.form['password']) < 6:
            flash('Password too Short','err')
        elif _vali_cpass(g.db,session['email'],request.form['opassword']):
            _update_cpass(g.db,session['email'],request.form['password'])
            flash('Capital Password Changed Successfully.')
        else:
            flash('Orignal Capital Password Not Match.')
    elif request.method == 'POST' and 'email' in request.form:
        if not validateEmail(request.form['email']):
            flash('Not validate Email','err')
        else:
            _invite(g.db,session['user_id'])
            _send_mail(request.form['email'],'invite',{'url':request.url_root+url_for('register',r = _enrcode(session['user_id'],request.form['email'])),
                                                       'refer':session['email']})
            flash('Invite Email Sent.','suc')

    g.u=_update_user(g.db,session,['trans','btcflow','btctrans','info','log'])#todo delete btcflow
    return render_template('account.html')

@app.route('/bitcoin', methods=['GET','POST'])
def bitcoin():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        #todo handle bitcoin withdraw post
        pass
    g.u=_update_user(g.db,session,['address'])
    return render_template('bitcoin.html')


@app.route('/market', methods=['GET','POST'])
def market():
    g.u=_update_user(g.db,session)
    return render_template('market.html')

@app.route('/contract', methods=['GET','POST'])
def contract():
    if 'user_id' not in session:
        flash('Please Log in First.')
        return redirect(url_for('home'))
    g.u = _update_user(g.db,session)
    if request.method == 'POST':
        if not validateEmail(request.form['username']):
            flash('Not validate Email','err')
        elif request.form['password'] <> request.form['password2']:
            flash('Password not Match','err')
        elif len(request.form['password']) < 6:
            flash('Password too Short','err')
        else:
            res = _createuser(g.db,request.form['username'],request.form['password'],request.form['referrer'])
            if res == True:
                _send_mail(request.form['username'],'activate',{'url':request.url_root+url_for('register',v=_activecode(g.db,request.form['username']))})
                flash('New Account was successfully created','suc')
                return redirect(url_for('home'))
            else:
                flash(res,'err')
    else:
        pass
    return render_template('contract.html')
#todo register recommendation and friend trade volume contribution


@app.route('/index', methods=['GET','POST'])
def index():
    return render_template('index.html')

@app.route('/s', methods=['POST'])
def server():
    print request.form
    print request.form['name']
    print request.user_agent
    return jsonify(request.form)

@app.route('/test', methods=['GET','POST'])
def test():
    print request.user_agent
    return request.remote_addr

if __name__ == '__main__':
    app.run(host='0.0.0.0')


