from config import email
import smtplib,threading,re
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


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
        #print (email['sendadd'], self.toaddrs, msg.as_string())


def _send_mail(toaddrs,content):

    smail = _mailc(toaddrs,re.findall("<title>(.*?)</title>",content)[0] ,content)

    smail.start()

