import re,os, base64,datetime


def myformat(value, type='N',format='%H:%M / %d-%m-%Y'):
    if type =='D':  #for date
        if format == 'diff':
            dt = datetime.datetime.strptime(value,'%a, %d %b %Y %H:%M:%S +0000')
            return convertToHumanReadable(dt)
        else:
            dt = datetime.datetime.strptime(value,'%a %b %d %H:%M:%S +0000 %Y')
        return dt.strftime(format)
    elif type=='N': #for num
        if isinstance(value,datetime.datetime):
            return value.isoformat()
        try:
            res = '{0:.8f}'.format(value).rstrip('0').rstrip('.')
            return res
        except Exception:
            return ''
    elif type=='F': #for Full
        dt = {'B':'Buy','S':'Sell','O':'Open','C':'Close',
              'F':'FEE buy','G':'FEE sell','P':'P/L buy','Q':'P/L sell','W':'Withdraw','R':'FEE return'}
        if value in dt.keys():
            return dt[value]
        else:
            return value
    elif type=='C': #for Contract Status
        dt = {'N':'New', 'P':'Open Approval', 'O':'Open', 'C':'Close', 'Q':'Settle Approval', 'S':'Settled', 'A':'Achieved', 'R':'Rejected'}
        if value in dt.keys():
            return dt[value]
        else:
            return value
    elif type=='R': #for Region
        dt = {"W":"World Wide","N":"North America","L":"Latin America / Carib.","O":"Oceania / Australia","M":"Middle East","E":"Europe","A":"Asia","F":"Africa"}
        if value in dt.keys():
            return dt[value]
        else:
            return value
    elif type=='S': #for Sector
        dt = {"C":"Currency","I":"Stock Index","M":"Commodity","S":"Sports","P":"Politic","E":"Entertainment","O":"Others"}
        if value in dt.keys():
            return dt[value]
        else:
            return value

def validateEmail(email):
    if len(email) > 6:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) is not None:
            return True
    return False

def convertToHumanReadable(date_time):
    """
    converts a python datetime object to the
    format "X days, Y hours ago"

    @param date_time: Python datetime object

    @return:
        fancy datetime:: string
    """
    current_datetime = datetime.datetime.now()
    delta = str(current_datetime - date_time)
    if delta.find(',') > 0:
        days, hours = delta.split(',')
        days = int(days.split()[0].strip())
        hours, minutes = hours.split(':')[0:2]
    else:
        hours, minutes = delta.split(':')[0:2]
        days = 0
    days, hours, minutes = int(days), int(hours), int(minutes)
    datelets =[]
    years, months, xdays = None, None, None
    plural = lambda x: 's' if x!=1 else ''
    if days >= 365:
        years = int(days/365)
        datelets.append('%d year%s' % (years, plural(years)))
        days = days%365
    if not years and days >= 30 and days < 365:
        months = int(days/30)
        datelets.append('%d month%s' % (months, plural(months)))
        days = days%30
    if not (months or years) and days > 0 and days < 30:
        xdays =days
        datelets.append('%d day%s' % (xdays, plural(xdays)))
    if not (xdays or months or years) and hours != 0:
        datelets.append('%d hour%s' % (hours, plural(hours)))
    if not (hours or xdays or months or years):
        datelets.append('%d minute%s' % (minutes, plural(minutes)))
    return ', '.join(datelets) + ' ago.'

