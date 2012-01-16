from config import email
import smtplib,hashlib,base64
from _db import  _connect_db


def _send_mail(toaddrs,type,para):

    if type == 'register':
        text = register({'email':toaddrs,'url':para})
    elif type == 'invite':
        text = invite({'email':toaddrs,'url':para})

    msg = 'To:' + toaddrs + '\n' + 'From: BTCFE.com\n' + 'Subject:' + text['subject'] + 'Dear ' + \
          toaddrs.split('@')[0] +':\n\n' + text['foreword']+ text['body']+ text['afterword'] +'\nRegards,\nYour BTCFE Team'

    server = smtplib.SMTP(email['smtpadd'])
    server.starttls()
    server.login(email['sendadd'],email['passwd'])
    server.sendmail(email['sendadd'], toaddrs, msg)
    server.quit()

def register(para):
    text ={
            'subject':  'Welcome to BTCFE. Activate your account Plz.\n',
            'foreword':  'Welcome to BTCFE. Please click the following link to activate your BTCFE account\n\n',
            'afterword': '\n\nIf you have any questions or advices, Please do not hesitate to contact us. \n'+\
                         'Thank you for your registration. Enjoy it.\n\n'
        }
    db = _connect_db()
    cur = db.cursor()
    resrows = cur.execute('SELECT password from users where email=%s', para['email'])
    if resrows != 1:
        return False
    c_pass = cur.fetchone()[0]
    a_email = base64.urlsafe_b64encode(para['email'])
    a_pass = base64.urlsafe_b64encode(hashlib.sha512(c_pass).digest())
    text['body'] = para['url'] +'?v=' + a_email+'~'+a_pass
    return text

def invite(para):

    text ={
        'subject':  'Welcome to BTCFE. Activate your account Plz.\n',
        'foreword':  'Welcome to BTCFE. Please click the following link to create your BTCFE account\n\n',
        'afterword': '\nYou will get \nIf you have any questions or advices, Please do not hesitate to contact us. \n'+\
                     'Thank you for your registration. Enjoy it.\n\n'
    }
    #todo send invite email
    text['subject'] = 'Invite you join BTCFE.com'

    text['body'] = para['url'] +'?v=' + a_email+'~'+a_pass
    return text

    pass