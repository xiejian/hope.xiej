from jsonrpc import ServiceProxy
from config import database, btc_url, btc_minconf, btc_syncinterv,logfilename
import sys, os
import time, MySQLdb
import atexit
import logging
import logging.handlers

logging.basicConfig(
    filename=logfilename,
    format='%(asctime)-6s: %(name)s - %(levelname)s - %(message)s')

#fileLogger = logging.handlers.RotatingFileHandler(filename=logfilename,maxBytes = 2*1024*1024, backupCount = 1)
#logging.getLogger('BTC').addHandler(fileLogger)
logger = logging.getLogger('BTC')
logger.setLevel(logging.INFO)

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
            logger.info(str(len(res['transactions']))+ ' transactions synced.')
    except Exception as inst:
        cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('trans','F',%s)", "Err:{0}{1}".format(type(inst),inst.args))
        logger.error('TransSync Error'+ str(type(inst))+ str(inst.args))

def updateuser(account):
    vadd = ag.getaccountaddress(account)
    vbal = ag.getbalance(account, btc_minconf)
    vunbal = ag.getbalance(account, 0) - vbal
    cursor.execute("DELETE FROM btc_account where account=%s", account)
    cursor.execute("INSERT INTO btc_account(account,address,balance,bal_unconf) VALUES(%s,%s,%s,%s)",[account, vadd, vbal+min(0,vunbal), vunbal])
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

                ag.walletpassphrase(passphrase,60)
                res = ag.sendfrom(act[2], act[4], float(act[5]), btc_minconf)
                ag.walletlock()
                updateuser(act[2])
                cursor.execute("UPDATE btc_action SET status ='S',process_dt=NOW(),message=%s WHERE btc_action_id = %s", [res, act[0]])
            except Exception as inst:                
                cursor.execute("UPDATE btc_action SET status ='F',process_dt=NOW(),message=%s WHERE btc_action_id = %s", ["Err:{0}{1}".format(type(inst),inst.args), act[0]])
        else:
            cursor.execute("UPDATE btc_action SET status ='F',process_dt=NOW(),message=%s WHERE btc_action_id = %s", ['Unsupport action', act[0]])
    if len(result)>0:
        logger.info(str(len(result)) + ' actions processed.')
        
def svrexit():
    cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('serv','E',%s)", btc_url[btc_url.find('@')+1:-1])
    cursor.close()
    db.commit()
    db.close()
    logger.info('Bitcoin Sync to Mysql Service Stoped.')
    os.remove('p')

if __name__ == "__main__":

    f = open('p', 'r+')
    passphrase=f.read().rstrip()
    f.seek(0)
    f.write(str(os.getpid()))
    f.close()
    if (len(passphrase) <= 1):
        print 'PassPhrase miss'
        exit()
    res = {}
    try:
        ag.walletpassphrasechange(passphrase,passphrase)
    except Exception as inst:
        msg = str(inst)
        if len(msg) == 0:
            msg = "Passwd wrong"
        logger.error('Bitcoin Server Connect Failed. ' + msg)
        exit()
    db=MySQLdb.connect(host=database['host'], user=database['user'], passwd=database['passwd'],db=database['db'])
    cursor = db.cursor()
    atexit.register(svrexit)
    cursor.execute("INSERT INTO btc_synclog(type,status,message)VALUES ('serv','B',%s)", btc_url[btc_url.find('@')+1:-1])
    logger.info('Bitcoin Sync to Mysql Service Started.')
    updateuser('FEE')
    updateuser('P_L')
    ag.settxfee(0)
    while True:
        actionsproc()
        transsync()
        db.commit()
        time.sleep(btc_syncinterv)


