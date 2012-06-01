"C:\Program Files\MySQL\MySQL Server 5.1\bin\mysqldump.exe" -uroot -pxiej btcfe --routines > D:\workarea\hope.xiej\btcsync\db.sql

mysqldump -uroot -pxj btcfe --routines --no-data > ~/WorkArea/hope.xiej/btcsync/db.sql

mysqldump --routines --no-create-info --no-data --no-create-db  -uroot -pxj btcfe > ~/WorkArea/hope.xiej/btcsync/notable.sql


bitcoind -daemon
nohup python btcsync.py pass &