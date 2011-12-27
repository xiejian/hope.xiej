import hashlib, base64,config
from flask import g
from config import mykey
from basefunc import sendemail

def createuser(email, password):
    #check email is not registered
    resrows = g.cur.execute('SELECT password from user where email=%s', email)
    if resrows > 0:
        return 'Email is existed.'
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = g.cur.execute("INSERT INTO user(email, password)VALUES (%s, %s)",[email, c_pass])
    g.cur.execute("INSERT INTO btc_action(ACTION,account1,input_dt) VALUES ('createuser',%s,NOW());",[email])
    g.db.commit()
    sendemail(email,'createuser',c_pass)
    return True


def loginuser(email, password):
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = g.cur.execute('SELECT user_id from user where email=%s and password=%s', [email,c_pass])
    if resrows != 1:
        return False
    result = g.cur.fetchone()
    return result[0]