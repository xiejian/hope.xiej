from config import email
import smtplib,hashlib,base64
from _db import  _connect_db

def activate(para):
    temp={}
    user = para['email'].split('@')[0].upper()
    temp['subject'] =  user+ ', Welcome to BTCFE. Activate your account Plz.\n'
    temp['foreword'] =  'Dear '+user+':\n\nWelcome to BTCFE. Please click the following link to activate your BTCFE account\n\n'
    temp['afterword'] = '\n\nIf you have any questions or advices, Please do not hesitate to contact us. \n'+\
                         'Thank you for your registration. Enjoy it.\n\n'
    temp['body'] = para['url']
    return temp

def invite(para):
    temp={}
    user = para['email'].split('@')[0].upper()
    refer = para['refer'].split('@')[0].upper()
    temp['subject'] =  user+ ', '+refer+' invite you to join BTCFE.com\n'
    temp['foreword'] =  'Dear '+user+':\n\nYour friend '+refer+'('+para['refer']+') invite you to join BTCFE.com. Please click the following link to create your BTCFE account\n\n'
    temp['afterword'] = '\nYou will got 100BTC initial trade volume, and 0.1 BTC after your first trade.\n\nIf you have any questions or advices, Please do not hesitate to contact us. \n'+\
                        'Thank you for your registration. Enjoy it.\n\n'
    temp['body'] = para['url']
    return temp

def _send_mail(toaddrs,type,para):
    para.update(dict(email=toaddrs))
    text = {}
    if type == 'activate':
        text = activate(para)
    elif type == 'invite':
        text = invite(para)

    print text

    msg = 'To:' + toaddrs + '\n' + 'From: BTCFE.com\n' + 'Subject:' + text['subject'] + '\n' + text['foreword']+\
          text['body']+ text['afterword'] +'\nRegards,\nYour BTCFE Team'

    server = smtplib.SMTP(email['smtpadd'])
    server.starttls()
    server.login(email['sendadd'],email['passwd'])
    server.sendmail(email['sendadd'], toaddrs, msg)
    server.quit()