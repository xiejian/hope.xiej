import MySQLdb
from config import DB

def _connect_db():
    """Returns a new connection to the database."""
    return MySQLdb.connect(host=DB['host'],port=DB['port'], user=DB['user'], passwd=DB['passwd'],db=DB['db'])
