import re, smtplib
from config import email, mailmsg

def validateEmail(email):
    if len(email) > 6:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) != None:
            return True
    return False


def sendemail(toaddrs,type,para):
    if type == 'createuser':
        msg = mailmsg['createuser']


    server = smtplib.SMTP(email['smtpadd'])
    server.starttls()
    server.login(email['sendadd'],email['passwd'])
    server.sendmail(email['username'], toaddrs, msg)
    server.quit()
