# -*- coding: utf-8 -*
#this server started by os every 12 hours. notify web server his start and end.


from _db import _connect_db
import threading,time

#data = {'name':'xiejian','id':3}
NOT = {'B':'S','S':'B'}
EOD_INTERVAL = 60#*60*12
gv_eod_status = 'A'


#contract status: N:New, P:Open Approval, O:Open, C:Close, Q:Settle Approval, S:Settled, A:Achieved, R:rejected
def open_cont():
    rows = cur.execute("UPDATE contract SET status = 'O' WHERE status ='P' and opendate <= NOW() and settledate > NOW()")
    db.commit()
    print rows,'contracts opened.'

def close_cont():
    cur.execute("SELECT contract_id FROM contract WHERE status ='O' and settledate <= NOW()")
    ccur = db.cursor()
    ocur = db.cursor()
    rows = ccur.execute("UPDATE contract SET status = 'C' WHERE status ='O' and settledate <= NOW()")
    db.commit()
    for c in cur.fetchall():
        #cancel all open order; add close order with settlepoint and oppsite b_s in positions
        ccur.execute("SELECT order_id,user_id FROM orders WHERE status in ('N','O') and contract_id = %s",c[0])
        for o in ccur.fetchall():
            ocur.callproc('exchange',(o[0],o[1],'C'))
            print 'Cancel Order',ocur.fetchone()

    ocur.close()
    ccur.close()
    print rows,'contracts closed.'

def settle_cont():
    cur.execute("SELECT contract_id,settlepoint FROM contract WHERE status ='Q' and settlepoint is not null")
    ccur = db.cursor()
    ocur = db.cursor()
    dbres = cur.fetchall()
    for c in dbres:
        #cancel all open order; add close order with settlepoint and oppsite b_s in positions
        ccur.execute("SELECT order_id,user_id FROM orders WHERE status in ('N','O') and contract_id = %s",c[0])
        for o in ccur.fetchall():
            ocur.callproc('exchange',(o[0],o[1],'C'))
            print 'Cancel Order',ocur.fetchone()
        ccur.execute("SELECT user_id,buy_sell,lots FROM v_pos WHERE contract_id = %s",c[0])
        for p in ccur.fetchall():
            ocur.callproc('addorder',(c[0],p[0],NOT[p[1]],c[1],p[2]))
            print 'Add Order',ocur.fetchone()
        print c[0],'Contract Settled at Point',c[1]
    ocur.close()
    ccur.close()
    print len(dbres),"contracts settled."

def achieve_cont():
    pass

def cal_userinfo():
    #todo:u'更新用户交易量及费率等级。送币等系统活动也可放在这里实现'
    pass

def forced_close():
    cur.execute("select user_id,balance + p_l - pmargin,omargin from v_userbtc where balance + p_l - omargin - pmargin < 0")
    ccur = db.cursor()
    ocur = db.cursor()
    for u in cur.fetchall():
        if u[2] > 0:
            #cancel all open order;
            ocur.execute("SELECT order_id FROM orders WHERE status ='O' and type = 'O' and user_id = %s",u[0])
            for o in ocur.fetchall():
                ccur.callproc('exchange',(o[0],u[0],'C'))
                res = ccur.fetchone()
                print res
        elif u[1] <= 0:
            #forced close postion
            ocur.callproc('forced_close',(u[0],-u[1]))
            print 'Forced Close'
        #todo send email to notify user


def eod_process():
    global db,cur,t
    db=_connect_db()
    cur = db.cursor()

    open_cont()
    close_cont()
    settle_cont()
    achieve_cont()
    forced_close()

    t = threading.Timer(EOD_INTERVAL, eod_process)
    t.start()
    print time.strftime('%d_%H:%M',time.localtime(time.time())),'EOD Process Finished.'

def _start_eod_sevice():
    t = threading.Timer(EOD_INTERVAL, eod_process)
    t.start()
    print time.strftime('%d_%H:%M',time.localtime(time.time())),'EOD Service Started.'

def _stop_eod_sevice():
    global t
    t.cancel()
    print time.strftime('%d_%H:%M',time.localtime(time.time())),'EOD Service Stopped.'

if __name__ == '__main__':
    _start_eod_sevice()
    time.sleep(200)
    _stop_eod_sevice()