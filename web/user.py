import hashlib, base64
from flask import g,url_for,request,session
from config import mykey
from basefunc import sendemail

def createuser(email, password):
    #check email is not registered
    resrows = g.cur.execute('SELECT password from users where email=%s', email)
    if resrows > 0:
        return 'Email is existed.'
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    g.cur.execute("INSERT INTO users(email, password)VALUES (%s, %s)",[email, c_pass])
    g.cur.execute("INSERT INTO btc_action(ACTION,account1,input_dt) VALUES ('createuser',%s,NOW());",[email])
    g.db.commit()
    a_email = base64.b32encode(email)
    a_pass = base64.b32encode(hashlib.sha512(c_pass).digest())
    sendemail(email,'createuser',request.url_root + url_for('register',v = a_email+'~'+a_pass))
    return True


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
        resrows = g.cur.execute('SELECT user_id,password from users where email=%s', d_email)
        if resrows != 1:
            return False
        result = g.cur.fetchone()
        if str[1] == base64.b32encode(hashlib.sha512(result[1]).digest()):
            g.cur.execute("UPDATE users SET email_v = 'A' WHERE user_id = %s",result[0])
            g.db.commit()
            return result[0]
        else:
            return False
    except Exception:
        return  False

def loginuser(email, password):
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = g.cur.execute('SELECT user_id from users where email=%s and password=%s', [email,c_pass])
    if resrows != 1:
        return False
    result = g.cur.fetchone()
    return result[0]