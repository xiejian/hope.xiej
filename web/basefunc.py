import re, smtplib,os,base64
from config import email
from flask import session

def generate_csrf_token():
    if '_csrf_token' not in session:
        session['_csrf_token'] =  base64.urlsafe_b64encode(os.urandom(8))
    return session['_csrf_token']


def validateEmail(email):
    if len(email) > 6:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) is not None:
            return True
    return False


def sendemail(toaddrs,type,para):
    msg = 'To:' + toaddrs + '\n' + 'From: BTCFE.com\n' + 'Subject:' + email['msg'][type]['subject']
    msg = msg + 'Dear ' + toaddrs.split('@')[0] +'\n\n'
    msg = msg + email['msg'][type]['foreword'] + para + email['msg'][type]['afterword']

    server = smtplib.SMTP(email['smtpadd'])
    server.starttls()
    server.login(email['sendadd'],email['passwd'])
    server.sendmail(email['sendadd'], toaddrs, msg)
    server.quit()

def addordercheck(contract_id,point,lots):
    if True:# * lots * gv_contract[contract_id]['btc_multi'] < session['btc_vail']:
        return True
    else:
        return False