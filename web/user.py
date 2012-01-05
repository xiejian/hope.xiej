import hashlib, base64
from flask import g,url_for,request,session
from config import mykey
from basefunc import sendemail

def createuser(email, password):
    #check email is not registered
    resrows = g.cur.execute('SELECT password from user where email=%s', email)
    if resrows > 0:
        return 'Email is existed.'
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    g.cur.execute("INSERT INTO user(email, password)VALUES (%s, %s)",[email, c_pass])
    g.cur.execute("INSERT INTO btc_action(ACTION,account1,input_dt) VALUES ('createuser',%s,NOW());",[email])
    g.db.commit()
    a_email = base64.b32encode(email)
    a_pass = base64.b32encode(hashlib.sha512(c_pass).digest())
    sendemail(email,'createuser',request.url_root + url_for('register',v = a_email+'~'+a_pass))
    return True

def get_userinfo(u_id=0):    #get user's info
    temp = {}
    if not u_id:
        u_id = session['user_id']
    g.cur.execute("SELECT user_id,email,email_v,feerate FROM user WHERE user_id = %s",u_id)
    row = g.cur.fetchone()
    temp.update(dict(user_id=row[0],email=row[1],email_v=row[2],feerate=row[3]))
    g.cur.execute("SELECT balance,bal_unconf,bal_unact,bal_avail FROM v_btcbal WHERE user_id = %s",u_id)
    row = g.cur.fetchone()
    temp.update(dict(balance=str(row[0]),bal_unconf=str(row[1]),bal_unact=str(row[2]),bal_avail=str(row[3])))
    g.cur.execute("SELECT order_id,contract_id,buy_sell,price,lots,rm_lots,type,DATE_FORMAT(createtime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM orders WHERE STATUS = 'O' AND user_id = %s",u_id)
    orders = [dict(order_id=row[0],contract_id=row[1],buy_sell=row[2],price=str(row[3]),lots=row[4],rm_lots=row[5],type=row[6],createtime=row[7]) for row in g.cur.fetchall()]
    temp.update(dict(orders = orders))
    g.cur.execute("SELECT position_id,contract_id,buy_sell,price,lots,DATE_FORMAT(opentime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM positions WHERE user_id = %s",u_id)
    positions = [dict(position_id=row[0],contract_id=row[1],buy_sell=row[2],price=str(row[3]),lots=row[4],opentime=row[5]) for row in g.cur.fetchall()]
    temp.update({'positions':positions})
    return temp

def get_uncover_pos(contract_id,b_s):
    num = 0
    for p in session['positions']:
        if p['contract_id'] == contract_id and p['buy_sell'] != b_s:
            num += p['lots']
    for o in session['orders']:
        if o['contract_id'] == contract_id and o['contract_id'] == b_s and o['type'] == 'C':
            num -= o['rm_lots']
    return num
def check_usersorder(order_id):
    for o in session['orders']:
        if o['order_id'] == order_id:
            return True
    return False

def activeuser(code):
    str = code.split('~')
    try:
        d_email = base64.b32decode(str[0])
        resrows = g.cur.execute('SELECT user_id,password from user where email=%s', d_email)
        if resrows != 1:
            return False
        result = g.cur.fetchone()
        if str[1] == base64.b32encode(hashlib.sha512(result[1]).digest()):
            g.cur.execute("UPDATE user SET email_v = 'A' WHERE user_id = %s",result[0])
            g.db.commit()
            return result[0]
        else:
            return False
    except Exception:
        return  False

def loginuser(email, password):
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = g.cur.execute('SELECT user_id from user where email=%s and password=%s', [email,c_pass])
    if resrows != 1:
        return False
    result = g.cur.fetchone()
    return result[0]