__author__ = 'xiejian'

def test(aa,p):
    aa(p)
    print 'test',aa

def a(p):
    print 'a'
    print p

test('a',{'xj':1,'2':2})