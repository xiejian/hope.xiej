import urllib2,threading,time,sys
import simplejson as json
from config import http_proxy,TWT_INTERVAL,TWT_COUNT
from _data import gv_contract

gv_twt={'ann':[],'talk':[]}
gv_cont_sp = {}

def cont_sp_update():
    global gv_cont_sp

    urlusd = "https://mtgox.com/api/0/data/ticker.php"
    gv_cont_sp.update({'USD': json.loads(urllib2.urlopen(urlusd).read())})
    print gv_cont_sp#todo usd spot price update & show

def info_update():
    global gv_twt
    if http_proxy is not None:
        proxy = urllib2.ProxyHandler(http_proxy)
        urllib2.install_opener(urllib2.build_opener(proxy))
    urla = "http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&screen_name=BTCFE&count="+TWT_COUNT
    urlt = "http://search.twitter.com/search.json?callback=?&q=BTCFE&include_entities=true"
    adata = urllib2.urlopen(urla)
    gv_twt.update( {'ann': json.loads(adata.read())})
    tdata = urllib2.urlopen(urlt)
    gv_twt.update( {'talk': json.loads(tdata.read())})
    for c in gv_contract :
        if len(gv_contract[c]['twitter_id']) > 0:
            urla = "http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&screen_name="+gv_contract[c]['twitter_id']+"&count="+TWT_COUNT
            adata = urllib2.urlopen(urla)
            gv_twt.update({c: json.loads(adata.read())})

    cont_sp_update()

    t = threading.Timer(TWT_INTERVAL, info_update)
    t.start()
    print >> sys.stderr, time.strftime('%d_%H:%M',time.localtime(time.time())),'Twitter Updated Finished.'

def _start_twt_sevice():
    t = threading.Timer(TWT_INTERVAL, info_update)
    t.start()
    print >> sys.stderr, time.strftime('%d_%H:%M',time.localtime(time.time())),'Twitter Update Service Started.'

def _stop_twt_sevice():
    global t
    t.cancel()
    print >> sys.stderr, time.strftime('%d_%H:%M',time.localtime(time.time())),'Twitter Update Service Stopped.'


if __name__ == '__main__':
    twt_update()
