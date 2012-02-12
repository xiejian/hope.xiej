import urllib2
import simplejson as json

proxy = "http://192.168.168.122:8087"
urla = "http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&screen_name=BTCFE&count=5"
urlt = "http://search.twitter.com/search.json?callback=?&q=BTCFE&include_entities=true"
proxy_support = urllib2.ProxyHandler (dict(http=proxy))
opener = urllib2.build_opener(proxy_support,urllib2.HTTPHandler)
urllib2.install_opener(opener)

def _update_twt():
    adata = urllib2.urlopen(urla)
    twta = json.loads(adata.read())
    tdata = urllib2.urlopen(urlt)
    twtt = json.loads(tdata.read())
    return twta,twtt
