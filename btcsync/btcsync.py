from jsonrpc import ServiceProxy
from config import database, btc_url, btc_minconf, btc_syncinterv
import time, MySQLdb
import atexit

ag = ServiceProxy(btc_url)
def transsync():    
    cursor.execute("SELECT lastblock from btc_synclog WHERE type = 'trans' and status = 'S' order by timestamp desc LIMIT 0,1") 
    result = cursor.fetchone()
    if result is not None:
        lastblock = result[0]
    else:
        lastblock = '*'
    try:
        res = ag.listsinceblock(lastblock, btc_minconf)
        for tx in res['transactions']:
            cursor.execute("DELETE FROM btc_trans where txid=%s", tx['txid'])
            if 'fee' not in tx:                
                vtxfee = '0'
            else:
                vtxfee = tx['fee']
            cursor.execute("INSERT INTO btc_trans(type,user,amount,fee,address,confirm,txid,timestamp)VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
                [tx['category'], tx['account'], tx['amount'],vtxfee, tx['address'], tx['confirmations'], tx['txid'], MySQLdb.TimestampFromTicks(tx['time'])])
            updateuser(tx['account'])
        if len(res['transactions']) > 0:
            cursor.execute("DELETE FROM btc_synclog WHERE lastblock = %s",res['lastblock'])
            cursor.execute("INSERT INTO btc_synclog(type,lastblock,status,message)VALUES ('trans',%s,'S',%s)", [res['lastblock'], len(res['transactions'])])
            print time.strftime('%d_%H:%M',time.localtime(time.time())),len(res['transactions']), 'transactions synced.'
    except Exception as inst:
        cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('trans','F',%s)", "Err:{0}{1}".format(type(inst),inst.args))
        print 'TransSync Error', type(inst), inst.args

def updateuser(account):
    vadd = ag.getaccountaddress(account)
    vbal = ag.getbalance(account, btc_minconf)
    vunbal = ag.getbalance(account, 0) - vbal
    cursor.execute("DELETE FROM btc_account where account=%s", account)
    cursor.execute("INSERT INTO btc_account(account,address,balance,bal_unconf) VALUES(%s,%s,%s,%s)",[account, vadd, vbal, vunbal])
    return vbal

def actionsproc(): 
    cursor.execute("SELECT btc_action_id,action,account1,account2,address,amount from btc_action WHERE status = 'N' ORDER by btc_action_id") 
    result = cursor.fetchall()
    for act in result:        
        if act[1] == 'createuser':
            try:
                res = updateuser(act[2])
                cursor.execute("UPDATE btc_action SET status ='S',process_dt=NOW(),message=%s WHERE btc_action_id = %s", [res , act[0]])
            except Exception as inst:                
                cursor.execute("UPDATE btc_action SET status ='F',process_dt=NOW(),message=%s WHERE btc_action_id = %s", ["Err:{0}{1}".format(type(inst),inst.args), act[0]])
        elif act[1] == 'move':
            try:
                if float(act[5]) >= 0:
                    res = ag.move(act[2], act[3], float(act[5]))
                else:
                    res = ag.move(act[3], act[2], -1*float(act[5]))
                updateuser(act[2])
                updateuser(act[3])         
                cursor.execute("UPDATE btc_action SET status ='S',process_dt=NOW(),message=%s WHERE btc_action_id = %s", [res, act[0]])
            except Exception as inst:                
                cursor.execute("UPDATE btc_action SET status ='F',process_dt=NOW(),message=%s WHERE btc_action_id = %s", ["Err:{0}{1}".format(type(inst),inst.args), act[0]])
        elif act[1] == 'sendfrom':
            try:
                res = ag.sendfrom(act[2], act[4], float(act[5]), btc_minconf)                
                updateuser(act[2])
                cursor.execute("UPDATE btc_action SET status ='S',process_dt=NOW(),message=%s WHERE btc_action_id = %s", [res, act[0]])
            except Exception as inst:                
                cursor.execute("UPDATE btc_action SET status ='F',process_dt=NOW(),message=%s WHERE btc_action_id = %s", ["Err:{0}{1}".format(type(inst),inst.args), act[0]])
        else:
            cursor.execute("UPDATE btc_action SET status ='F',process_dt=NOW(),message=%s WHERE btc_action_id = %s", ['Unsupport action', act[0]])
    if len(result)>0:
        print time.strftime('%d_%H:%M',time.localtime(time.time())),len(result), 'actions processed.'
        
def svrexit():
    cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('serv','E',%s)", btc_url[btc_url.find('@')+1:-1])
    cursor.close()
    db.commit()
    db.close()
    print  time.strftime('%d_%H:%M',time.localtime(time.time())),'Bitcoin Sync to Mysql Service Stoped.'


if __name__ == "__main__":
    
    try:
        res = ag.getinfo()
    except Exception as inst:
        print time.strftime('%d_%H:%M',time.localtime(time.time())),'Bitcoin Server Connection Failed.'
        exit()
    db=MySQLdb.connect(host=database['host'], user=database['user'], passwd=database['passwd'],db=database['db'])
    cursor = db.cursor()    
    atexit.register(svrexit)    
    cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('serv','B',%s)", btc_url[btc_url.find('@')+1:-1])
    print  time.strftime('%d_%H:%M',time.localtime(time.time())),'Bitcoin Sync to Mysql Service Started.'
    updateuser('FEE')
    updateuser('P_L')
    while True:        
        actionsproc()
        transsync()
        db.commit()
        time.sleep(btc_syncinterv)

