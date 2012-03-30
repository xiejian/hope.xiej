# -*- coding: utf-8 -*
#this server started by os every 12 hours. notify web server his start and end.

import threading,time,datetime
from _db import _connect_db
from _data import _update_contract

#data = {'name':'xiejian','id':3}
NOT = {'B':'S','S':'B'}
EOD_INTERVAL = 60#*60*12
gv_eod_status = 'A'
#todo add the number of users' invite based usr's activity,or balance movement. when invite num = 0, +1;  3 + .5 5 + .3 10. + .1


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
            ocur.callproc('p_exchange',(o[0],o[1],'C'))
            print 'Cancel Order',ocur.fetchone()

    ocur.close()
    ccur.close()
    print rows,'contracts closed.'

def settle_cont():
    cur.execute("SELECT contract_id,settlepoint,settlemargin,owner FROM contract WHERE status ='Q' and settlepoint is not null")
    ccur = db.cursor()
    ocur = db.cursor()
    dbres = cur.fetchall()
    for c in dbres:
        #cancel all open order; add close order with settlepoint and oppsite b_s in positions
        ccur.execute("SELECT order_id,user_id FROM orders WHERE status in ('N','O') and contract_id = %s",c[0])
        for o in ccur.fetchall():
            ocur.callproc('p_exchange',(o[0],o[1],'C'))
            print 'Cancel Order',ocur.fetchone()
            ocur.nextset()
        ccur.execute("SELECT user_id,buy_sell,lots FROM v_pos WHERE contract_id = %s",c[0])
        for p in ccur.fetchall():
            ocur.callproc('p_addorder',(c[0],p[0],NOT[p[1]],c[1],p[2]))
            print 'Add Order',ocur.fetchall()
            ocur.nextset()

        ccur.execute(" insert into btc_action(action,account1,account2,address,amount,trans_id,type,input_dt) \
            select 'move',email,'FEE','settle', %s,%s,'C',NOW() from users where user_id =%s",(-1*c[2],c[0],c[3]))
        ccur.execute("UPDATE contract SET status = 'S',settlemargin = 0 WHERE status ='Q' and contract_id = %s",c[0])

        print c[0],'Contract Settled at Point',c[1]
    ocur.close()
    ccur.close()
    print len(dbres),"contracts settled."

def achieve_cont():
    #todo achieve old contracts
    pass

def cal_userinfo():
    pass

def update_feerate():
    rows = cur.execute("update users u left join v_tradevol v on u.user_id=v.user_id set u.feerate = f_FRATE(v.tradevol)")
    db.commit()
    print rows,'user fee rate updated.'

def return_fee():
    cur.callproc('p_eod')
    cur.callproc('p_eom')
    print 'EOD','EOM'


def balance2date(balance2dt):
    cur.execute("select max(balance_dt) from userbalance;")
    res = cur.fetchone()
    if res[0] is None:
        balance_dt = datetime.date(2011,10,31)
    else:
        balance_dt = res[0]
    if balance2dt > balance_dt:

        rows=cur.execute("insert into userbalance(user_id,balance_dt) \
                    select g.user_id,convert(%s,date) from v_gl g where DATE_FORMAT(g.timestamp, '%%Y-%%m-%%d') > convert(%s,date)  \
                     and DATE_FORMAT(g.timestamp, '%%Y-%%m-%%d') <= convert(%s,date) group by g.user_id having g.user_id not in \
                    (select b.user_id from userbalance b);",[balance_dt,balance_dt,balance2dt])

        rown=cur.execute("insert into userbalance(user_id,balance_dt,balance,bal_fee,bal_pl,bal_btc,trade_vol) \
                    select g.user_id,convert(%s,date),ifnull(sum(g.fee),0)+ifnull(sum(g.p_l),0)+ifnull(sum(g.btc),0)+ifnull(b.balance,0),\
                    ifnull(sum(g.fee),0)+ifnull(b.bal_fee,0),ifnull(sum(g.p_l),0)+ifnull(b.bal_pl,0),ifnull(sum(g.btc),0)+ifnull(b.bal_btc,0), \
                        ifnull(sum(g.value),0) from v_gl g left join userbalance b on g.user_id = b.user_id \
                        WHERE b.balance_dt = convert(%s,date) and DATE_FORMAT(g.timestamp, '%%Y-%%m-%%d') > convert(%s,date)  \
                        and DATE_FORMAT(g.timestamp, '%%Y-%%m-%%d') <= convert(%s,date) \
                        group by g.user_id;",[balance2dt,balance_dt,balance_dt,balance2dt])
        db.commit()

        print rows,'/',rown, 'Users Balance Updated'

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
            ocur.callproc('p_forced_close',(u[0],-u[1]))
            print ocur.fetchone(),'btc Forced Close remained'
        #todo send email to notify user
    db.commit()


def eod_process():
    global db,cur,t,gv_contract
    db=_connect_db()
    cur = db.cursor()

    forced_close()
    open_cont()
    close_cont()
    return_fee()
    settle_cont()
    achieve_cont()

    update_feerate()
    balance2date(datetime.date.today()-datetime.timedelta(1))

    _update_contract(db)

    cur.close()
    db.close()

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
    #_start_eod_sevice()
    #time.sleep(200)
    #_stop_eod_sevice()
    eod_process()