import hashlib, base64
from flask import g,url_for,request
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
    sendemail(email,'createuser',request.url_root + url_for('validate',code = a_email+'~'+a_pass))
    return True

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