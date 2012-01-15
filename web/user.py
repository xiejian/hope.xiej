import hashlib, base64
from flask import g,url_for,request
from config import mykey
from basefunc import sendemail

def createuser(email, password,referrer):
    #check email is not registered
    resrows = g.cur.execute('SELECT password from users where email=%s', email)
    if resrows > 0:
        return 'Email is existed.'
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    g.cur.execute("INSERT INTO users(email, password,referrer)VALUES (%s, %s,%s)",[email, c_pass,referrer])
    g.cur.execute("INSERT INTO btc_action(ACTION,account1,input_dt) VALUES ('createuser',%s,NOW());",[email])
    g.db.commit()
    a_email = base64.b32encode(email)
    a_pass = base64.b32encode(hashlib.sha512(c_pass).digest())
    sendemail(email,'createuser',request.url_root + url_for('register',v = a_email+'~'+a_pass))
    return True

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

def loguser(user_id,action):

    g.cur.execute("INSERT INTO userlog(user_id,action,ip) VALUES (%s,%s);",[user_id,action,request.remote_addr])


def referrurl(user_id):
    return request.url_root + url_for('register',r = base64.b32encode(str(user_id)))

def getrefer(rcode):
    try:
        refer = base64.b32decode(rcode)
        return refer
    except Exception:
        return 0
