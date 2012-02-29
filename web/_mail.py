from config import email
import smtplib,threading,re
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


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

class _mailc(threading.Thread):
    def __init__(self,toaddrs,subject,content):
        threading.Thread.__init__(self)
        self.toaddrs = toaddrs
        self.subject = subject
        self.content = content
    def run(self):
        # Create message container - the correct MIME type is multipart/alternative.
        msg = MIMEMultipart('alternative')
        msg['Subject'] = self.subject
        msg['From'] = email['sendadd']
        msg['To'] = self.toaddrs

        # Create the body of the message (a plain-text and an HTML version).
        text = None
        html = self.content
        # Record the MIME types of both parts - text/plain and text/html.
        part1 = MIMEText(text, 'plain')
        part2 = MIMEText(html, 'html')

        # Attach parts into message container.
        # According to RFC 2046, the last part of a multipart message, in this case
        # the HTML message, is best and preferred.
        msg.attach(part1)
        msg.attach(part2)

        # sendmail function takes 3 arguments: sender's address, recipient's address
        # and message to send - here it is sent as one string.
        server = smtplib.SMTP(email['smtpadd'])
        server.ehlo()
        server.starttls()
        server.ehlo()
        server.login(email['sendadd'],email['passwd'])
        server.sendmail(email['sendadd'], self.toaddrs, msg.as_string())
        server.close()
        print (email['sendadd'], self.toaddrs, msg.as_string())


def _send_mailo(toaddrs,type,para):
    para.update(dict(email=toaddrs))
    text = {}
    if type == 'activate':
        text = activate(para)
    elif type == 'invite':
        text = invite(para)

    msg = 'To:' + toaddrs + '\n' + 'From: BTCFE.com\n' + 'Subject:' + text['subject'] + '\n' + text['foreword']+\
          text['body']+ text['afterword'] +'\nRegards,\nYour BTCFE Team'

    smail = _mailc(toaddrs,text['subject'],text['foreword']+text['body']+ text['afterword'])
    smail.start()


def _send_mail(toaddrs,content):

    smail = _mailc(toaddrs,re.findall("<title>(.*?)</title>",content)[0] ,content)

    smail.start()

