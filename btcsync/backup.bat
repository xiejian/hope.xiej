"C:\Program Files\MySQL\MySQL Server 5.1\bin\mysqldump.exe" -uroot -pxiej btcfe --routines > D:\workarea\hope.xiej\btcsync\db.sql

mysqldump -uroot -pxj btcfe --routines --no-data > ~/WorkArea/hope.xiej/btcsync/db.sql


bitcoind -daemon
nohup python btcsync.py pass &