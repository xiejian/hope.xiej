from _db import  _connect_db

gv_contract = {}    #global vars of contract info


def _update_contract(g,cid = 'contract_id',type='D'):
    if type == 'C':
            #no deal made, just update order queues
        g.cur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime LIMIT 0,10",row[0])
        gv_contract[row[0]]['B'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in g.cur.fetchall()]
        g.cur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY point ,createtime LIMIT 0,10",row[0])
        gv_contract[row[0]]['S'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in g.cur.fetchall()]
    else:   #deals had been made, update all
        ocur = g.db.cursor()
        g.cur.execute("SELECT contract_id,concat(name,DATE_FORMAT(settledate,'%y%m')),status,btc_multi,DATE_FORMAT(opendate,'%Y-%m-%d'), \
                    latestpoint,DATE_FORMAT(settledate,'%Y-%m-%d'),leverage,discription FROM contract WHERE STATUS = 'O' AND contract_id ="+str(cid))
        for row in g.cur.fetchall():
            gv_contract[row[0]] = dict(name=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=row[6],leverage=row[7],discription=row[8])
            #update order queues
            ocur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['B'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in ocur.fetchall()]
            ocur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY point ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['S'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in ocur.fetchall()]
            #update transactions history
            ocur.execute("SELECT t.point,t.lots,DATE_FORMAT(TIMESTAMP,'%%d/%%H:%%m'),direct FROM trans t,orders o WHERE t.buy_oid = o.order_id AND o.contract_id = %s ORDER BY TIMESTAMP DESC LIMIT 0,5",row[0])
            gv_contract[row[0]]['T'] = [dict(point=orow[0],lots=orow[1],time=orow[2],dir=orow[3]) for orow in ocur.fetchall()]


def _update_user(g,session,content = []):    #get user's info
    if 'user_id' not in session:
        return dict(balance=0,bal_unconf=0,bal_unact=0,omargin=0,pmargin=0)
    temp = {}
    g.cur.execute("SELECT b.balance + IFNULL(a.amount,0),b.bal_unconf,IFNULL(a.amount,0) FROM btc_account b left JOIN v_btcunact a ON b.account = a.account WHERE b.account = %s",session['email'])
    row = g.cur.fetchone()
    if row is None:
        row = [0,0,0]
    temp.update(dict(balance=str(row[0]),bal_unconf=str(row[1]),bal_unact=str(row[2]),orders=[],positions=[]))
    # get user's orders info
    g.cur.execute("SELECT order_id,contract_id,buy_sell,point,lots,rm_lots,type,DATE_FORMAT(createtime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM orders WHERE STATUS = 'O' AND user_id = %s",session['user_id'])
    for row in g.cur.fetchall():
        tt=dict(order_id=row[0],contract_id=row[1],buy_sell=row[2],point=row[3],lots=row[4],rm_lots=row[5],type=row[6],\
            value=row[3]*row[5]*gv_contract[row[1]]['btc_multi'],createtime=row[7])
        if row[6] == 'O':
            tt.update(dict(margin = row[3]*row[5]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage']))
        else:
            tt.update(dict(margin = 0))
        temp['orders'].append(tt)
    # get user's positions info
    g.cur.execute("SELECT position_id,contract_id,buy_sell,point,lots,DATE_FORMAT(opentime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM positions WHERE user_id = %s",session['user_id'])
    for row in g.cur.fetchall():
        tt = dict(contract_id=row[1],buy_sell=row[2],point=row[3],lots=row[4],opentime=row[5],marketvalue=gv_contract[row[1]]['latestpoint']*row[4]*gv_contract[row[1]]['btc_multi'],
            margin = row[3]*row[4]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage'])
        if row[2] == 'B':
            tt.update(dict(p_l = (gv_contract[row[1]]['latestpoint']-row[3])*row[4]*gv_contract[row[1]]['btc_multi']))
        else:
            tt.update(dict(p_l = (row[3]-gv_contract[row[1]]['latestpoint'])*row[4]*gv_contract[row[1]]['btc_multi']))
        temp['positions'].append(tt)

    if 'trans' in content:
        g.cur.execute("SELECT contract_id,type,buy_sell, point,lots,fee,p_l,timestamp from v_trans WHERE user_id = %s ORDER BY timestamp DESC LIMIT 0,10",session['user_id'])
        trans = [dict(contract_id=row[0],type=row[1],buy_sell=row[2], point=row[3],lots=row[4],fee=row[5],p_l=row[6],timestamp=row[7]) for row in g.cur.fetchall()]
        temp.update({'trans':trans})
    if 'btcflow' in content:
        g.cur.execute("SELECT account1,input_dt,type,trans_id,amount FROM btc_action WHERE account1 = %s ORDER BY input_dt DESC LIMIT 0,10",session['email'])
        g.userbtcflow = [dict(account=row[0],input_dt=row[1],type=row[2], trans_id=row[3],amount=row[4]) for row in g.cur.fetchall()]
    if 'address' in content:
        g.cur.execute("SELECT address FROM btc_account WHERE account = %s",session['email'])
        temp.update(dict(address=g.cur.fetchone()[0]))
    return temp


def _add_order(g,session,contract_id,b_s,c_o,point,lots):
    g.cur.callproc('addorder',(contract_id,session['user_id'],b_s,c_o,point,lots))
    result = g.cur.fetchone()
    if result is None:
        return {'msg':'None','category':'err'}
    return dict(msg=result[1],category=result[0])

def _cancel_order(g,orderid):
    g.cur.callproc('exchange',(orderid,'C'))
    result = g.cur.fetchone()
    return result

if __name__ == "__main__":
    class g:
        db = _connect_db()
        cur = db.cursor()
    g = g
    session = {'user_id':28,'email':'jian.xie@163.com','btc_avail':0}

    a = _update_contract(g)
    b = _update_user(g,session)
    print b