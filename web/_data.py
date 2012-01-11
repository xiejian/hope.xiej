from _db import  _connect_db

gv_contract = {}    #global vars of contract info


def _update_contract(db,cid = 'contract_id',type='D'):
    cur = db.cursor()
    if type == 'C' and long(cid) in gv_contract:
            #no deal made, just update order queues
        cur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime LIMIT 0,10",cid)
        temp['B'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in cur.fetchall()]
        cur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY point ,createtime LIMIT 0,10",cid)
        temp['S'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in cur.fetchall()]
        gv_contract.update(cid = temp)
    else:   #deals had been made, update all
        ocur = db.cursor()
        cur.execute("SELECT contract_id,concat(name,DATE_FORMAT(settledate,'%y%m')),status,btc_multi,DATE_FORMAT(opendate,'%Y-%m-%d'), \
                    latestpoint,DATE_FORMAT(settledate,'%Y-%m-%d'),leverage,discription FROM contract WHERE STATUS = 'O' AND contract_id ="+str(cid))
        for row in cur.fetchall():
            gv_contract[row[0]] = dict(name=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=row[6],leverage=row[7],discription=row[8])
            #update order queues
            ocur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['B'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in ocur.fetchall()]
            ocur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY point ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['S'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in ocur.fetchall()]
            #update transactions history
            ocur.execute("SELECT t.point,t.lots,DATE_FORMAT(TIMESTAMP,'%%d/%%H:%%m'),direct FROM trans t,orders o WHERE t.buy_oid = o.order_id AND o.contract_id = %s ORDER BY TIMESTAMP DESC LIMIT 0,5",row[0])
            gv_contract[row[0]]['T'] = [dict(point=orow[0],lots=orow[1],time=orow[2],dir=orow[3]) for orow in ocur.fetchall()]
        ocur.close()
    cur.close()


def _update_user(db,session,content = []):    #get user's info
    if 'user_id' not in session:
        return dict(balance=0,bal_unconf=0,bal_unact=0,omargin=0,pmargin=0)
    temp = {}
    cur = db.cursor()
    cur.execute("SELECT b.balance + IFNULL(a.amount,0),b.bal_unconf,IFNULL(a.amount,0) FROM btc_account b left JOIN v_btcunact a ON b.account = a.account WHERE b.account = %s",session['email'])
    row = cur.fetchone()
    if row is None:
        row = [0,0,0]
    temp.update(dict(balance=str(row[0]),bal_unconf=str(row[1]),bal_unact=str(row[2]),orders=[],positions=[]))
    # get user's orders info
    cur.execute("SELECT order_id,contract_id,buy_sell,point,lots,rm_lots,type,DATE_FORMAT(createtime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM orders WHERE STATUS = 'O' AND user_id = %s",session['user_id'])
    for row in cur.fetchall():
        tt=dict(order_id=row[0],contract_id=row[1],buy_sell=row[2],point=row[3],lots=row[4],rm_lots=row[5],type=row[6],\
            value=row[3]*row[5]*gv_contract[row[1]]['btc_multi'],createtime=row[7])
        if row[6] == 'O':
            tt.update(dict(margin = row[3]*row[5]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage']))
        else:
            tt.update(dict(margin = 0))
        temp['orders'].append(tt)
    # get user's positions info
    cur.execute("SELECT position_id,contract_id,buy_sell,point,lots,DATE_FORMAT(opentime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM positions WHERE user_id = %s",session['user_id'])
    for row in cur.fetchall():
        tt = dict(contract_id=row[1],buy_sell=row[2],point=row[3],lots=row[4],opentime=row[5],marketvalue=gv_contract[row[1]]['latestpoint']*row[4]*gv_contract[row[1]]['btc_multi'],
            margin = row[3]*row[4]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage'])
        if row[2] == 'B':
            tt.update(dict(p_l = (gv_contract[row[1]]['latestpoint']-row[3])*row[4]*gv_contract[row[1]]['btc_multi']))
        else:
            tt.update(dict(p_l = (row[3]-gv_contract[row[1]]['latestpoint'])*row[4]*gv_contract[row[1]]['btc_multi']))
        temp['positions'].append(tt)

    if 'trans' in content:
        cur.execute("SELECT contract_id,type,buy_sell, point,lots,fee,p_l,timestamp from v_trans WHERE user_id = %s ORDER BY timestamp DESC LIMIT 0,10",session['user_id'])
        trans = [dict(contract_id=row[0],type=row[1],buy_sell=row[2], point=row[3],lots=row[4],fee=row[5],p_l=row[6],timestamp=row[7]) for row in cur.fetchall()]
        temp.update({'trans':trans})
    if 'btcflow' in content:
        cur.execute("SELECT account1,input_dt,type,trans_id,amount FROM btc_action WHERE account1 = %s ORDER BY input_dt DESC LIMIT 0,10",session['email'])
        btcflow = [dict(account=row[0],input_dt=row[1],type=row[2], trans_id=row[3],amount=row[4]) for row in cur.fetchall()]
        temp.update({'btcflow':btcflow})
    if 'address' in content:
        cur.execute("SELECT address FROM btc_account WHERE account = %s",session['email'])
        temp.update(dict(address=cur.fetchone()[0]))
    cur.close()
    return temp


def _add_order(db,session,contract_id,b_s,c_o,point,lots):
    cur = db.cursor()
    cur.callproc('addorder',(contract_id,session['user_id'],b_s,c_o,point,lots))
    result = cur.fetchone()
    if result is None:
        return {'msg':'None','category':'err'}
    cur.close()
    return dict(msg=result[1],category=result[0])

def _cancel_order(db,session,orderid):
    cur = db.cursor()
    cur.callproc('exchange',(orderid,session['user_id'],'C'))
    result = cur.fetchone()
    if result is None:
        return {'msg':'None','category':'err'}
    cur.close()
    return dict(msg=result[1],category=result[0])

if __name__ == "__main__":
    class g:
        db = _connect_db()
        cur = db.cursor()
    g = g
    session = {'user_id':28,'email':'jian.xie@163.com'}

    a = _update_contract(g.db)
    b = _update_user(g,session)
    c = _add_order(g,session,)
    print b