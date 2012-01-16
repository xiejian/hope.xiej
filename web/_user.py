import hashlib, base64
from config import mykey

def _createuser(db,email,password,referrer):
    cur = db.cursor()
    #check email is not registered
    resrows = cur.execute('SELECT password from users where email=%s', email)
    if resrows > 0:
        return 'Email is existed.'
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    cur.execute("INSERT INTO users(email, password,referrer)VALUES (%s, %s,%s)",[email, c_pass,referrer])
    cur.execute("INSERT INTO btc_action(ACTION,account1,input_dt) VALUES ('createuser',%s,NOW());",[email])
    db.commit()
    cur.close()
    return True

def _activeuser(db,code):
    cur = db.cursor()
    str = code.split('~')
    try:
        d_email = base64.urlsafe_b64decode(str[0].encode('ascii','ignore'))
        resrows = cur.execute('SELECT user_id,password from users where email=%s', d_email)
        if resrows != 1:
            return False
        result = cur.fetchone()
        if str[1] == base64.urlsafe_b64encode(hashlib.sha512(result[1]).digest()):
            cur.execute("UPDATE users SET email_v = 'A' WHERE user_id = %s",result[0])
            db.commit()
            return result[0]
        else:
            return False
    except Exception:
        return  False
    finally:
        cur.close()

def _loginuser(db,email, password):
    cur = db.cursor()
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = cur.execute('SELECT user_id from users where email=%s and password=%s', [email,c_pass])
    if resrows != 1:
        return False
    result = cur.fetchone()
    cur.close()
    return result[0]

def _vali_cpass(db,email, password):
    cur = db.cursor()
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = cur.execute('SELECT password2 from users where email=%s ', [email])
    if resrows != 1:
        return False
    result = cur.fetchone()
    cur.close()
    if result[0] is None or result[0] == c_pass:
        return True
    else:
        return False

def _update_cpass(db,email,password):
    cur = db.cursor()
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    cur.execute("UPDATE users SET password2 = %s WHERE email =%s",[c_pass,email])
    db.commit()
    cur.close()
    return True

def _invite(db,user_id):
    cur = db.cursor()
    cur.execute("UPDATE users SET invite = invite - 1 WHERE user_id =%s",[user_id])
    db.commit()
    cur.close()
    return True

def _loguser(db,user_id,action,ip):
    cur = db.cursor()
    cur.execute("INSERT INTO userlog(user_id,action,ip) VALUES (%s,%s,%s);",[user_id,action,ip])
    db.commit()
    cur.close()


