import hashlib, base64
from flask import g

def createuser(email, password):
    #check email is not registered
    resrows = g.db.cursor().execute('SELECT password from user where email=%s', email)
    if resrows > 0:
        return False
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = g.db.cursor().execute("INSERT INTO user(email, password)VALUES (%s, %s,%s)",[email, c_pass])
    if resrows==1:
        return True
    else:
        return False

def loginuser(email, password):
    resrows = g.db.cursor().execute('SELECT user_id,password from user where email=%s', email)
    if resrows != 1:
        return False
    result = g.db.cursor().fetchall()
    c_pass = base64.b64encode(hashlib.sha224(mykey, email + password).digest())
    if c_pass == result[0][1]:
        return result[0][0]
    else:
        return False