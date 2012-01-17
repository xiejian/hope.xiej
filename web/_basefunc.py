import re,os, base64

def numformat(num):
    try:
        res = '{0:.8f}'.format(num).rstrip('0').rstrip('.')
        return res
    except Exception:
        return ''

def validateEmail(email):
    if len(email) > 6:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) is not None:
            return True
    return False



