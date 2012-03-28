# -*- coding: utf-8 -*
#this server started by os every 12 hours. notify web server his start and end.

import urllib,urllib2,MySQLdb,atexit,time
from config import database, web_url

data = {'name':'xiejian','id':3}

NOT = {'B':'S','S':'B'}

req = urllib2.Request(web_url,urllib.urlencode(data))
f = urllib2.urlopen(req)
print f.read()

#contract status: N:New, P:Open Approval, O:Open, C:Close, Q:Settle Approval, S:Settled, A:Achieved, R:rejected
def open_cont():
    rows = cur.execute("UPDATE contracts SET status = 'O' WHERE status ='P' and opendate <= NOW() and settledate > NOW()")
    print rows,'contracts opened.'

def close_cont():
    rows = cur.execute("UPDATE contracts SET status = 'C' WHERE status ='O' and settledate <= NOW()")
    print rows,'contracts closed.'

def settle_cont():
    cur.execute("SELECT contract_id,settlepoint FROM contracts WHERE status ='Q' and settlepoint is not null")
    ccur = db.cursor()
    ocur = db.cursor()
    for c in cur.fetchall():
        #cancel all open order; add close order with settlepoint and oppsite b_s in positions
        ccur.execute("SELECT order_id,user_id FROM orders WHERE status in ('N','O') and contract_id = %s",c[0])
        for o in ccur.fetchall():
            ocur.callproc('exchange',(o[0],o[1],'C'))
            print 'Cancel Order',ocur.fetchone()
        ccur.execute("SELECT user_id,buy_sell,lots FROM v_pos WHERE contract_id = %s",c[0])
        for p in ccur.fetchall():
            ocur.callproc('p_addorder',(c[0],p[0],NOT[p[1]],c[1],p[2]))
            print 'Add Order',ocur.fetchone()
        print c[0],'Contract Settled at Point',c[1]
    ocur.close()
    ccur.close()

def achieve_cont():
    pass

def cal_userinfo():
    pass

def forced_close():
    cur.execute("select user_id,balance + p_l - pmargin,omargin from v_userbtc where balance + p_l - omargin - pmargin <= 0")
    ccur = db.cursor()
    ocur = db.cursor()
    for u in cur.fetchall():
        if u[2] > 0:
            #cancel all open order;
            ocur.execute("SELECT order_id FROM orders WHERE status ='O' and type = 'O' and user_id = %s",u[0])
            for o in ocur.fetchall():
                ccur.callproc('exchange',(o[0],u[0],'C'))
                print 'Cancel Order',ccur.fetchone()
        elif u[1] <= 0:
            #forced close postion
            ocur.callproc('forced_close',(u[0],-u[1]))
            print 'Forced Close',ccur.fetchone()


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