from _db import  _connect_db
import datetime,time,decimal,math

gv_contract = {}    #global vars of contract info
gv_contlist = {'O':[],'N':[],'C':[]}

def _update_contract(db,cid = 'contract_id',type='D'):
    cur = db.cursor()
    if type == 'C' and long(cid) in gv_contract:
            #no deal made, just update order queues
        cur.execute("SELECT point,sum(rm_lots),count(1) FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' group by point ORDER BY point DESC ,createtime LIMIT 0,5",cid)
        gv_contract[long(cid)]['B'] = [dict(count=orow[2],point=orow[0],rm_lots=orow[1]) for orow in cur.fetchall()]
        cur.execute("SELECT point,sum(rm_lots),count(1) FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' group by point ORDER BY point ,createtime LIMIT 0,5",cid)
        gv_contract[long(cid)]['S'] = [dict(count=orow[2],point=orow[0],rm_lots=orow[1]) for orow in cur.fetchall()]
    else:   #deals had been made, update all
        if cid in gv_contract:
            gv_contract.pop(cid)
        ocur = db.cursor()
        cur.execute("SELECT c.contract_id,c.code,c.status,c.btc_multi,unix_timestamp(c.opendate),c.latestpoint,c.settledate,c.leverage,c.fullname,u.email owner,c.twitter_id,c.region,c.sector,c.description,c.settlepoint,c.settleproof,c.apinstruction,c.write_fee,c.settlemargin,c.movelimit "\
            "FROM contract c, users u WHERE c.owner = u.user_id and STATUS not in ('A','R') AND contract_id ="+str(cid))
        for row in cur.fetchall():
            gv_contract[row[0]] = dict(code=row[1],status=row[2],btc_multi=row[3],opendate=row[4],latestpoint=row[5],settledate=time.mktime(row[6].timetuple()),name=row[1]+row[6].strftime("%y%m"),
                leverage=row[7],fullname=row[8],owner=row[9],owneru=row[9].split('@')[0],twitter_id=row[10],region=row[11],sector=row[12],description=row[13],settlepoint=row[14],settleproof=row[15],apinstruction=row[16],write_fee=row[17],settlemargin=row[18],movelimit=row[19])
            #update order queues
            ocur.execute("SELECT point,sum(rm_lots),count(1) FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='B' group by point ORDER BY point DESC ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['B'] = [dict(count=orow[2],point=orow[0],rm_lots=orow[1]) for orow in ocur.fetchall()]
            ocur.execute("SELECT point,sum(rm_lots),count(1) FROM orders WHERE contract_id = %s AND STATUS = 'O' AND buy_sell ='S' group by point ORDER BY point ,createtime LIMIT 0,10",row[0])
            gv_contract[row[0]]['S'] = [dict(count=orow[2],point=orow[0],rm_lots=orow[1]) for orow in ocur.fetchall()]
            #update transactions history
            ocur.execute("SELECT t.point,t.lots,unix_timestamp(TIMESTAMP),direct FROM trans t,orders o WHERE t.buy_oid = o.order_id AND o.contract_id = %s ORDER BY TIMESTAMP DESC LIMIT 0,5",row[0])
            gv_contract[row[0]]['T'] = [dict(point=orow[0],lots=orow[1],time=orow[2],dir=orow[3]) for orow in ocur.fetchall()]
            #update contract trade vol
            ocur.execute("SELECT ifnull(sum(value),0)/2 FROM v_trans WHERE contract_id = %s",row[0])
            gv_contract[row[0]]['vol'] = ocur.fetchone()[0]
            gv_contract[row[0]]['M']=[]
        ocur.close()
        _update_marketinfo(db)
        _update_contlist()
    cur.close()

def _update_marketinfo(db):
    cur = db.cursor()
    for c in gv_contract:
        gv_contract[c]['bp'],gv_contract[c]['ch'] = None,None
        if gv_contract[c]['status'] in ['O','C','Q','S']:
            cur.execute("select floor(unix_timestamp(t.timestamp)/3600)*3600000, round(SUBSTRING_INDEX(GROUP_CONCAT(CAST(t.point AS CHAR) ORDER BY t.timestamp), ',', 1 ),8) as open, \
                        max(t.point) as high,min(t.point) as low,round(SUBSTRING_INDEX( GROUP_CONCAT(CAST(t.point AS CHAR) ORDER BY t.timestamp DESC), ',', 1 ),8) as close, round(sum(t.point * t.lots * c.btc_multi),8) as vol \
                        from trans t join orders o on t.buy_oid=o.order_id join contract c on o.contract_id = c.contract_id where t.timestamp > (NOW() + interval - 1 year) and o.contract_id = %s group by floor(unix_timestamp(t.timestamp)/3600)",c)
            gv_contract[c]['M'] =[(orow[0],orow[1],orow[2],orow[3],orow[4],orow[5]) for orow in cur.fetchall()]
            for i in range(max(-24,-1*len(gv_contract[c]['M'])),0):
                if math.floor(time.time()/(3600*24)) > math.floor(gv_contract[c]['M'][i][0]/(3600000*24)):
                    gv_contract[c]['bp'] = gv_contract[c]['M'][i][4]
                elif math.floor(time.time()/(3600*24)) == math.floor(gv_contract[c]['M'][i][0]/(3600000*24)) and gv_contract[c]['bp'] is None:
                    gv_contract[c]['bp'] = gv_contract[c]['M'][i][1]
                    break
            if gv_contract[c]['bp']:
                gv_contract[c]['ch'] = round((gv_contract[c]['M'][-1][4]-gv_contract[c]['bp'])*100/gv_contract[c]['bp'],2)


        """
            cur.execute("select max(t.timestamp),round(SUBSTRING_INDEX(GROUP_CONCAT(CAST(t.point AS CHAR) ORDER BY t.timestamp), ',', 1 ),8) as open, \
                        max(t.point) as high,min(t.point) as low,round(SUBSTRING_INDEX( GROUP_CONCAT(CAST(t.point AS CHAR) ORDER BY t.timestamp DESC), ',', 1 ),8) as close, ifnull(round(sum(t.point * t.lots * c.btc_multi),8),0) as vol \
                        from trans t join orders o on t.buy_oid=o.order_id join contract c on o.contract_id = c.contract_id where t.timestamp > (NOW() + interval - 1 day) and o.contract_id = %s",c)
            gv_contract[c]['D'] =cur.fetchone()
            if gv_contract[c]['D'][1] is not None:
                gv_contract[c]['ch'] = round((gv_contract[c]['D'][4] - gv_contract[c]['D'][1])*100 / gv_contract[c]['D'][1],2)
        """
    cur.close()

def _update_contlist():
    tt = {'O':[],'N':[],'C':[]}
    for c in gv_contract:
        vvol = 0
        if 'D' in gv_contract[c] and gv_contract[c]['D'][1] is not None:
            vvol = gv_contract[c]['D'][5]
        temp = dict(c=c, st=gv_contract[c]['status'],n=gv_contract[c]['name'],fn=gv_contract[c]['fullname'],od=gv_contract[c]['opendate'],sd=gv_contract[c]['settledate'],
            o=gv_contract[c]['owneru'],r=gv_contract[c]['region'],s=gv_contract[c]['sector'],lp=gv_contract[c]['latestpoint'],sp=gv_contract[c]['settlepoint'],ch=gv_contract[c]['ch'],vl=vvol)
        if temp['st'] == 'O':
            tt['O'].append(temp)
        elif temp['st'] in ['N','P']:
            tt['N'].append(temp)
        elif temp['st'] in ['C','Q','S']:
            tt['C'].append(temp)
    gv_contlist.update(tt)

def _update_usergl(db,user_id,openbal_dt):
    cur = db.cursor()
    if openbal_dt==0:
        try:
            cur.execute("select unix_timestamp(timestamp) from v_gl where user_id=%s order by timestamp desc limit 10,1",[user_id])
            openbal_dt = cur.fetchone()[0]
        except :
            openbal_dt = time.mktime(datetime.date(2011,10,31).timetuple())

    cur.execute("select unix_timestamp(balance_dt),balance,bal_fee,bal_pl,bal_btc from userbalance where user_id = %s and balance_dt <= from_unixtime(%s) ORDER BY balance_dt DESC LIMIT 0,1 ",[user_id,openbal_dt])
    row = cur.fetchone()
    if row is None:
        row = [time.mktime(datetime.date(2011,10,31).timetuple()),0,0,0,0]
    openbal = dict(balance_dt=row[0],balance=row[1],bal_fee=row[2], bal_pl=row[3],bal_btc=row[4],n=row[0])
    cur.execute("SELECT contract_id,type,buy_sell, point,lots,ifnull(fee,0),ifnull(p_l,0),unix_timestamp(timestamp),value,ifnull(btc,0),sector from v_gl WHERE user_id = %s and DATE_FORMAT(timestamp, '%%Y-%%m-%%d') > from_unixtime(%s)  \
                ORDER BY timestamp",[user_id,openbal['balance_dt']])
    trans = [dict(c=row[0],n=gv_contract[row[0]]['name'] if row[0] in gv_contract else '',ty=row[1],bs=row[2], pt=row[3],lt=row[4],fee=row[5],pl=row[6],
        t=row[7],v = row[8],b = row[9],s = row[10]) for row in cur.fetchall()]
    cur.close()
    return {'openbal':openbal,'trans':trans}


def _update_user(db,session,content = []):    #get user's info
    if 'user_id' not in session:
        return dict(balance=0,bal_unconf=0,bal_unact=0,omargin=0,pmargin=0)
    temp = {}
    cur = db.cursor()
    cur.execute("SELECT balance,bal_unconf,bal_unact,onum,omargin,pnum,pmargin,p_l FROM v_userbtc WHERE user_id = %s",session['user_id'])
    row = cur.fetchone()
    if row is None:
        row = [0,0,0,0,0,0,0,0]
    temp.update(dict(balance=row[0],bal_unconf=row[1],bal_unact=row[2],onum=row[3],omargin=row[4],pnum=row[5],pmargin=row[6],p_l=row[7]))
    # get user's orders info
    if 'orders' in content:
        cur.execute("SELECT order_id,contract_id,buy_sell,point,lots,rm_lots,type,unix_timestamp(createtime) FROM orders WHERE STATUS = 'O' AND user_id = %s ORDER BY order_id DESC",session['user_id'])
        temp['ord'] = []
        for row in cur.fetchall():
            tt=dict(o=row[0],c=row[1],n=gv_contract[row[1]]['name'],bs=row[2],pt=row[3],lt=row[4],rlt=row[5],ty=row[6],\
                v=row[3]*row[5]*gv_contract[row[1]]['btc_multi'],at=row[7])
            if row[6] == 'O':
                tt.update(dict(mg = row[3]*row[5]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage']))
            else:
                tt.update(dict(mg = 0))
            temp['ord'].append(tt)
    # get user's positions info
    if 'positions' in content:
        cur.execute("SELECT position_id,contract_id,buy_sell,point,lots,unix_timestamp(opentime) FROM positions WHERE user_id = %s",session['user_id'])
        temp['pos']=[]
        for row in cur.fetchall():
            tt = dict(c=row[1],n=gv_contract[row[1]]['name'],bs=row[2],pt=row[3],lt=row[4],ot=row[5],mv=gv_contract[row[1]]['latestpoint']*row[4]*gv_contract[row[1]]['btc_multi'],
                ct = row[3]*row[4]*gv_contract[row[1]]['btc_multi'],mg = gv_contract[row[1]]['latestpoint']*row[4]*gv_contract[row[1]]['btc_multi']*gv_contract[row[1]]['leverage'])
            if row[2] == 'B':
                tt.update(dict(pl = (gv_contract[row[1]]['latestpoint']-row[3])*row[4]*gv_contract[row[1]]['btc_multi']))
            else:
                tt.update(dict(pl = (row[3]-gv_contract[row[1]]['latestpoint'])*row[4]*gv_contract[row[1]]['btc_multi']))
            temp['pos'].append(tt)
    if 'trans' in content:#todo to be deleted
        temp.update(_update_usergl(db,session['user_id'],datetime.date.today()-datetime.timedelta(30)))

    if 'btctrans' in content:
        cur.execute("SELECT type,amount,fee,address,txid,timestamp,confirm>=2 FROM btc_trans WHERE user = %s \
            union all select type,-1*amount,0,address,message,process_dt,0 from btc_action where account1=%s and status='F' \
            ORDER BY timestamp DESC LIMIT 0,10",[session['email'],session['email']])
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
        cur.execute("select password2 is null, email_v,feerate,floor(invite) from users WHERE user_id = %s",session['user_id'])
        row = cur.fetchone()
        temp.update(dict(password2=['Y','N'][row[0]],email_v=row[1],feerate=row[2],invite=row[3]))

    if 'rtvol' in content:
        cur.execute("select ifnull(v.tradevol,0),f_FRATE(v.tradevol) ,ifnull(rv.rtvol,0), f_RRATE(v.tradevol + ifnull(rv.rtvol,0)),ifnull(rv.num,0) from users u left join v_tradevol v on u.user_id = v.user_id \
                left join v_rtradevol rv on u.user_id = rv.user_id WHERE u.user_id = %s",session['user_id'])
        vol = cur.fetchone()
        temp.update(dict(tradevol=vol[0],feerate=vol[1],rtradevol=vol[2],returnrate=vol[3],rnum=vol[4]))

        cur.execute("select coupon,month,comment,month=date_format(NOW(),'%%y%%m') from userattr WHERE user_id = %s and type = 'C'",session['user_id'])

        s_coupon = [dict(coupon=row[0],month=row[1],comment=row[2],ifactive=row[3]) for row in cur.fetchall()]
        temp.update({'s_coupon':s_coupon})
        #s_coupona = 0
        #for row in s_coupon:
        #    if row['month'] == datetime.date.today().strftime("%Y-%m"):
        #        s_coupona = row['coupon']
        #temp.update({'s_coupona':s_coupona})
    cur.close()
    return temp

def _add_order(db,uid,contract_id,b_s,point,lots,type=''):
    if lots <=0 or b_s not in ['B','S']:            #validate data
        return {'msg':'None','category':'err'}
    cur = db.cursor()
    bp = gv_contract[contract_id]['bp']
    if bp not in [None,0] and type <> 'S': #daily point move limit,Sys order has no point move limit
        point = min(max(float(point),bp*float(1-gv_contract[contract_id]['movelimit'])),bp/float(1-gv_contract[contract_id]['movelimit']))
    dp = 4 if bp < 1 else 3 if bp < 10 else 2 if bp < 100 else 1 if bp < 1000 else 0
    cur.callproc('p_addorder',(contract_id,uid,b_s,round(float(point),dp),lots,type))
    result = cur.fetchone()
    if result is None:
        return {'msg':'None','category':'err'}
    cur.close()
    return dict(msg=result[1],category=result[0])

def _cancel_order(db,uid,orderid):
    cur = db.cursor()
    cur.callproc('p_exchange',(orderid,uid,'C'))
    result = cur.fetchone()
    if result is None:
        return {'msg':'None','category':'err'}
    cur.close()
    return dict(msg=result[1],category=result[0])

def _modify_cont(db,id,code,btc_multi,opendate,opentime,settledate,settletime,leverage,fullname,owner,twitter_id,vol_feerate,region,sector,description,movelimit):
    cur = db.cursor()
    write_fee = decimal.Decimal(vol_feerate)/2000
    margin_rate = decimal.Decimal(leverage)/100
    pmovelimit = decimal.Decimal(movelimit)/100
    cur.callproc('p_update_contract',(id,code,btc_multi,str(opendate)+' '+str(opentime)+':00:00',str(settledate)+' '+str(settletime)+':00:00',margin_rate,fullname,owner,twitter_id,write_fee,region,sector,description,pmovelimit))
    result = cur.fetchone()
    if result is None:
        return {'msg':'None','type':'err'},id
    cur.close()
    return dict(msg=result[1],type=result[0]),result[2]

def _delete_cont(db,id):
    cur = db.cursor()
    cur.execute("INSERT INTO btc_action(ACTION,account1,account2,address,amount,trans_id,input_dt,TYPE) \
        select 'move',email,'FEE','delete',f_CFEE(now(),now())/2-f_CFEE(c.opendate,c.settledate),c.contract_id,NOW(),'H' from users u,contract c where u.user_id = c.owner and c.contract_id = %s;",id)
    cur.execute("UPDATE contract SET status = 'D' WHERE contract_id=%s",id)
    db.commit()
    cur.close()
    return dict(msg = 'Contract Deleted Successfully.',type ='suc')

def _settle_cont(db,id,point,proof):
    cur = db.cursor()
    cur.execute("UPDATE contract SET settlepoint=%s, settleproof=%s WHERE contract_id=%s",(point,proof,id))
    db.commit()
    cur.close()
    return dict(msg = 'Contract Settle Info Updated Successfully.',type ='suc')

if __name__ == "__main__":
    class g:
        db = _connect_db()
        cur = db.cursor()
    g = g
    session = {'user_id':28,'email':'jian.xie@163.com'}

    a = _update_contract(g.db)
    b = _update_user(g,session)
    c = _add_order(g,session,)
