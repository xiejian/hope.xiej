import urllib2,threading,datetime
import simplejson as json
from config import http_proxy

gv_twt={'ann':[],'talk':[]}

class _updatec(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)

    def run(self):
        global gv_twt
        proxy = urllib2.ProxyHandler(http_proxy)
        urllib2.install_opener(urllib2.build_opener(proxy))
        urla = "http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&screen_name=BTCFE&count=5"
        urlt = "http://search.twitter.com/search.json?callback=?&q=BTCFE&include_entities=true"
        adata = urllib2.urlopen(urla)
        gv_twt.update( {'ann': json.loads(adata.read())})
        tdata = urllib2.urlopen(urlt)
        gv_twt.update( {'talk': json.loads(tdata.read())})


def _update_twt():
    global twt_lastupdate
    if 'twt_lastupdate' not in globals() or ('twt_lastupdate' in globals() and (datetime.datetime.now() - twt_lastupdate).seconds > 600) :
        twt = _updatec()
        twt.start()
        twt_lastupdate = datetime.datetime.now()
        print twt_lastupdate

if __name__ == '__main__':
    global twta,twtt
    twta = {}
    twtt = {}
    twt = _update_twt()
    twt.start()
    print 'started',[twta,twtt]
    twt.join()
    print 'finished',[twta,twtt]