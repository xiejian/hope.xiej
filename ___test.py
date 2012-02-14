__author__ = 'xiejian'

import threading,datetime

def hello():
    print datetime.datetime.now()
    global t
    t = threading.Timer(3.0, hello)
    t.start()

t = threading.Timer(3.0, hello)
t.start()

print 1,2,2,