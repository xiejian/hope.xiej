import os,base64,time
from recaptcha.client import captcha
from _db import _connect_db,_expose_db
from _data import gv_contract,gv_contlist,_update_contract,_update_user,_add_order,_cancel_order,_modify_cont,_delete_cont,_settle_cont,_update_usergl
from _user import _activeuser,_activecode,_createuser,_loginuser,_loguser,_vali_cpass,_update_cpass,_change_invitenum,_dercode,_enrcode,_btc_withdraw,_update_pass,_apikeyvalidate
from _mail import _send_mail
from _basefunc import validateEmail,myformat
from flask import Flask, request, session, redirect, url_for, abort,render_template, flash, g,jsonify
from _twitter import gv_twt,_start_twt_sevice,gv_cont_sp
from __eod import _start_eod_sevice

app = Flask(__name__)
app.config.from_object('config')
app.config.from_envvar('FLASKR_SETTINGS', silent=True)

def generate_csrf_token():
    if '_csrf_token' not in session:
        session['_csrf_token'] =  base64.urlsafe_b64encode(os.urandom(8))
    return session['_csrf_token']
app.jinja_env.globals['csrf_token'] = generate_csrf_token
app.jinja_env.filters['f'] = myformat

#================================================================
@app.context_processor
def inject_cont():
    return dict(cont = gv_contract,twt=gv_twt )

@app.before_first_request
def before_first_request():
    g.db  = _connect_db()
    _update_contract(g.db)
    _start_eod_sevice()
    _start_twt_sevice()

@app.before_request
def before_request():
    if request.method == "POST":
        token = session.pop('_csrf_token', None)
        if not token or token != request.form.get('_csrf_token'):
            abort(403)
    g.db  = _connect_db()
@app.teardown_request
def teardown_request(exception):
    if hasattr(g, 'db'):
        g.db.close()

#=================================================================
@app.route('/data')
def data():
    t = request.args.get('t', 'cl')
    n = request.args.get('n', 0,type=int)
    if t == 'cl':
        return jsonify(gv_contlist)
    elif t=='c':
        if n in gv_contract:
            return jsonify({'data':gv_contract[n]['M'],'name':gv_contract[n]['name']})
        else:
            abort(404)
    elif t=='tc':
        #return 1
        if n in gv_contract:
            return jsonify(gv_contract[n])
        else:
            abort(404)
    elif t=='u':
        if 'user_id' not in session:
            abort(404)
        return jsonify(_update_user(g.db,session,['orders','positions']))
    elif t=='ua':
        if 'user_id' not in session:
            abort(404)
        return jsonify(_update_usergl(g.db,session['user_id'],n))
    elif t=='test':
        return jsonify(request.headers)


#=================================================================
@app.route('/', methods=['GET','POST'])
def home():
    if request.method == 'POST':
        type = request.args.get('t', 'L')
        if type == 'R':         #recover password
            _send_mail(request.form['username'],'activate',{'url':request.url_root+url_for('register',v=_activecode(g.db,request.form['username']))})
            return jsonify(dict(msg='Validate Email sent successfully',type = 'suc'))
        elif type == 'L':       #user login
            user_id = _loginuser(g.db,request.form['username'],request.form['password'])
            if user_id:
                session['user_id'] = user_id
                session['email'] = request.form['username']
                flash('You were logged in','suc')
                _loguser(g.db,user_id,'Login',request.remote_addr)
                return redirect(url_for('trade'))
            else:
                g.login_failed = request.form['username']
    return render_template('home.html',fbmail=app.config['FEEDBACKMAIL'])

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    #flash('You were logged out','suc')
    return redirect(url_for('home'))

@app.route('/register', methods=['GET','POST'])
def register():
    g.u = _update_user(g.db,session)
    if request.method == 'POST':
        response = captcha.submit(
            request.form['recaptcha_challenge_field'],
            request.form['recaptcha_response_field'],
            app.config['RECAP']['private_key'],
            request.remote_addr,
        )
        if not response.is_valid:
            flash('Incorrect recaptcha','err')
        elif not validateEmail(request.form['username']):
            flash('Not validate Email','err')
        elif request.form['password'] <> request.form['password2']:
            flash('Password not Match','err')
        elif len(request.form['password']) < 6:
            flash('Password too Short','err')
        else:
            res = _createuser(g.db,request.form['username'],request.form['password'],request.form['referrer'])
            if res == True:
                _send_mail(request.form['username'],render_template("email/activate.html",para={'user': request.form['username'].split('@')[0].upper(),
                        'url':url_for('register',v=_activecode(g.db,request.form['username']))}))
                    #'activate',{'url':request.url_root+url_for('register',v=_activecode(g.db,request.form['username']))})
                flash('New Account was successfully created','suc')
                return render_template('register.html',type='C',email=request.form['username'])
            else:
                flash(res,'err')
    else:
        session.pop('user_id', None)
        vcode = request.args.get('v', False)
        if vcode:
            res = _activeuser(g.db,vcode)
            if res is not False:
                flash('Your account had been activated.','suc')
                session['user_id'] = res[0]
                session['email'] = res[1]
                return render_template('register.html',type='A')
            else:
                abort(401)
        rcode = request.args.get('r', False)
        ref = _dercode(rcode)
        session.update(ref)
    return render_template('register.html',type='O',capthtml=captcha.displayhtml(app.config['RECAP']['public_key'],True))

@app.route('/trade', methods=['GET','POST'])
def trade():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        #---Add order---
        res = _add_order(g.db,session['user_id'],long(request.form['contract_id']),request.form['b_s'], request.form['point'], request.form['lots'])
        session['bs'] = request.form['b_s']
        flash(res['msg'],res['category'])
        if res['category'] == 'suc':
            if 'Deal' in res['msg']:
                _update_contract(g.db,request.form['contract_id'],'D')
            else:
                _update_contract(g.db,request.form['contract_id'],'C')
        return redirect(url_for('trade',c=request.form['contract_id']))
    else:
        co = request.args.get('co', 0,type=int)
        contract_id = request.args.get('c', 0, type=int)
        if co >= 1:   #Cancel order
            res = _cancel_order(g.db,session['user_id'],co)
            flash(res['msg'],res['category'])
            _update_contract(g.db,contract_id,'C')
            return redirect(url_for('trade',c=contract_id))
        else:
            g.u = _update_user(g.db,session,[])
            if contract_id == 0 and 'latestcont' in session:
                contract_id = session['latestcont']
            return render_template('trade.html',default_cid = contract_id )

@app.route('/account', methods=['GET','POST'])
def account():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        type = request.args.get('t', 0)
        if type == 'P':         #reset password
            if _loginuser(g.db,session['email'],request.form['opassword']):
                _update_pass(g.db,session['email'],request.form['password'])
                msg = dict(msg = 'Password Changed Successfully.',type ='suc')
            else:
                msg = dict(msg='Orignal Password Not Match.',type = 'err')
            return jsonify(msg)
        elif type == 'Q':       #reset capital password
            if _vali_cpass(g.db,session['email'],request.form['opassword']):
                _update_cpass(g.db,session['email'],request.form['password'])
                if request.form['opassword'] == "not set yet":
                    flash('Capital Password Set Successfully.','suc')
                    return jsonify({'goto':url_for("account",tab=3)})
                msg = dict(msg = 'Capital Password Changed Successfully.',type ='suc')
            else:
                msg = dict(msg='Orignal Capital Password Not Match.',type = 'err')
            return jsonify(msg)
        elif type == 'E':       #resend email
            _send_mail(session['email'],render_template("email/activate.html",para={'user': session['email'].split('@')[0].upper(),
                            'url':url_for('register',v=_activecode(g.db,session['email']))}))
            #_send_mail(session['email'],'activate',{'url':request.url_root+url_for('register',v=_activecode(g.db,session['email']))})
            msg = dict(msg='Validate Email sent successfully',type = 'suc')
            return jsonify(msg)
        elif type == 'I':       #invite email
            if not validateEmail(request.form['email']):
                flash('Not validate Email','err')
            elif _change_invitenum(g.db,session['user_id'],-1):

                _send_mail(request.form['email'],render_template("email/invite.html",para={'user': request.form['email'].split('@')[0].upper(),
                                        'url':url_for('register',r = _enrcode(session['user_id'],request.form['email'])),'refer':session['email'].split('@')[0].upper()}))

                flash('Invite Email Sent.','suc')
                return jsonify({'goto':url_for("account",tab=0)})
            else:
                msg = dict(msg='Not Enough Email Invite.',type = 'err')
                return jsonify(msg)

        elif type in ['C','D','S']:       #new ,modify and settle contract

            cid = long(request.form['id'])
            if cid == 0 or gv_contract[cid]['owner'] == session['email']:
                if type == 'C':
                    msg,cid = _modify_cont(g.db,cid,request.form['code'],request.form['btc_multi'],request.form['opendate'],request.form['opentime'],request.form['settledate'],request.form['settletime'],request.form['leverage'],\
                        request.form['fullname'],session['user_id'],request.form['twitter_id'],request.form['write_fee'],request.form['region'],request.form['sector'],request.form['description'],request.form['movelimit'])
                elif type == 'D':   #delete
                    msg = _delete_cont(g.db,cid)
                elif type == 'S':   #settle
                    msg = _settle_cont(g.db,cid,request.form['settlepoint'],request.form['settleproof'])

            else:
                msg = dict(msg='Contract Owner Not Match.',type = 'err')
            if msg['type'] == 'suc':
                flash(msg['msg'],msg['type'])
                _update_contract(g.db,cid,'D')
                return jsonify({'goto':url_for("account",tab=2)})
            else:
                return jsonify(msg)

    g.u=_update_user(g.db,session,['positions','info','rtvol','log'])
    tab = request.args.get('tab', 0)
    return render_template('account.html',tab=tab)

@app.route('/bitcoin', methods=['GET','POST'])
def bitcoin():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        res = _btc_withdraw(g.db,session['email'],request.form['address'],request.form['amount'],request.form['password'],request.form['cpassword'])
        flash(res['msg'],res['category'])
    g.u=_update_user(g.db,session,['address','btctrans','info'])
    tab = request.args.get('tab', 0)
    return render_template('bitcoin.html',tab=tab)


@app.route('/market', methods=['GET','POST'])
def market():
    g.u=_update_user(g.db,session)
    tab = request.args.get('tab', 0)
    return render_template('market.html',tab=tab)

@app.route('/feedback', methods=['POST'])
def feedback():

    _send_mail(app.config['FEEDBACKMAIL'],render_template("email/feedback.html",category=request.form['category'],msg=request.form['msg']))

    msg = dict(msg='Feed back sent successfully.',type = 'suc')
    return jsonify(msg)

@app.route('/contract', methods=['GET'])
def contract():
    t = request.args.get('t', 'i')
    cont = request.args.get('c', 0,type=int)
    if t=='e':
        if 'user_id' in session and (cont == 0 or gv_contract[cont]['owner']==session['email']):
            return render_template('contract_edit.html',c=cont)
        else:
            abort(404)
    sp = None
    if gv_contract[cont]['code'] in gv_cont_sp:
        sp = gv_cont_sp[gv_contract[cont]['code']]
    return render_template('contract.html',c=cont,sp=sp)


@app.route('/liyutao', methods=['GET','POST'])
def admin():
    if 'email' not in session or session['email'] <> app.config['ADMIN']:
        abort(404)
    if request.method == 'POST':
        if request.form['a_r'] == 'R':
            cur = g.db.cursor()
            cur.execute("UPDATE contract SET status='R' WHERE contract_id=%s",request.form['id'])
            g.db.commit()
            cur.close()
            flash("Reject Contract "+request.form['id']+" Successfully")
        if request.form['a_r'] == 'M':
            cur = g.db.cursor()
            cur.execute("UPDATE contract SET apinstruction=%s WHERE contract_id=%s",(request.form['apinstruction'],request.form['id']))
            g.db.commit()
            cur.close()
            flash("Update Contract "+request.form['id']+" Approval Instruction Successfully")
        elif request.form['a_r'] == 'A':
            cur = g.db.cursor()
            cur.execute("UPDATE contract SET status='P' WHERE contract_id=%s and status='N'",request.form['id'])
            cur.execute("UPDATE contract SET status='Q' WHERE contract_id=%s and status='C'",request.form['id'])
            cur.execute("UPDATE contract c join users u on c.owner = u.user_id SET u.invite = u.invite + 5 WHERE c.contract_id=%s",request.form['id'])
            g.db.commit()
            cur.close()
            flash("Approval Contract "+request.form['id']+" Successfully")
        _update_contract(g.db,request.form['id'],'D')
        return redirect(url_for('admin'))
    cur = g.db.cursor()
    cur.execute("select a.account, a.balance,b.bio from btc_account a left join \
        (select user,sum(amount) as bio from btc_trans where timestamp > NOW() + interval -30 day group by user ) b on a.account = b.user")
    btc_account = [dict(account=orow[0],balance=orow[1],bio=orow[2]) for orow in cur.fetchall()]
    return render_template('admin.html',u = btc_account)


@app.route('/api', methods=['GET'])
def api():
    uid = _apikeyvalidate(g.db,request.args.get('key', 0))
    if uid == 0:
        abort(404)
    type = request.args.get('t', 0)
    if type == 'A':         #add order
        contract_id = request.args.get('cid', 0,type=int)
        b_s = request.args.get('bs', 0)
        point = request.args.get('pt', 0)
        lots =  request.args.get('lt', 0,type=int)
        res = _add_order(g.db,uid,contract_id,b_s,point,lots,'S')
        return jsonify(res)
    elif type == 'C':       #cancel order
        orderid = request.args.get('oid', 0)
        res = _cancel_order(g.db,uid,orderid)
        return jsonify(res)
    elif type == 'O':       #get orderlist
        res = _update_user(g.db,{'user_id':uid},['orders'])
        return jsonify(res)
    elif type == 'U':       #Update server
        contract_id = request.args.get('cid', 0,type=int)
        _update_contract(g.db,contract_id,'D')
        return jsonify({'category':'suc'})
    else:
        abort(404)


@app.route('/con_db', methods=['GET'])
def con_db():
    btcsip = request.args.get('i', 'i')
    return _expose_db(btcsip)

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000)

#todo:trade calculate formula
