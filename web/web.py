import os,base64,time
from _db import _connect_db
from _data import gv_contract,_update_contract,_update_user,_add_order,_cancel_order,_modify_cont,_delete_cont,_settle_cont
from _user import _activeuser,_activecode,_createuser,_loginuser,_loguser,_vali_cpass,_update_cpass,_change_invitenum,_dercode,_enrcode,_btc_withdraw,_update_pass
from _mail import _send_mail
from _basefunc import validateEmail,myformat
from flask import Flask, request, session, redirect, url_for, abort,render_template, flash, g,jsonify
from _twitter import gv_twt,_update_twt
from __eod import _start_eod_sevice,_stop_eod_sevice,gv_eod_status


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

@app.before_request
def before_request():
    if request.method == "POST" and request.remote_addr not in app.config['INTERNAL_IP']:
        token = session.pop('_csrf_token', None)
        if not token or token != request.form.get('_csrf_token'):
            abort(403)
    g.db  = _connect_db()
    _update_twt()
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
    return render_template('home.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    #flash('You were logged out','suc')
    return redirect(url_for('home'))

@app.route('/twt')
def twt_update():
    global gv_twta,gv_twtt
    [gv_twta,gv_twtt] = _update_twt()
    return  jsonify(twt = [gv_twta,gv_twtt])


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
                _send_mail(request.form['username'],render_template("email/activate.html",para={'user': request.form['username'].split('@')[0].upper(),
                        'url':url_for('register',v=_activecode(g.db,request.form['username']))}))
                    #'activate',{'url':request.url_root+url_for('register',v=_activecode(g.db,request.form['username']))})
                flash('New Account was successfully created','suc')
                return render_template('register.html',type='C')
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
                return render_template('register.html',type='A')
            else:
                abort(401)
        rcode = request.args.get('r', False)
        ref = _dercode(rcode)
        session.update(ref)
    return render_template('register.html',type='O')


@app.route('/trade', methods=['GET','POST'])
def trade():
    if 'user_id' not in session:
        return redirect(url_for('home'))
    if request.method == 'POST':
        if 'b_s' in request.form:   #---Add order---
            res = _add_order(g.db,session,request.form['contract_id'],request.form['b_s'], request.form['point'], request.form['lots'])
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
        g.u = _update_user(g.db,session,['orders','positions'])
        contract_id = request.args.get('c', 0, type=int)
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
                #_send_mail(request.form['email'],'invite',{'url':request.url_root+url_for('register',r = _enrcode(session['user_id'],request.form['email'])),
                #                                           'refer':session['email']})
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
                        request.form['fullname'],session['user_id'],request.form['twitter_id'],request.form['write_fee'],request.form['region'],request.form['sector'],request.form['description'])
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

    g.u=_update_user(g.db,session,['positions','trans','info','rtvol','log'])
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
    return render_template('bitcoin.html')


@app.route('/market', methods=['GET','POST'])
def market():
    g.u=_update_user(g.db,session)
    return render_template('market.html')

@app.route('/contract', methods=['GET'])
def contract():
    cont = request.args.get('c', 0,type=int)
    data = request.args.get('d', 0,type=int)
    if data == 1:
        d = [ [1325548800000,409.40,412.50,409.00,411.23,10794957],
                [1325635200000,410.00,414.68,409.28,413.44,9294444],
                [1325721600000,414.95,418.55,412.67,418.03,9688115],
                [1325808000000,419.77,422.75,419.22,422.40,11370916],
                [1326067200000,425.50,427.75,421.35,421.73,14072256],
                [1326153600000,425.91,426.00,421.50,423.24,9225966],
                [1326240000000,422.68,422.85,419.31,422.55,7685437],
                [1326326400000,422.28,422.90,418.75,421.39,7597273],
                [1326412800000,419.81,419.81,419.81,419.81,0],
                [1326758400000,424.20,425.99,422.96,424.70,8674865],
                [1326844800000,426.96,429.47,426.30,429.11,9885394],
                [1326931200000,430.15,431.37,426.51,427.75,9347779],
                [1327017600000,427.49,427.50,419.75,420.30,14784607],
                [1327276800000,422.67,428.45,422.30,427.41,10930778],
                [1327363200000,425.10,425.10,419.55,420.41,19558473],
                [1327449600000,454.44,454.45,443.73,446.66,34223691],
                [1327536000000,448.36,448.79,443.14,444.63,11579673],
                [1327622400000,444.34,448.48,443.77,447.28,10710233],
                [1327881600000,445.71,453.90,445.39,453.01,13547439],
                [1327968000000,455.59,458.24,453.07,456.48,13996855],
                   [1328054400000,458.41,458.99,455.55,456.19,9644366],
        [1328140800000,455.90,457.17,453.98,455.12,6671221],
        [1328227200000,457.30,460.00,455.56,459.68,10245287],
        [1328486400000,458.38,464.98,458.20,463.97,8917228],
        [1328572800000,465.25,469.75,464.58,468.83,11293609],
        [1328659200000,470.50,476.79,469.70,476.68,14567040],
        [1328745600000,480.76,496.75,480.56,493.17,31579086],
        [1328832000000,490.96,497.62,488.55,493.42,22546425],
        [1329091200000,499.53,503.83,497.09,502.60,18471658],
        [1329177600000,504.66,509.56,502.00,509.46,16497573],
        [1329264000000,514.26,526.29,496.89,497.67,53789720],
        [1329350400000,491.50,504.89,486.63,502.21,33733915],
        [1329436800000,503.11,507.77,500.30,502.12,19135313],
        [1329782400000,506.88,514.85,504.12,514.85,21628057],
        [1329868800000,513.08,515.49,509.07,513.04,17260544],
        [1329955200000,515.08,517.83,509.50,516.39,20286616],
        [1330041600000,519.67,522.90,518.64,522.41,14831415],
        [1330300800000,521.31,528.50,516.28,525.76,19556472],
        [1330387200000,527.96,535.41,525.85,535.41,21442354],
        [1330473600000,541.56,547.61,535.70,542.44,34000054],
               [1330560000000,548.17,548.21,538.77,544.47,24401884],
        [1330646400000,544.24,546.80,542.52,545.18,15418227],
        [1330905600000,545.42,547.48,526.00,533.16,28897169],
        [1330992000000,523.66,533.69,516.22,530.26,28937093],
        [1331078400000,536.80,537.78,523.30,530.69,28518507],
        [1331164800000,534.69,542.99,532.12,541.99,18444389],
        [1331251200000,544.21,547.74,543.11,545.17,14960676],
        [1331510400000,548.98,552.00,547.00,552.00,14545717],
        [1331596800000,557.54,568.18,555.75,568.10,24673237],
        [1331683200000,578.05,594.72,575.40,589.58,50672821],
        [1331769600000,599.61,600.01,578.55,585.56,41416824],
        [1331856000000,584.72,589.20,578.00,585.57,29481697],
        [1332115200000,598.37,601.77,589.05,601.10,32186970],
        [1332201600000,599.51,606.90,582.00,605.96,29166719],
        [1332288000000,602.74,609.65,601.41,602.50,23001482],
        [1332374400000,597.78,604.50,595.53,599.34,22290414],
        [1332460800000,600.49,601.80,594.40,596.05,15374545],
        [1332720000000,599.79,607.15,595.26,606.98,21276317],
        [1332806400000,606.18,616.28,606.06,614.48,21683163],
        [1332892800000,618.38,621.45,610.31,617.62,23409267],
        [1332979200000,612.78,616.56,607.23,609.86,21722776],
        [1333065600000,608.77,610.56,597.94,599.55,26108485],

               [1333324800000,601.83,618.77,600.38,618.63,21369494],
        [1333411200000,627.30,632.21,622.51,629.32,29714508],
        [1333497600000,624.35,625.86,617.00,624.31,20463585],
        [1333584000000,626.98,634.66,623.40,633.68,22902694]
        ]
        return jsonify({'data':d})
    else:
        return render_template('contract.html',c=cont)

@app.route('/index', methods=['GET','POST'])
def index():
    return render_template('index.html')

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
    return render_template('admin.html')

@app.route('/test', methods=['GET','POST'])
def test():
    print request.user_agent
    return render_template('email/activate.html',para={})

if __name__ == '__main__':
    app.run(host='0.0.0.0')


