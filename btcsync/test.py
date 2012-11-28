__author__ = 'xiejian'

class a:
    def set(self,x):
        self.x=x
    def get(self):
        return self.x

class b:
    def __init__(self, ba):
        self.ba = ba

    def getb(self):
        return self.ba.x

xja = a()
xja.set(1)

b1 = b(xja)
xja.set(2)

b2 = b(xja)
print 'b1',b1.getb()
print 'b2',b2.getb()
xja.set(3)

print 'b1',b1.getb()
print 'b2',b2.getb()
