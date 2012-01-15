#this server started by os every 12 hours. notify web server his start and end.
#todo : contract create, open, close, settle, achieve
#todo:账户为负用户的强平,发送E-mail
#todo:更新用户交易量及费率等级。送币等系统活动也可放在这里实现

import urllib2,MySQLdb,atexit
from config import database, web_url

req = urllib2.Request(url=web_url,data='This data is passed to stdin of the CGI')
f = urllib2.urlopen(req)
print f.read()


def open_cont():
    pass

def close_cont():
    pass

def settle_cont():
    pass

def achieve_cont():
    pass

def cal_userinfo():
    pass

def svrexit():
    cursor.close()
    db.commit()
    db.close()
    print  time.strftime('%d_%H:%M',time.localtime(time.time())),'Bitcoin Sync to Mysql Service Stoped.'



if __name__ == "__main__":

    db=MySQLdb.connect(host=database['host'], user=database['user'], passwd=database['passwd'],db=database['db'])
    cursor = db.cursor()
    atexit.register(svrexit)
    cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('serv','B',%s)", btc_url[btc_url.find('@')+1:-1])
    print  time.strftime('%d_%H:%M',time.localtime(time.time())),'Bitcoin Sync to Mysql Service Started.'