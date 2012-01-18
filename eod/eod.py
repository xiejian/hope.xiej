# -*- coding: utf-8 -*
#this server started by os every 12 hours. notify web server his start and end.
#todo : contract create, open, close, settle, achieve
#todo:u'账户为负用户的强平,发送E-mail'
#todo:u'更新用户交易量及费率等级。送币等系统活动也可放在这里实现'

import urllib,urllib2,MySQLdb,atexit,time
from config import database, web_url

data = {'name':'xiejian','id':3}

req = urllib2.Request(web_url,urllib.urlencode(data))
f = urllib2.urlopen(req)
print f.read()

#contract status: N: New, P: Approval, O: Open, C: Close, S: Settled, A:Achieved
def open_cont():
    rows = cur.execute("UPDATE contracts SET status = 'O' WHERE status ='P' and opendate <= NOW() and settledate > NOW()")
    print rows,'contract opened.'

def close_cont():
    rows = cur.execute("UPDATE contracts SET status = 'C' WHERE status ='O' and settledate <= NOW()")
    #todo cancel all orders
    print rows,'contract closed.'

def settle_cont():
    pass

def achieve_cont():
    pass

def cal_userinfo():
    pass

def svrstart():
    pass

def svrexit():
    cur.close()
    db.commit()
    db.close()
    print  time.strftime('%d_%H:%M',time.localtime(time.time())),'BTCFE EOD Service Stoped.'

if __name__ == "__main__":

    db=MySQLdb.connect(host=database['host'], user=database['user'], passwd=database['passwd'],db=database['db'])
    cur = db.cursor()
    atexit.register(svrexit)
    cur.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('serv','B',%s)", btc_url[btc_url.find('@')+1:-1])
    print  time.strftime('%d_%H:%M',time.localtime(time.time())),'Bitcoin Sync to Mysql Service Started.'