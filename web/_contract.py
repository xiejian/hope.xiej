
def _create_contract(db,code,fullname,btc_multi,opendate,settledate,leverage,owner,twitter_id,region_id,sector_id):
    cur = db.cursor()
    #check email is not registered
    resrows = cur.execute('SELECT code from contract where code=%s', code)
    if resrows > 0:
        return 'Code is existed.'
    cur.execute("INSERT INTO contract(code,fullname,btc_multi,opendate,settledate,leverage,owner,twitter_id,region_id,sector_id) "\
        " VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(code,fullname,btc_multi,opendate,settledate,leverage,owner,twitter_id,region_id,sector_id))

    db.commit()
    cur.close()
    return True
