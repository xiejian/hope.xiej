-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.10


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema btcfe
--

CREATE DATABASE IF NOT EXISTS btcfe;
USE btcfe;

--
-- Temporary table structure for view `btcfe`.`v_account`
--
DROP TABLE IF EXISTS `btcfe`.`v_account`;
DROP VIEW IF EXISTS `btcfe`.`v_account`;
CREATE TABLE `btcfe`.`v_account` (
  `account` varchar(32),
  `address` char(34),
  `balance` decimal(20,8)
);

--
-- Temporary table structure for view `btcfe`.`v_btcbal`
--
DROP TABLE IF EXISTS `btcfe`.`v_btcbal`;
DROP VIEW IF EXISTS `btcfe`.`v_btcbal`;
CREATE TABLE `btcfe`.`v_btcbal` (
  `user_id` int(11),
  `account` varchar(40),
  `balance` decimal(42,8),
  `bal_unconf` decimal(42,8),
  `bal_unact` decimal(43,8),
  `bal_avail` decimal(44,8)
);

--
-- Temporary table structure for view `btcfe`.`v_btcbal_p`
--
DROP TABLE IF EXISTS `btcfe`.`v_btcbal_p`;
DROP VIEW IF EXISTS `btcfe`.`v_btcbal_p`;
CREATE TABLE `btcfe`.`v_btcbal_p` (
  `account` varchar(40),
  `balance` decimal(20,8),
  `bal_unconf` decimal(20,8),
  `bal_unact` decimal(21,8)
);

--
-- Temporary table structure for view `btcfe`.`v_btcunact`
--
DROP TABLE IF EXISTS `btcfe`.`v_btcunact`;
DROP VIEW IF EXISTS `btcfe`.`v_btcunact`;
CREATE TABLE `btcfe`.`v_btcunact` (
  `account` varchar(40),
  `amount` decimal(43,8)
);

--
-- Temporary table structure for view `btcfe`.`v_pos`
--
DROP TABLE IF EXISTS `btcfe`.`v_pos`;
DROP VIEW IF EXISTS `btcfe`.`v_pos`;
CREATE TABLE `btcfe`.`v_pos` (
  `user_id` int(11),
  `contract_id` int(11),
  `contract_name` varchar(8),
  `buy_sell` char(1),
  `lots` decimal(32,0),
  `cost` decimal(62,16),
  `marketvalue` decimal(62,16),
  `margin` decimal(65,20)
);

--
-- Temporary table structure for view `btcfe`.`v_trans`
--
DROP TABLE IF EXISTS `btcfe`.`v_trans`;
DROP VIEW IF EXISTS `btcfe`.`v_trans`;
CREATE TABLE `btcfe`.`v_trans` (
  `trans_id` int(11),
  `contract_id` int(11),
  `type` char(1),
  `user_id` int(11),
  `buy_sell` char(1),
  `point` decimal(20,8),
  `lots` int(11),
  `timestamp` timestamp,
  `fee` decimal(21,8),
  `p_l` decimal(21,8)
);

--
-- Definition of table `btcfe`.`btc_account`
--

DROP TABLE IF EXISTS `btcfe`.`btc_account`;
CREATE TABLE  `btcfe`.`btc_account` (
  `account` varchar(32) NOT NULL,
  `address` char(34) NOT NULL,
  `balance` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `bal_unconf` decimal(20,8) NOT NULL DEFAULT '0.00000000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`btc_account`
--

/*!40000 ALTER TABLE `btc_account` DISABLE KEYS */;
LOCK TABLES `btc_account` WRITE;
INSERT INTO `btcfe`.`btc_account` VALUES  ('FEE','1DSxsg47KjqtZhC9tEvyiSCSViV2PCknKt','0.00127560','0.00000000'),
 ('jian.xie@hotmail.com','17qLfgv2L7uu6VnX8KuzWYvTQaweYmXDgm','0.36511610','0.00000000'),
 ('jian.xie@163.com','12NuhVyvntvBZdcaLPUojkMa455wNoF1kX','0.30300830','0.00000000'),
 ('P_L','1NzDocGM8WbjwPkZ6oXanfHybubbC7ZZME','-0.06990000','0.00000000');
UNLOCK TABLES;
/*!40000 ALTER TABLE `btc_account` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`btc_action`
--

DROP TABLE IF EXISTS `btcfe`.`btc_action`;
CREATE TABLE  `btcfe`.`btc_action` (
  `btc_action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(32) NOT NULL,
  `account1` varchar(40) NOT NULL,
  `account2` varchar(40) DEFAULT NULL,
  `address` char(34) DEFAULT NULL,
  `amount` decimal(20,8) DEFAULT '0.00000000',
  `type` char(1) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'N',
  `trans_id` int(11) DEFAULT NULL,
  `input_dt` datetime NOT NULL,
  `process_dt` datetime DEFAULT NULL,
  `message` varchar(96) DEFAULT NULL,
  PRIMARY KEY (`btc_action_id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`btc_action`
--

/*!40000 ALTER TABLE `btc_action` DISABLE KEYS */;
LOCK TABLES `btc_action` WRITE;
INSERT INTO `btcfe`.`btc_action` VALUES  (162,'createuser','jian.xie@163.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:07:56','2012-01-04 08:18:36','0.44372840'),
 (163,'createuser','jian.xie@hotmail.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:16:48','2012-01-04 08:18:36','0.02543640');
UNLOCK TABLES;
/*!40000 ALTER TABLE `btc_action` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`btc_synclog`
--

DROP TABLE IF EXISTS `btcfe`.`btc_synclog`;
CREATE TABLE  `btcfe`.`btc_synclog` (
  `type` char(8) NOT NULL,
  `lastblock` varchar(64) DEFAULT NULL,
  `status` char(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` varchar(96) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`btc_synclog`
--

/*!40000 ALTER TABLE `btc_synclog` DISABLE KEYS */;
LOCK TABLES `btc_synclog` WRITE;
INSERT INTO `btcfe`.`btc_synclog` VALUES  ('serv',NULL,'B','2012-01-04 00:18:35','192.168.168.122:8332'),
 ('trans','00000000000001d1744b6c765ef9b92db0ea635232720af6b4c917349659c3a5','S','2012-01-04 00:18:36','5'),
 ('serv',NULL,'E','2012-01-04 00:32:54','192.168.168.122:8332'),
 ('serv',NULL,'B','2012-01-04 02:38:53','192.168.168.122:8332'),
 ('serv',NULL,'B','2012-01-04 03:00:49','192.168.168.122:8332'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:00:49','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:01:19','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:01:50','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:02:20','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:02:50','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:03:20','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:03:51','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:04:21','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:04:51','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:05:21','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:05:52','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:06:22','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:06:52','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:07:23','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:07:53','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:08:23','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:08:53','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:09:24','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:09:54','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:10:24','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:10:54','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:11:25','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:11:55','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:12:25','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:12:55','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:13:26','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:13:56','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:14:26','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:14:56','1'),
 ('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:15:26','1'),
 ('trans','0000000000000476935e7bf4700560b7b5461f64c15c707ffb79c279fc75feb4','S','2012-01-04 03:15:56','1'),
 ('serv',NULL,'B','2012-01-06 07:25:23','192.168.168.122:8332'),
 ('serv',NULL,'E','2012-01-06 07:38:38','192.168.168.122:8332'),
 ('serv',NULL,'B','2012-01-06 07:48:01','192.168.168.122:8332'),
 ('serv',NULL,'E','2012-01-06 07:48:08','192.168.168.122:8332'),
 ('serv',NULL,'B','2012-01-06 07:54:42','192.168.168.122:8332');
UNLOCK TABLES;
/*!40000 ALTER TABLE `btc_synclog` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`btc_trans`
--

DROP TABLE IF EXISTS `btcfe`.`btc_trans`;
CREATE TABLE  `btcfe`.`btc_trans` (
  `type` varchar(8) CHARACTER SET latin1 NOT NULL,
  `user` varchar(40) CHARACTER SET latin1 NOT NULL,
  `amount` decimal(20,8) NOT NULL,
  `fee` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `address` char(34) CHARACTER SET latin1 NOT NULL,
  `confirm` int(11) NOT NULL,
  `txid` char(64) CHARACTER SET latin1 NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`txid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `btcfe`.`btc_trans`
--

/*!40000 ALTER TABLE `btc_trans` DISABLE KEYS */;
LOCK TABLES `btc_trans` WRITE;
INSERT INTO `btcfe`.`btc_trans` VALUES  ('send','jian.xie@163.com','-0.10000000','-0.00050000','1JwXvhNAuvHEHaJbCzWKHaoM4XPXReeu9p',3918,'01943011c067e4195a2c0d891d4c5e1a671fc2e1a192c062eb5592bd16290118','2011-12-08 08:05:48'),
 ('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',3929,'4c449c7d5e32a45e59f12d7933ecc01b1b9ba5f577b1ebd3427dfb95f6e37dba','2011-12-08 05:45:06'),
 ('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1MYTaiooQ5szcRxy6fFrsq4d9bhGxUCVVX',2,'5644386327296b568e979cda7df32b32ae1d12ceb29a24bb5995f471d114c745','2012-01-04 02:37:47'),
 ('receive','jian.xie@hotmail.com','0.10000000','0.00000000','155PNrq7SzFHNMwz9tBEbL5DAhWBFjdBtX',3205,'60f42b853c32e7e531c82e1626596bd4572ba86495011f81ab85681ca7594848','2011-12-13 04:45:56'),
 ('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',4058,'b74cf95558d346cadbee8f88624ede9dc9a40cf843ab9cc1d3b9ea674f388ec4','2011-12-08 04:34:42'),
 ('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1Et91MqiM42ecuHRVXvwJCiztpKSDeUFR3',3959,'cfa6fbaf0a3747edd2fb2915ce9141fa0a93e4d9fcd5877c2e090776732e9cf5','2011-12-08 04:35:35');
UNLOCK TABLES;
/*!40000 ALTER TABLE `btc_trans` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`contract`
--

DROP TABLE IF EXISTS `btcfe`.`contract`;
CREATE TABLE  `btcfe`.`contract` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(8) NOT NULL,
  `status` char(1) NOT NULL,
  `btc_multi` decimal(10,8) NOT NULL DEFAULT '1.00000000',
  `opendate` date NOT NULL,
  `latestpoint` decimal(20,8) DEFAULT NULL,
  `settledate` date DEFAULT NULL,
  `settlepoint` decimal(20,8) DEFAULT NULL,
  `settleproof` varchar(64) DEFAULT NULL,
  `leverage` decimal(4,4) NOT NULL DEFAULT '0.2500',
  `discription` varchar(64) NOT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`contract`
--

/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
LOCK TABLES `contract` WRITE;
INSERT INTO `btcfe`.`contract` VALUES  (4,'USD','O','1.00000000','2012-01-01',NULL,'2012-06-30',NULL,NULL,'0.2500','US Dollar Futures'),
 (5,'USD','O','1.00000000','2012-01-01',NULL,'2012-09-30',NULL,NULL,'0.2500','US Dollar Futures'),
 (6,'SP500','O','0.00100000','2012-01-01','100.00000000','2012-06-30',NULL,NULL,'0.2500','S&P 500 Index');
UNLOCK TABLES;
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`exchange_lock`
--

DROP TABLE IF EXISTS `btcfe`.`exchange_lock`;
CREATE TABLE  `btcfe`.`exchange_lock` (
  `contract_id` int(11) NOT NULL,
  `connect_id` int(16) DEFAULT NULL,
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`exchange_lock`
--

/*!40000 ALTER TABLE `exchange_lock` DISABLE KEYS */;
LOCK TABLES `exchange_lock` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `exchange_lock` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`marketinfo`
--

DROP TABLE IF EXISTS `btcfe`.`marketinfo`;
CREATE TABLE  `btcfe`.`marketinfo` (
  `marketinfo_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `open` decimal(20,8) DEFAULT NULL,
  `high` decimal(20,8) DEFAULT NULL,
  `low` decimal(20,8) DEFAULT NULL,
  `close` decimal(20,8) DEFAULT NULL,
  `tradedate` date NOT NULL,
  PRIMARY KEY (`marketinfo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`marketinfo`
--

/*!40000 ALTER TABLE `marketinfo` DISABLE KEYS */;
LOCK TABLES `marketinfo` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `marketinfo` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`orders`
--

DROP TABLE IF EXISTS `btcfe`.`orders`;
CREATE TABLE  `btcfe`.`orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `point` decimal(20,8) NOT NULL,
  `lots` int(11) NOT NULL,
  `rm_lots` int(11) NOT NULL,
  `createtime` datetime NOT NULL,
  `type` char(1) NOT NULL DEFAULT 'O',
  `status` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=latin1 COMMENT='deal order';

--
-- Dumping data for table `btcfe`.`orders`
--

/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
LOCK TABLES `orders` WRITE;
INSERT INTO `btcfe`.`orders` VALUES  (140,28,6,'B','100.00000000',1,1,'2012-01-10 09:18:02','O','O');
UNLOCK TABLES;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`positions`
--

DROP TABLE IF EXISTS `btcfe`.`positions`;
CREATE TABLE  `btcfe`.`positions` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `point` decimal(20,8) NOT NULL,
  `lots` int(11) NOT NULL,
  `opentime` datetime NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`positions`
--

/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
LOCK TABLES `positions` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`test`
--

DROP TABLE IF EXISTS `btcfe`.`test`;
CREATE TABLE  `btcfe`.`test` (
  `teset` char(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`test`
--

/*!40000 ALTER TABLE `test` DISABLE KEYS */;
LOCK TABLES `test` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`trans`
--

DROP TABLE IF EXISTS `btcfe`.`trans`;
CREATE TABLE  `btcfe`.`trans` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `buy_oid` int(11) NOT NULL,
  `sell_oid` int(11) NOT NULL,
  `point` decimal(20,8) NOT NULL,
  `lots` int(11) NOT NULL,
  `direct` char(1) DEFAULT 'B',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `btcfe`.`trans`
--

/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
LOCK TABLES `trans` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `trans` ENABLE KEYS */;


--
-- Definition of table `btcfe`.`users`
--

DROP TABLE IF EXISTS `btcfe`.`users`;
CREATE TABLE  `btcfe`.`users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `password2` varchar(40) DEFAULT NULL,
  `email_v` char(1) NOT NULL DEFAULT 'N',
  `feerate` decimal(6,6) NOT NULL DEFAULT '0.000100',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';

--
-- Dumping data for table `btcfe`.`users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
LOCK TABLES `users` WRITE;
INSERT INTO `btcfe`.`users` VALUES  (28,'jian.xie@163.com','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==',NULL,'N','0.000100'),
 (29,'jian.xie@hotmail.com','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==',NULL,'N','0.000100');
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of procedure `btcfe`.`addorder`
--

DROP PROCEDURE IF EXISTS `btcfe`.`addorder`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE  `btcfe`.`addorder`(IN `pcontract` INTEGER,IN `puser` INTEGER,
		IN pbs CHAR(1),in ptype CHAR(1),IN `ppoint` DECIMAL(20,8),IN plots INTEGER)
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE vmargin_req,vmargin,vbtcavail,vlock DECIMAL(20,10) DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
if ptype = 'C' then
	INSERT INTO orders(user_id,contract_id,buy_sell,point,lots,rm_lots,type,createtime,STATUS)
		VALUES(puser,pcontract,pbs,ppoint,plots,plots,ptype,NOW(),'N');
		CALL exchange(LAST_INSERT_ID(),'A');
elseif ptype = 'O' then 
	SELECT IFNULL(SUM(margin),0) INTO vmargin FROM v_pos WHERE user_id = puser GROUP BY user_id;
	
	SELECT b.balance + IFNULL(a.amount,0) INTO vbtcavail FROM users u, btc_account b LEFT JOIN v_btcunact a 
		ON b.account = a.account where u.email = b.account and u.user_id = puser;
		
	SELECT IFNULL(SUM(o.point*o.lots*c.btc_multi*c.leverage),0) INTO vlock FROM orders o, contract c 
		WHERE o.contract_id = c.contract_id AND o.status = 'O' AND o.type = 'O' AND o.user_id = puser;
	SET done = FALSE;
	SELECT ppoint*plots*btc_multi*leverage INTO vmargin_req FROM contract WHERE contract_id = pcontract AND STATUS = 'O';
	IF NOT done AND vbtcavail - vlock - vmargin >= vmargin_req THEN
		INSERT INTO orders(user_id,contract_id,buy_sell,point,lots,rm_lots,type,createtime,STATUS)
			VALUES(puser,pcontract,pbs,ppoint,plots,plots,ptype,NOW(),'N');
			CALL exchange(LAST_INSERT_ID(),'A');
	ELSE
	SELECT 'err',CONCAT('Margin is Not Enough.', vbtcavail,vlock,vmargin,vmargin_req);
	END IF;
end if;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `btcfe`.`contractsettle`
--

DROP PROCEDURE IF EXISTS `btcfe`.`contractsettle`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE  `btcfe`.`contractsettle`(IN `pcontract` INTEGER,IN `pprice` DECIMAL(20,10))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE curoid,curpid,curlots INT;
declare curbs char(1);
DECLARE curuser,vp_l varCHAR(40);
declare curprice DECIMAL(20,10);
DECLARE curo CURSOR FOR SELECT order_id FROM orders WHERE contract_id = pcontract AND STATUS IN('N','O');
DECLARE curp CURSOR FOR SELECT p.position_id,p.buy_sell,p.price,p.lots,u.email FROM positions p,users u
	WHERE p.contract_id = pcontract and p.user_id = u.user_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET vp_l ='P_L';
OPEN curo;
cur_loop:LOOP
	FETCH curo INTO curoid;					
	IF done THEN		
		LEAVE cur_loop;	
	else
		call exchange(curoid,'C');
	END IF;
end loop;
set done = false;
OPEN curp;
cur_loop:LOOP
	FETCH curp INTO curpid,curbs,curprice,curlots,curuser;					
	IF done THEN		
		LEAVE cur_loop;	
	ELSE
				IF (curbs = 'B' and curprice > pprice) OR (curbs = 'S' AND curprice < pprice) THEN
			INSERT INTO btc_action(ACTION,account1,account2,amount,input_dt,type) VALUES ('move',vp_l,curuser,abs(pprice-curprice)*curlots,NOW(),CONCAT(curbs,'P'));
		ELSEIF (curbs = 'B' AND curprice < pprice) OR (curbs = 'S' AND curprice > pprice) THEN		
			INSERT INTO btc_action(ACTION,account1,account2,amount,input_dt,type) VALUES ('move',curuser,vp_l,abs(pprice-curprice)*curlots,NOW(),CONCAT(curbs,'P'));
		END IF;
		DELETE FROM positions WHERE position_id = curpid; 
	END IF;
END LOOP;
update contract set settlepoint = pprice/btc_multi,status = 'S' where contract_id = pcontract;
commit;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `btcfe`.`exchange`
--

DROP PROCEDURE IF EXISTS `btcfe`.`exchange`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE  `btcfe`.`exchange`(IN `poid` integer,IN `paction` char)
main:BEGIN
DECLARE done,dealflag INT DEFAULT FALSE;
DECLARE contractlock INT;
DECLARE pcontract INT;
DECLARE vbuy_sell CHAR(1);
DECLARE vpoint,curpr DECIMAL(20,8);
DECLARE vuser,vrm_lots, curoid,curuser,curlt INT;
DECLARE curs CURSOR FOR SELECT order_id,point,rm_lots FROM orders 
    where contract_id = pcontract AND status = 'O' AND buy_sell ='S' ORDER BY point ,createtime;
DECLARE curb CURSOR FOR SELECT order_id,point,rm_lots FROM orders 
    where contract_id = pcontract AND status = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;select 'Err','SQLEXCEPTION';
  END;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SELECT user_id,contract_id,buy_sell,point,rm_lots INTO vuser,pcontract,vbuy_sell,vpoint,vrm_lots FROM orders where order_id = poid and status IN('N','O');
if done then leave main; end if;
  	REPEAT
		SELECT count(1) into contractlock from exchange_lock where contract_id = pcontract;
		IF contractlock > 0 THEN SELECT SLEEP(1);	END IF;
	UNTIL contractlock = 0
	END REPEAT;
	INSERT into exchange_lock(contract_id,connect_id) VALUES(pcontract,CONNECTION_ID());
	COMMIT;
	SELECT count(1) into contractlock from exchange_lock where contract_id = pcontract;
	IF contractlock <> 1 THEN
		LEAVE main ;
	END IF;
	
START TRANSACTION;	
IF paction = 'C' THEN
	UPDATE orders SET status = 'C' WHERE order_id = poid and STATUS in('N','O');
	SELECT 'suc','Cancel Order Successfully.';
ELSEIF paction = 'A' THEN
	IF vbuy_sell = 'B' THEN				
		SET done = false;	
		OPEN curs;
		cur_loop:LOOP
			FETCH curs INTO curoid,curpr,curlt;					
			IF done OR curpr > vpoint THEN
				UPDATE orders SET status = 'O',rm_lots = vrm_lots WHERE order_id = poid; 
				LEAVE cur_loop;	
			END IF;
			call makedeal(poid,curoid,curpr,LEAST(vrm_lots,curlt),'B');
			set dealflag = True;
			IF curlt <= vrm_lots THEN
				UPDATE orders SET status = 'F',rm_lots = 0 WHERE order_id = curoid;            
			END IF;
			IF curlt < vrm_lots THEN
				SET vrm_lots = vrm_lots - curlt;					
			ELSEIF curlt >= vrm_lots THEN
				UPDATE orders SET status = 'F',rm_lots = 0 WHERE order_id = poid;             
				UPDATE orders SET rm_lots = curlt - vrm_lots WHERE order_id = curoid; 
				LEAVE cur_loop;           
			END IF;     
		END LOOP;
		CLOSE curs;
	ELSEIF vbuy_sell = 'S' THEN				
		SET done = FALSE;
		OPEN curb;
		cur_loop:LOOP
			FETCH curb INTO curoid,curpr,curlt;					
			IF done OR curpr < vpoint THEN
				UPDATE orders SET status = 'O',rm_lots = vrm_lots WHERE order_id = poid; 
				LEAVE cur_loop;	
			END IF;
      		call makedeal(curoid,poid,curpr,LEAST(vrm_lots,curlt),'S');
			SET dealflag = TRUE;       		
       		IF curlt <= vrm_lots THEN
       			UPDATE orders SET status = 'F',rm_lots = 0 WHERE order_id = curoid;            
			END IF;
			IF curlt < vrm_lots THEN
			    SET vrm_lots = vrm_lots - curlt;					
			ELSEIF curlt >= vrm_lots THEN
				UPDATE orders SET status = 'F',rm_lots = 0 WHERE order_id = poid;             
				UPDATE orders SET rm_lots = curlt - vrm_lots WHERE order_id = curoid; 
				LEAVE cur_loop;           
			END IF; 
		END LOOP;
		CLOSE curb;
	END IF;
	if dealflag then
		select 'suc','Deal had been Maded.';
	else
		SELECT 'suc','Order had been Added succesfully.';
	end if;
END IF;
DELETE FROM exchange_lock where contract_id = pcontract;
COMMIT;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `btcfe`.`makedeal`
--

DROP PROCEDURE IF EXISTS `btcfe`.`makedeal`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE  `btcfe`.`makedeal`(IN pbuy_oid INTEGER,IN psell_oid INTEGER,IN ppoint DECIMAL(20,8),IN plots INTEGER,IN pdirect CHAR(1))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE vbfeerate,vsfeerate DECIMAL(6,6);
DECLARE vcbtcmulti DECIMAL(10,8);
DECLARE curpr DECIMAL(20,8);
declare vbtype, vstype char(1);
DECLARE curposition,curlt,vcontract,vbuser_id,vsuser_id,vtrans_id INT;
DECLARE vbuser,vsuser,vfee,vp_l VARCHAR(40);
DECLARE curb CURSOR FOR SELECT position_id,point,lots FROM positions
	WHERE contract_id = vcontract AND buy_sell ='B' AND user_id = vsuser_id ORDER BY opentime;
DECLARE curs CURSOR FOR SELECT position_id,point,lots FROM positions 
	WHERE contract_id = vcontract AND buy_sell ='S' AND user_id = vbuser_id ORDER BY opentime;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET vfee ='FEE';	SET vp_l ='P_L';
SELECT u.user_id,u.email,u.feerate,o.contract_id,o.type INTO vbuser_id,vbuser,vbfeerate,vcontract,vbtype FROM orders o, users u WHERE o.user_id = u.user_id AND o.order_id = pbuy_oid;
SELECT u.user_id,u.email,u.feerate,o.type,c.btc_multi INTO vsuser_id,vsuser,vsfeerate,vstype,vcbtcmulti FROM orders o, users u,contract c WHERE o.contract_id = c.contract_id and o.user_id = u.user_id AND o.order_id = psell_oid;
INSERT INTO trans(buy_oid,sell_oid,point,lots,direct) VALUES (pbuy_oid,psell_oid,ppoint,plots,pdirect);
SELECT LAST_INSERT_ID() INTO vtrans_id;
INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vbuser,vfee,ppoint*plots*vcbtcmulti*vbfeerate,vtrans_id,NOW(),'F')
		, ('move',vsuser,vfee,ppoint*plots*vcbtcmulti*vsfeerate,vtrans_id,NOW(),'G');
SET done = FALSE;	
if vbtype = 'O' then
	INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vbuser_id,vcontract,'B',ppoint,plots,NOW());
elseif vbtype = 'C' then
	OPEN curs;
	cur_loop:LOOP
	FETCH curs INTO curposition,curpr,curlt;			
		IF done THEN
			INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vbuser_id,vcontract,'B',ppoint,plots,NOW());
		LEAVE cur_loop;	  
		END IF;
		INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vbuser,vp_l,(ppoint-curpr)*vcbtcmulti*LEAST(curlt,plots),vtrans_id,NOW(),'P');
		IF curlt <= plots THEN
			DELETE FROM positions WHERE position_id = curposition;            
		END IF;
		IF curlt < plots THEN
			SET plots = plots - curlt;					
		ELSEIF curlt >= plots THEN
			UPDATE positions SET lots = curlt - plots WHERE position_id = curposition; 
			LEAVE cur_loop;           
		END IF; 
	END LOOP;
	CLOSE curs;
end if;
if vstype = 'O' then
	INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vsuser_id,vcontract,'S',ppoint,plots,NOW());
elseif vstype = 'C' then
	SET done = FALSE;	
	OPEN curb;
	cur_loop:LOOP
		FETCH curb INTO curposition,curpr,curlt;			
		IF done THEN
			INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vsuser_id,vcontract,'S',ppoint,plots,NOW());
			LEAVE cur_loop;	  
		END IF;
		INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vsuser,vp_l,(curpr-ppoint)*vcbtcmulti*LEAST(curlt,plots),vtrans_id,NOW(),'Q');
		IF curlt <= plots THEN
			DELETE FROM positions WHERE position_id = curposition;            
		END IF;
		IF curlt < plots THEN
			SET plots = plots - curlt;					
		ELSEIF curlt >= plots THEN
			UPDATE positions SET lots = curlt - plots WHERE position_id = curposition; 
			LEAVE cur_loop;           
		END IF; 
	END LOOP;
	CLOSE curb;     
end if;
CALL update_marketinfo(vcontract,ppoint);
          
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `btcfe`.`update_marketinfo`
--

DROP PROCEDURE IF EXISTS `btcfe`.`update_marketinfo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE  `btcfe`.`update_marketinfo`(IN `pcontract` INTEGER,IN `point` DECIMAL(20,10))
main:BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE highpr,lowpr DECIMAL(20,10);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SELECT high,low INTO highpr,lowpr FROM marketinfo WHERE contract_id = pcontract AND tradedate = CURDATE();
IF done THEN
	INSERT INTO marketinfo(contract_id,OPEN,high,low,CLOSE,tradedate) VALUES(pcontract,point,point,point,point,CURDATE());
ELSE
	IF point > highpr THEN
		SET highpr = point;
	END IF;
	IF point < lowpr THEN
		SET lowpr = point;
	END IF;
	UPDATE marketinfo SET high = highpr,low = lowpr,CLOSE = point WHERE contract_id = pcontract AND tradedate = CURDATE();
END IF;
UPDATE contract SET latestpoint = point WHERE contract_id = pcontract;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `btcfe`.`v_account`
--

DROP TABLE IF EXISTS `btcfe`.`v_account`;
DROP VIEW IF EXISTS `btcfe`.`v_account`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `btcfe`.`v_account` AS select `btcfe`.`btc_account`.`account` AS `account`,`btcfe`.`btc_account`.`address` AS `address`,`btcfe`.`btc_account`.`balance` AS `balance` from `btcfe`.`btc_account`;

--
-- Definition of view `btcfe`.`v_btcbal`
--

DROP TABLE IF EXISTS `btcfe`.`v_btcbal`;
DROP VIEW IF EXISTS `btcfe`.`v_btcbal`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `btcfe`.`v_btcbal` AS select `u`.`user_id` AS `user_id`,`t`.`account` AS `account`,sum(`t`.`balance`) AS `balance`,sum(`t`.`bal_unconf`) AS `bal_unconf`,sum(`t`.`bal_unact`) AS `bal_unact`,((sum(`t`.`balance`) + least(sum(`t`.`bal_unconf`),0)) + least(sum(`t`.`bal_unact`),0)) AS `bal_avail` from (`btcfe`.`v_btcbal_p` `t` join `btcfe`.`users` `u`) where (convert(`t`.`account` using utf8) = convert(`u`.`email` using utf8)) group by `u`.`user_id`,`t`.`account`;

--
-- Definition of view `btcfe`.`v_btcbal_p`
--

DROP TABLE IF EXISTS `btcfe`.`v_btcbal_p`;
DROP VIEW IF EXISTS `btcfe`.`v_btcbal_p`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `btcfe`.`v_btcbal_p` AS select `ac`.`account` AS `account`,`ac`.`balance` AS `balance`,`ac`.`bal_unconf` AS `bal_unconf`,0 AS `bal_unact` from `btcfe`.`btc_account` `ac` union all select `a`.`account1` AS `account1`,0 AS `0`,0 AS `0`,(-(1) * `a`.`amount`) AS `-1*a.amount` from `btcfe`.`btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` in ('move','sendfrom'))) union all select `a`.`account2` AS `account2`,0 AS `0`,0 AS `0`,`a`.`amount` AS `amount` from `btcfe`.`btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` = 'move')) union all select `a`.`account1` AS `account`,0 AS `0`,0 AS `0`,0 AS `0` from `btcfe`.`btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` = 'createuser'));

--
-- Definition of view `btcfe`.`v_btcunact`
--

DROP TABLE IF EXISTS `btcfe`.`v_btcunact`;
DROP VIEW IF EXISTS `btcfe`.`v_btcunact`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `btcfe`.`v_btcunact` AS select `a`.`account1` AS `account`,(-(1) * sum(`a`.`amount`)) AS `amount` from `btcfe`.`btc_action` `a` where (`a`.`status` = 'N') group by `a`.`account1`;

--
-- Definition of view `btcfe`.`v_pos`
--

DROP TABLE IF EXISTS `btcfe`.`v_pos`;
DROP VIEW IF EXISTS `btcfe`.`v_pos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `btcfe`.`v_pos` AS select `p`.`user_id` AS `user_id`,`p`.`contract_id` AS `contract_id`,`c`.`name` AS `contract_name`,`p`.`buy_sell` AS `buy_sell`,sum(`p`.`lots`) AS `lots`,sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`)) AS `cost`,sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) AS `marketvalue`,sum((((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`) * `c`.`leverage`)) AS `margin` from (`btcfe`.`positions` `p` join `btcfe`.`contract` `c`) where (`p`.`contract_id` = `c`.`contract_id`) group by `p`.`user_id`,`p`.`contract_id`,`p`.`buy_sell`,`c`.`name`;

--
-- Definition of view `btcfe`.`v_trans`
--

DROP TABLE IF EXISTS `btcfe`.`v_trans`;
DROP VIEW IF EXISTS `btcfe`.`v_trans`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `btcfe`.`v_trans` AS select `t`.`trans_id` AS `trans_id`,`o`.`contract_id` AS `contract_id`,`o`.`type` AS `type`,`o`.`user_id` AS `user_id`,`o`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,`t`.`timestamp` AS `timestamp`,-(`a`.`amount`) AS `fee`,-(`b`.`amount`) AS `p_l` from (`btcfe`.`orders` `o` join ((`btcfe`.`trans` `t` left join `btcfe`.`btc_action` `a` on(((`t`.`trans_id` = `a`.`trans_id`) and (`a`.`type` = 'F')))) left join `btcfe`.`btc_action` `b` on(((`t`.`trans_id` = `b`.`trans_id`) and (`b`.`type` = 'P'))))) where (`t`.`buy_oid` = `o`.`order_id`) union all select `t`.`trans_id` AS `trans_id`,`o`.`contract_id` AS `contract_id`,`o`.`type` AS `type`,`o`.`user_id` AS `user_id`,`o`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,`t`.`timestamp` AS `timestamp`,-(`a`.`amount`) AS `fee`,-(`b`.`amount`) AS `p_l` from (`btcfe`.`orders` `o` join ((`btcfe`.`trans` `t` left join `btcfe`.`btc_action` `a` on(((`t`.`trans_id` = `a`.`trans_id`) and (`a`.`type` = 'G')))) left join `btcfe`.`btc_action` `b` on(((`t`.`trans_id` = `b`.`trans_id`) and (`b`.`type` = 'Q'))))) where (`t`.`sell_oid` = `o`.`order_id`);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
