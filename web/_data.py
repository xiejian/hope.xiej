from _db import  _connect_db

gv_contract = {}    #global vars of contract info


def _update_contract(db,cid = 'contract_id',type='D'):
    cur = db.cursor()
    if type == 'C' and long(cid) in gv_contract:
            #no deal made, just update order queues
        cur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime LIMIT 0,10",cid)
        gv_contract[long(cid)]['B'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in cur.fetchall()]
        cur.execute("SELECT order_id,point,rm_lots FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' ORDER BY point ,createtime LIMIT 0,10",cid)
        gv_contract[long(cid)]['S'] = [dict(order_id=orow[0],point=orow[1],rm_lots=orow[2]) for orow in cur.fetchall()]
    else:   #deals had been made, update all
        ocur = db.cursor()
        cur.execute("SELECT c.contract_id,c.code,c.status,c.btc_multi,c.opendate,c.latestpoint,c.settledate,c.leverage,c.fullname,u.email owner,c.twitter_id,r.region,s.sector "\
            "FROM contract c, users u,s_region r, s_sector s WHERE c.region_id = r.region_id and c.sector_id = s.sector_id and c.owner = u.user_id and STATUS not in ('A','R') AND contract_id ="+str(cid))
        for row in cur.fetchall():
            gv_contract[row[0]] = dict(code=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=row[6],
                name=row[1]+row[6].strftime("%y%m"),leverage=row[7],fullname=row[8],owner=row[9],twitter_id=row[10],region=row[11],sector=row[12])
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
    cur.execute("SELECT balance,bal_unconf,bal_unact,onum,omargin,pnum,pmargin,p_l FROM v_userbtc WHERE user_id = %s",session['user_id'])
    row = cur.fetchone()
    if row is None:
        row = [0,0,0]
    temp.update(dict(balance=row[0],bal_unconf=row[1],bal_unact=row[2],onum=row[3],omargin=row[4],pnum=row[5],pmargin=row[6],p_l=row[7]))
    # get user's orders info
    if 'orders' in content:
        cur.execute("SELECT order_id,contract_id,buy_sell,point,lots,rm_lots,type,DATE_FORMAT(createtime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM orders WHERE STATUS = 'O' AND user_id = %s ORDER BY order_id DESC",session['user_id'])
        temp['orders'] = []
        for row in cur.fetchall():
            tt=dict(order_id=row[0],contract_id=row[1],buy_sell=row[2],point=row[3],lots=row[4],rm_lots=row[5],type=row[6],\
                value=row[3]*row[5]*gv_contract[row[1]]['btc_multi'],createtime=row[7])
            if row[6] == 'O':
                tt.update(dict(margin = row[3]*row[5]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage']))
            else:
                tt.update(dict(margin = 0))
            temp['orders'].append(tt)
    # get user's positions info
    if 'positions' in content:
        cur.execute("SELECT position_id,contract_id,buy_sell,point,lots,DATE_FORMAT(opentime,'%%Y-%%m-%%d %%H:%%m:%%s') FROM positions WHERE user_id = %s",session['user_id'])
        temp['positions']=[]
        for row in cur.fetchall():
            tt = dict(contract_id=row[1],buy_sell=row[2],point=row[3],lots=row[4],opentime=row[5],marketvalue=gv_contract[row[1]]['latestpoint']*row[4]*gv_contract[row[1]]['btc_multi'],
                margin = gv_contract[row[1]]['latestpoint']*row[4]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage'])
            if row[2] == 'B':
                tt.update(dict(p_l = (gv_contract[row[1]]['latestpoint']-row[3])*row[4]*gv_contract[row[1]]['btc_multi']))
            else:
                tt.update(dict(p_l = (row[3]-gv_contract[row[1]]['latestpoint'])*row[4]*gv_contract[row[1]]['btc_multi']))
            temp['positions'].append(tt)
    if 'trans' in content:
        cur.execute("SELECT contract_id,type,buy_sell, point,lots,fee,p_l,timestamp,value from v_trans WHERE user_id = %s ORDER BY timestamp DESC LIMIT 0,10",session['user_id'])
        trans = [dict(contract_id=row[0],type=row[1],buy_sell=row[2], point=row[3],lots=row[4],fee=row[5],p_l=row[6],
            timestamp=row[7],value = row[8]) for row in cur.fetchall()]
        temp.update({'trans':trans})
    if 'btcflow' in content:#todo delete btcflow
        cur.execute("SELECT account1,input_dt,type,trans_id,amount FROM btc_action WHERE account1 = %s ORDER BY input_dt DESC LIMIT 0,20",session['email'])
        btcflow = [dict(account=row[0],input_dt=row[1],type=row[2], trans_id=row[3],amount=row[4]) for row in cur.fetchall()]
        temp.update({'btcflow':btcflow})
    if 'btctrans' in content:
        cur.execute("SELECT type,amount,fee,address,txid,timestamp,confirm>=2 FROM btc_trans WHERE user = %s ORDER BY timestamp DESC LIMIT 0,10",session['email'])
        btctrans = [dict(type=row[0],amount=row[1],fee=row[2], address=row[3],txid=row[4],timestamp=row[5],confirmed=row[6]) for row in cur.fetchall()]
        temp.update({'btctrans':btctrans})
    if 'log' in content:
        cur.execute("SELECT action,ip,times,timestamp FROM userlog WHERE user_id = %s ORDER BY timestamp DESC LIMIT 0,5",session['user_id'])
        log = [dict(action=row[0],ip=row[1],times=row[2],timestamp=row[3]) for row in cur.fetchall()]
        temp.update({'log':log})
    if 'address' in content:
        cur.execute("SELECT address FROM btc_account WHERE account = %s",session['email'])
        add = cur.fetchone()
        if add is None:
            add = ['Please wait bitcoin address to be created']
        temp.update(dict(address=add[0]))
    if 'info' in content:
        cur.execute("select password2 is null, email_v,feerate,invite from users WHERE user_id = %s",session['user_id'])
        row = cur.fetchone()
        temp.update(dict(password2=(row[0]==0),email_v=row[1],feerate=row[2],invite=row[3]))
        cur.execute("select ifnull(v.tradevol,0),FRATE(v.tradevol) ,ifnull(rv.rtvol,0), RRATE(v.tradevol + ifnull(rv.rtvol,0)),ifnull(rv.num,0) from users u left join v_tradevol v on u.user_id = v.user_id \
                left join v_rtradevol rv on u.user_id = rv.user_id WHERE u.user_id = %s",session['user_id'])
        vol = cur.fetchone()

        temp.update(dict(tradevol=vol[0],feerate=vol[1],rtradevol=vol[2],returnrate=vol[3],rnum=vol[4]))

    cur.close()
    return temp

def _add_order(db,session,contract_id,b_s,point,lots):
    cur = db.cursor()
    cur.callproc('addorder',(contract_id,session['user_id'],b_s,point,lots))
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