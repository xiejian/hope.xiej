import hashlib, base64,decimal
from config import mykey,newuserBTC

def _createuser(db,email,password,referrer):
    cur = db.cursor()
    #check email is not registered
    resrows = cur.execute('SELECT password from users where email=%s', email)
    if resrows > 0:
        return 'Email is registered.'
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    cur.execute("INSERT INTO users(email, password,referrer)VALUES (%s, %s,%s)",[email, c_pass,referrer])
    if referrer:
        cur.execute("INSERT INTO userattr(type,user_id,coupon,month,comment,create_dt) VALUES \
                    ('C',LAST_INSERT_ID(),0.1,DATE_FORMAT(now(),'%Y-%m'),'Invited Sign Up',NOW()), \
                    ('C',LAST_INSERT_ID(),0.1,DATE_FORMAT(NOW() + interval + 1 month,'%Y-%m'),'Invited Sign Up',NOW()), \
                    ('C',LAST_INSERT_ID(),0.1,DATE_FORMAT(NOW() + interval + 2 month,'%Y-%m'),'Invited Sign Up',NOW()), \
                    ('C',LAST_INSERT_ID(),0.1,DATE_FORMAT(NOW() + interval + 3 month,'%Y-%m'),'Invited Sign Up',NOW()), \
                    ('C',LAST_INSERT_ID(),0.1,DATE_FORMAT(NOW() + interval + 4 month,'%Y-%m'),'Invited Sign Up',NOW()), \
                    ('C',LAST_INSERT_ID(),0.1,DATE_FORMAT(NOW() + interval + 5 month,'%Y-%m'),'Invited Sign Up',NOW());")
    cur.execute("INSERT INTO btc_action(ACTION,account1,input_dt) VALUES ('createuser',%s,NOW());",[email])
    db.commit()
    cur.close()
    return True

def _activeuser(db,code):
    cur = db.cursor()
    try:
        str = code.split('~')
        d_email = base64.urlsafe_b64decode(str[0].encode('ascii','ignore'))
        resrows = cur.execute('SELECT user_id,password,referrer from users where email_v = "N" and email=%s', d_email)
        if resrows != 1:
            return False
        result = cur.fetchone()
        if str[1] == base64.urlsafe_b64encode(hashlib.sha512(result[1]).digest()):
            cur.execute("UPDATE users SET email_v = 'Y' WHERE user_id = %s",result[0])
            _change_invitenum(db,result[0],3)
            _change_invitenum(db,result[2],1)
            # new user get 0.1 BTC for free
            cur.execute("insert into btc_action(action,account1,account2,address,amount,type,input_dt) values( 'move',%s,'FEE','sign up', %s,'A',NOW())",(d_email,-1*newuserBTC))
            db.commit()
            return result[0],d_email
        else:
            return False
    except Exception:
        return  False
    finally:
        cur.close()


def _activecode(db,email):
    cur = db.cursor()
    resrows = cur.execute('SELECT password from users where email=%s', email)
    if resrows != 1:
        return False
    c_pass = cur.fetchone()[0]
    a_email = base64.urlsafe_b64encode(email)
    a_pass = base64.urlsafe_b64encode(hashlib.sha512(c_pass).digest())
    cur.close()
    return a_email+'~'+a_pass

def _loginuser(db,email, password):
    cur = db.cursor()
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    resrows = cur.execute('SELECT user_id from users where email=%s and password=%s', [email,c_pass])
    if resrows != 1:
        return False
    result = cur.fetchone()
    cur.close()
    return result[0]

def _update_pass(db,email,password):
    cur = db.cursor()
    c_pass = base64.b64encode(hashlib.sha224(mykey + email + password).digest())
    cur.execute("UPDATE users SET password=%s WHERE email = %s;",[c_pass,email])
    db.commit()
    cur.close()

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

def _change_invitenum(db,user_id,num):
    cur = db.cursor()
    rows = cur.execute("UPDATE users SET invite = invite + %s WHERE invite + %s >=0 and user_id =%s",[num,num,user_id])
    db.commit()
    cur.close()
    if rows >= 1:
        return True
    else:
        return False

def _loguser(db,user_id,action,ip):
    cur = db.cursor()
    cur.execute("SELECT userlog_id,action,ip FROM userlog WHERE user_id = %s ORDER BY timestamp DESC LIMIT 0,1",[user_id])
    res = cur.fetchone()
    if res and res[1]==action and res[2] ==ip:
        cur.execute("UPDATE userlog SET times = times +1 WHERE userlog_id = %s",[res[0]])
    else:
        cur.execute("INSERT INTO userlog(user_id,action,ip) VALUES (%s,%s,%s);",[user_id,action,ip])
    db.commit()
    cur.close()

def _btc_withdraw(db,email,btc_add,amount,passwd,cpass):
    user_id = _loginuser(db,email,passwd)
    if user_id and _vali_cpass(db,email,cpass):
        cur = db.cursor()
        cur.execute("select count(1) from btc_trans where type = 'receive' and user= %s",email)
        newu = cur.fetchone()

        cur.execute("SELECT balance - omargin - pmargin + p_l,balance - omargin - pmargin FROM v_userbtc WHERE user_id = %s",user_id)
        btc_avail = cur.fetchone()
        if btc_avail[0] - decimal.Decimal(amount) <0:
            cur.close()
            return {'msg':"Available Bitcoin is not enough.",'category':'err'}
        elif btc_avail[1] - decimal.Decimal(amount)<0:
            cur.close()
            return {'msg':"Realize your holding's P/L before withdraw.",'category':'err'}
        elif newu[0] ==0 and (btc_avail[0] - decimal.Decimal(amount) <newuserBTC or btc_avail[1] - decimal.Decimal(amount)<newuserBTC):
            cur.close()
            return {'msg':"Have more activities before withdraw.",'category':'err'}
        else:
            cur.execute("insert into btc_action(action,account1,address,amount,type,input_dt) values ('sendfrom',%s,%s,%s,'W',NOW());"
            ,(email,btc_add,amount))
            db.commit()
            cur.close()
            return {'msg':"Withdraw "+amount+" Btc Successfully",'category':'suc'}
    else:
        return {'msg':"Password is not correct.",'category':'err'}

def _dercode(code):
    try:
        str = code.split('~')
        referrer = base64.urlsafe_b64decode(str[0].encode('ascii','ignore'))
        d_email = base64.urlsafe_b64decode(str[1].encode('ascii','ignore'))
        return dict(referrer=referrer,email=d_email)
    except Exception:
        return dict(referrer=0,email='')

def _enrcode(user_id,email):
    a_user = base64.urlsafe_b64encode(str(user_id))
    a_email = base64.urlsafe_b64encode(email)
    return a_user + '~' + a_email
