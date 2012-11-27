__author__ = 'xiejian'

import urllib2,time,random
import simplejson as json

class tradebot:
    def __init__(self, key,cid):
        self.site = "http://127.0.0.1:5000/api?key="+key+"&"
        self.cid = cid          #contract id
        self.movecover = 0.3    #40% move cover
        self.spread = 0.03      #5% bid offer spread
        self.depth = 2000 / 2    #half lots
        self.ordersnum = 40 / 2  #half number of orders
        self.lots_tolerant = 0.2   #lots adjust tolerant

    def update_spot_point(self):
        urlusd = "https://mtgox.com/api/0/data/ticker.php"
        data = json.loads(urllib2.urlopen(urlusd).read())
        if 'ticker' in data:
            self.spot_point = round(100/data['ticker']['avg'],3)

    def cancelorder(self,oid):
        urlcord = self.site + "t=C&oid="+str(oid)
        data = json.loads(urllib2.urlopen(urlcord).read())
        if data['category'] == "suc":
            return True
        else:
            return False
    def updatesev(self):
        urlcord = self.site + "t=U&cid="+str(self.cid)
        data = json.loads(urllib2.urlopen(urlcord).read())
        if data['category'] == "suc":
            return True
        else:
            return False

    def addorder(self,cid,pt,lt):
        bs = 'B'
        if lt < 0:
            lt = -lt
            bs = 'S'
        urlaord = self.site + "t=A&cid="+str(cid)+"&bs="+bs+"&pt="+str(pt)+"&lt="+str(lt)
        data = json.loads(urllib2.urlopen(urlaord).read())
        if data['category'] == "suc":
            return data['msg'].split(":")[0]
        else:
            return False

    def getorderlist(self):
        urlord = self.site + "t=O"
        data = json.loads(urllib2.urlopen(urlord).read())
        self.orderlist = []
        for o in data['ord']:
            if o['bs'] == 'S':
                o['rlt'] = -o['rlt']
            self.orderlist.append(order(o['o'],o['c'],o['pt'],o['rlt']))

    def targetoders(self):
        gap_b = (self.spot_point * self.movecover - self.spot_point * self.spread)/self.ordersnum
        gap_s = (self.spot_point / (1-self.movecover) - self.spot_point / (1-self.spread))/self.ordersnum
        for i in range(1,self.ordersnum + 1):
            lots = i * 2 * self.depth / (self.ordersnum * self.ordersnum)
            if lots > 0:
                pointb = self.spot_point - gap_b * i
                points = self.spot_point + gap_s * i
                self.adjustorders(pointb,gap_b,lots)
                self.adjustorders(points,gap_s,-lots)


    def adjustorders(self,point,gap,lots):
        olots=0
        for eo in self.orderlist:
            if abs(eo.point - point)<= gap/2:
                olots += eo.lots
        if abs(olots-lots) > abs(lots * self.lots_tolerant):  #can't tolerant, just now.
            for eo in self.orderlist:
                if abs(eo.point - point)<= gap/2:
                    if self.cancelorder(eo.oid):         #cancel all order
                        print 'Del Order @ ' + str(point) +'*' + str(lots)
                        self.orderlist.remove(eo)

            ao = self.addraworder(point,gap,lots)
            if ao:
                print 'Add Order @ ' + str(point) +'*' + str(lots)
                self.orderlist.append(ao)   #add order

    def addraworder(self,point,gap,lots):
        spoint = point + random.uniform(-gap/2, gap/2)
        slots = lots + random.randint(int(-abs(lots * self.lots_tolerant)), int(abs(lots * self.lots_tolerant)))
        res = self.addorder(self.cid,spoint,slots)
        if res:
            return order(res,self.cid,spoint,slots)
        else:
            return False

class order:
    def __init__(self,oid,cid,point,lots):
        self.oid = oid
        self.cid = cid
        self.point = point
        self.lots = lots

if __name__ == '__main__':
    btc = tradebot('IOV3LkRV1JsVpCsPUv4JE0dL3o-W4ebP6eo9zw==3',1)
    btc.update_spot_point()
    btc.getorderlist()
    btc.targetoders()
    btc.updatesev()