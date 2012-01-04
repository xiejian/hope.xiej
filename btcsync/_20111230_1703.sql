/*
SQLyog Ultimate v8.32 
MySQL - 5.1.59-community : Database - btcfe
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`btcfe` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `btcfe`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `lots` int(11) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `account` */

/*Table structure for table `btc_account` */

DROP TABLE IF EXISTS `btc_account`;

CREATE TABLE `btc_account` (
  `account` varchar(32) NOT NULL,
  `address` char(34) NOT NULL,
  `balance` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `bal_unconf` decimal(20,8) NOT NULL DEFAULT '0.00000000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `btc_account` */

insert  into `btc_account`(`account`,`address`,`balance`,`bal_unconf`) values ('jian.xie@163.com','12NuhVyvntvBZdcaLPUojkMa455wNoF1kX','0.44372830','0.00000000'),('jian.xie@hotmail.com','17qLfgv2L7uu6VnX8KuzWYvTQaweYmXDgm','0.22543610','0.00000000'),('FEE','1DSxsg47KjqtZhC9tEvyiSCSViV2PCknKt','0.00023560','0.00000000');

/*Table structure for table `btc_action` */

DROP TABLE IF EXISTS `btc_action`;

CREATE TABLE `btc_action` (
  `btc_action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(32) NOT NULL,
  `account1` varchar(40) NOT NULL,
  `account2` varchar(40) DEFAULT NULL,
  `address` char(34) DEFAULT NULL,
  `amount` decimal(20,8) DEFAULT NULL,
  `comment` varchar(20) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'N',
  `trans_id` int(11) DEFAULT NULL,
  `input_dt` datetime NOT NULL,
  `process_dt` datetime DEFAULT NULL,
  `message` varchar(96) DEFAULT NULL,
  PRIMARY KEY (`btc_action_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=latin1;

/*Data for the table `btc_action` */

insert  into `btc_action`(`btc_action_id`,`action`,`account1`,`account2`,`address`,`amount`,`comment`,`status`,`trans_id`,`input_dt`,`process_dt`,`message`) values (162,'createuser','jian.xie@163.com',NULL,NULL,NULL,NULL,'S',NULL,'2012-01-04 08:07:56','2012-01-04 08:18:36','0.44372840'),(163,'createuser','jian.xie@hotmail.com',NULL,NULL,NULL,NULL,'S',NULL,'2012-01-04 08:16:48','2012-01-04 08:18:36','0.02543640'),(164,'move','jian.xie@hotmail.com','FEE',NULL,'0.00000010','B tx Fee','S',NULL,'2012-01-04 09:50:40','2012-01-04 10:38:53','1'),(165,'move','jian.xie@hotmail.com','FEE',NULL,'0.00000010','S tx Fee','S',NULL,'2012-01-04 09:50:40','2012-01-04 10:38:53','1'),(166,'move','jian.xie@163.com','FEE',NULL,'0.00000010','B tx Fee','S',NULL,'2012-01-04 09:55:42','2012-01-04 10:38:54','1'),(167,'move','jian.xie@hotmail.com','FEE',NULL,'0.00000010','S tx Fee','S',NULL,'2012-01-04 09:55:42','2012-01-04 10:38:54','1'),(168,'move','jian.xie@163.com','FEE',NULL,'0.00011000','B tx Fee','N',32,'2012-01-04 22:25:58',NULL,NULL),(169,'move','jian.xie@hotmail.com','FEE',NULL,'0.00011000','S tx Fee','N',32,'2012-01-04 22:25:58',NULL,NULL);

/*Table structure for table `btc_synclog` */

DROP TABLE IF EXISTS `btc_synclog`;

CREATE TABLE `btc_synclog` (
  `type` char(8) NOT NULL,
  `lastblock` varchar(64) DEFAULT NULL,
  `status` char(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` varchar(96) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `btc_synclog` */

insert  into `btc_synclog`(`type`,`lastblock`,`status`,`timestamp`,`message`) values ('serv',NULL,'B','2012-01-04 08:18:35','192.168.168.122:8332'),('trans','00000000000001d1744b6c765ef9b92db0ea635232720af6b4c917349659c3a5','S','2012-01-04 08:18:36','5'),('serv',NULL,'E','2012-01-04 08:32:54','192.168.168.122:8332'),('serv',NULL,'B','2012-01-04 10:38:53','192.168.168.122:8332'),('serv',NULL,'B','2012-01-04 11:00:49','192.168.168.122:8332'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:00:49','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:01:19','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:01:50','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:02:20','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:02:50','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:03:20','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:03:51','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:04:21','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:04:51','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:05:21','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:05:52','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:06:22','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:06:52','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:07:23','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:07:53','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:08:23','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:08:53','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:09:24','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:09:54','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:10:24','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:10:54','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:11:25','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:11:55','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:12:25','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:12:55','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:13:26','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:13:56','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:14:26','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:14:56','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 11:15:26','1'),('trans','0000000000000476935e7bf4700560b7b5461f64c15c707ffb79c279fc75feb4','S','2012-01-04 11:15:56','1');

/*Table structure for table `btc_trans` */

DROP TABLE IF EXISTS `btc_trans`;

CREATE TABLE `btc_trans` (
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

/*Data for the table `btc_trans` */

insert  into `btc_trans`(`type`,`user`,`amount`,`fee`,`address`,`confirm`,`txid`,`timestamp`) values ('send','jian.xie@163.com','-0.10000000','-0.00050000','1JwXvhNAuvHEHaJbCzWKHaoM4XPXReeu9p',3918,'01943011c067e4195a2c0d891d4c5e1a671fc2e1a192c062eb5592bd16290118','2011-12-08 16:05:48'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',3929,'4c449c7d5e32a45e59f12d7933ecc01b1b9ba5f577b1ebd3427dfb95f6e37dba','2011-12-08 13:45:06'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1MYTaiooQ5szcRxy6fFrsq4d9bhGxUCVVX',2,'5644386327296b568e979cda7df32b32ae1d12ceb29a24bb5995f471d114c745','2012-01-04 10:37:47'),('receive','jian.xie@hotmail.com','0.10000000','0.00000000','155PNrq7SzFHNMwz9tBEbL5DAhWBFjdBtX',3205,'60f42b853c32e7e531c82e1626596bd4572ba86495011f81ab85681ca7594848','2011-12-13 12:45:56'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',4058,'b74cf95558d346cadbee8f88624ede9dc9a40cf843ab9cc1d3b9ea674f388ec4','2011-12-08 12:34:42'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1Et91MqiM42ecuHRVXvwJCiztpKSDeUFR3',3959,'cfa6fbaf0a3747edd2fb2915ce9141fa0a93e4d9fcd5877c2e090776732e9cf5','2011-12-08 12:35:35');

/*Table structure for table `contract` */

DROP TABLE IF EXISTS `contract`;

CREATE TABLE `contract` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(8) NOT NULL,
  `status` char(1) NOT NULL,
  `btc_multi` float NOT NULL DEFAULT '1',
  `opendate` date NOT NULL,
  `latestpoint` float DEFAULT NULL,
  `settledate` date DEFAULT NULL,
  `settlepoint` float DEFAULT NULL,
  `settleproof` varchar(64) DEFAULT NULL,
  `leverage` float NOT NULL,
  `discription` varchar(64) NOT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `contract` */

insert  into `contract`(`contract_id`,`name`,`status`,`btc_multi`,`opendate`,`latestpoint`,`settledate`,`settlepoint`,`settleproof`,`leverage`,`discription`) values (4,'USD','O',1,'2012-01-01',NULL,'2012-06-30',NULL,NULL,25,'US Dollar Futures'),(5,'USD','O',1,'2012-01-01',0.11,'2012-09-30',NULL,NULL,25,'US Dollar Futures');

/*Table structure for table `exchange_lock` */

DROP TABLE IF EXISTS `exchange_lock`;

CREATE TABLE `exchange_lock` (
  `contract_id` int(11) NOT NULL,
  `connect_id` int(16) DEFAULT NULL,
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `exchange_lock` */

/*Table structure for table `marketinfo` */

DROP TABLE IF EXISTS `marketinfo`;

CREATE TABLE `marketinfo` (
  `marketinfo_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `open` decimal(20,10) DEFAULT NULL,
  `high` decimal(20,10) DEFAULT NULL,
  `low` decimal(20,10) DEFAULT NULL,
  `close` decimal(20,10) DEFAULT NULL,
  `tradedate` date NOT NULL,
  PRIMARY KEY (`marketinfo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `marketinfo` */

insert  into `marketinfo`(`marketinfo_id`,`contract_id`,`open`,`high`,`low`,`close`,`tradedate`) values (7,5,'0.0001000000','0.1100000000','0.0001000000','0.1100000000','2012-01-04');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `price` decimal(20,10) NOT NULL,
  `lots` int(11) NOT NULL,
  `rm_lots` int(11) NOT NULL,
  `createtime` datetime NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1 COMMENT='deal order';

/*Data for the table `orders` */

insert  into `orders`(`order_id`,`user_id`,`contract_id`,`buy_sell`,`price`,`lots`,`rm_lots`,`createtime`,`status`) values (52,28,5,'B','0.0001000000',1,1,'2012-01-04 08:42:28','C'),(53,29,5,'B','0.0001000000',1,1,'2012-01-04 09:50:10','C'),(54,29,5,'B','0.0001000000',1,0,'2012-01-04 09:50:34','F'),(55,29,5,'S','0.0001000000',2,0,'2012-01-04 09:50:40','F'),(56,28,5,'B','0.1000000000',1,0,'2012-01-04 09:55:42','F'),(57,28,5,'B','0.1000000000',1,1,'2012-01-04 09:56:03','O'),(58,28,5,'B','0.1100000000',1,0,'2012-01-04 10:24:53','F'),(59,28,5,'B','0.1200000000',2,2,'2012-01-04 10:25:10','C'),(60,29,4,'S','0.0100000000',2,2,'2012-01-04 11:01:29','O'),(61,29,5,'S','0.2000000000',1,1,'2012-01-04 19:19:13','O'),(62,29,5,'S','0.2100000000',1,1,'2012-01-04 19:30:32','O'),(63,29,5,'S','0.1100000000',2,1,'2012-01-04 22:25:58','O');

/*Table structure for table `position` */

DROP TABLE IF EXISTS `position`;

CREATE TABLE `position` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `lot` int(11) NOT NULL,
  `w_price` float NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `position` */

/*Table structure for table `positions` */

DROP TABLE IF EXISTS `positions`;

CREATE TABLE `positions` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `price` decimal(20,10) NOT NULL,
  `lots` int(11) NOT NULL,
  `opentime` datetime NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

/*Data for the table `positions` */

insert  into `positions`(`position_id`,`user_id`,`contract_id`,`buy_sell`,`price`,`lots`,`opentime`) values (48,28,5,'B','0.0001000000',1,'2012-01-04 09:55:42'),(49,29,5,'S','0.0001000000',1,'2012-01-04 09:55:42'),(50,28,5,'B','0.1100000000',1,'2012-01-04 22:25:59'),(51,29,5,'S','0.1100000000',1,'2012-01-04 22:25:59');

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `teset` char(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `test` */

/*Table structure for table `trans` */

DROP TABLE IF EXISTS `trans`;

CREATE TABLE `trans` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `buy_oid` int(11) NOT NULL,
  `sell_oid` int(11) NOT NULL,
  `price` decimal(20,10) NOT NULL,
  `lots` int(11) NOT NULL,
  `direct` char(1) DEFAULT 'B',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

/*Data for the table `trans` */

insert  into `trans`(`trans_id`,`buy_oid`,`sell_oid`,`price`,`lots`,`direct`,`timestamp`) values (30,54,55,'0.0001000000',1,'S','2012-01-04 09:50:40'),(31,56,55,'0.0001000000',1,'B','2012-01-04 09:55:42'),(32,58,63,'0.1100000000',1,'S','2012-01-04 22:25:58');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `password2` varchar(40) DEFAULT NULL,
  `email_v` char(1) NOT NULL DEFAULT 'N',
  `feerate` float NOT NULL DEFAULT '10',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';

/*Data for the table `user` */

insert  into `user`(`user_id`,`email`,`password`,`password2`,`email_v`,`feerate`) values (28,'jian.xie@163.com','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==',NULL,'N',10),(29,'jian.xie@hotmail.com','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==',NULL,'N',10);

/* Procedure structure for procedure `addorder` */

/*!50003 DROP PROCEDURE IF EXISTS  `addorder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `addorder`(IN `pcontract` INTEGER,IN `puser` INTEGER,
		in pbs char(1),IN `pprice` DECIMAL(20,10),in plots integer)
BEGIN
DECLARE done INT DEFAULT FALSE;
declare vmargin_req,vmargin,vbtcavail,vlock DECIMAL(20,10) DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SELECT IFNULL(SUM(margin),0) into vmargin FROM v_pos where user_id = puser GROUP BY user_id;
select IFNULL(bal_avail,0) into vbtcavail from v_btcbal where user_id = puser;
SELECT IFNULL(sum(o.price*o.lots*c.leverage/100),0) into vlock FROM orders o, contract c 
	WHERE o.contract_id = c.contract_id AND o.status = 'O' and o.user_id = puser;
set done = false;
select pprice*plots*leverage/100 into vmargin_req from contract where contract_id = pcontract and status = 'O';
if not done and vbtcavail - vlock - vmargin >= vmargin_req then
	insert into orders(user_id,contract_id,buy_sell,price,lots,rm_lots,createtime,status)
		values(puser,pcontract,pbs,pprice,plots,plots,NOW(),'N');
		call exchange(last_insert_id(),'A');
else
select 'err',concat('Margin is Not Enough.', vbtcavail,vlock,vmargin,vmargin_req);
end if;
END */$$
DELIMITER ;

/* Procedure structure for procedure `contractsettle` */

/*!50003 DROP PROCEDURE IF EXISTS  `contractsettle` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `contractsettle`(IN `pcontract` INTEGER,IN `pprice` DECIMAL(20,10))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE curoid,curpid,curlots INT;
declare curbs char(1);
DECLARE curuser,vp_l varCHAR(40);
declare curprice DECIMAL(20,10);
DECLARE curo CURSOR FOR SELECT order_id FROM orders WHERE contract_id = pcontract AND STATUS IN('N','O');
DECLARE curp CURSOR FOR SELECT p.position_id,p.buy_sell,p.price,p.lots,u.email FROM positions p,user u
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
			INSERT INTO btc_action(ACTION,account1,account2,amount,input_dt,COMMENT) VALUES ('move',vp_l,curuser,abs(pprice-curprice)*curlots,NOW(),CONCAT(curbs,' st Profit'));
		ELSEIF (curbs = 'B' AND curprice < pprice) OR (curbs = 'S' AND curprice > pprice) THEN		
			INSERT INTO btc_action(ACTION,account1,account2,amount,input_dt,COMMENT) VALUES ('move',curuser,vp_l,abs(pprice-curprice)*curlots,NOW(),CONCAT(curbs,' st Loss'));
		END IF;
		DELETE FROM positions WHERE position_id = curpid; 
	END IF;
END LOOP;
update contract set settlepoint = pprice/btc_multi,status = 'S' where contract_id = pcontract;
commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `exchange` */

/*!50003 DROP PROCEDURE IF EXISTS  `exchange` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `exchange`(IN `poid` integer,IN `paction` char)
main:BEGIN
DECLARE done,dealflag INT DEFAULT FALSE;
DECLARE contractlock INT;
DECLARE pcontract INT;
DECLARE vbuy_sell CHAR(1);
DECLARE vprice,curpr DECIMAL(20,8);
DECLARE vuser,vrm_lots, curoid,curuser,curlt INT;
DECLARE curs CURSOR FOR SELECT order_id,price,rm_lots FROM orders 
    where contract_id = pcontract AND status = 'O' AND buy_sell ='S' ORDER BY price ,createtime;
DECLARE curb CURSOR FOR SELECT order_id,price,rm_lots FROM orders 
    where contract_id = pcontract AND status = 'O' AND buy_sell ='B' ORDER BY price DESC ,createtime;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;select 'Err','SQLEXCEPTION';
  END;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SELECT user_id,contract_id,buy_sell,price,rm_lots INTO vuser,pcontract,vbuy_sell,vprice,vrm_lots FROM orders where order_id = poid and status IN('N','O');
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
			IF done OR curpr > vprice THEN
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
			IF done OR curpr < vprice THEN
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `makedeal` */

/*!50003 DROP PROCEDURE IF EXISTS  `makedeal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `makedeal`(IN pbuy_oid integer,IN psell_oid integer,IN pprice decimal(20,8),IN plots integer,IN pdirect CHAR(1))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE vbfeerate,vsfeerate FLOAT;
DECLARE curpr DECIMAL(20,8);
DECLARE curposition,curlt,vcontract,vbuser_id,vsuser_id,vtrans_id INT;
declare vbuser,vsuser,vfee,vp_l varchar(40);
DECLARE curb CURSOR FOR SELECT position_id,price,lots FROM positions
	where contract_id = vcontract AND buy_sell ='B' AND user_id = vsuser_id ORDER BY opentime;
DECLARE curs CURSOR FOR SELECT position_id,price,lots FROM positions 
	where contract_id = vcontract AND buy_sell ='S' AND user_id = vbuser_id ORDER BY opentime;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
set vfee ='FEE';	set vp_l ='P_L';
SELECT u.user_id,u.email,u.feerate,o.contract_id INTO vbuser_id,vbuser,vbfeerate,vcontract FROM orders o, user u where o.user_id = u.user_id AND o.order_id = pbuy_oid;
SELECT u.user_id,u.email,u.feerate INTO vsuser_id,vsuser,vsfeerate FROM orders o, user u where o.user_id = u.user_id AND o.order_id = psell_oid;
INSERT INTO trans(buy_oid,sell_oid,price,lots,direct) VALUES (pbuy_oid,psell_oid,pprice,plots,pdirect);
select LAST_INSERT_ID() into vtrans_id;
INSERT INTO btc_action(action,account1,account2,amount,trans_id,input_dt,comment) VALUES ('move',vbuser,vfee,pprice*plots*vbfeerate/10000,vtrans_id,NOW(),'B tx Fee')
		, ('move',vsuser,vfee,pprice*plots*vsfeerate/10000,vtrans_id,NOW(),'S tx Fee');
SET done = FALSE;	
OPEN curs;
cur_loop:LOOP
FETCH curs INTO curposition,curpr,curlt;			
	IF done THEN
		INSERT INTO positions(user_id,contract_id,buy_sell,price,lots,opentime) VALUES (vbuser_id,vcontract,'B',pprice,plots,NOW());
	LEAVE cur_loop;	  
	END IF;
		IF curpr > pprice THEN
		INSERT INTO btc_action(action,account1,account2,amount,trans_id,input_dt,comment) VALUES ('move',vp_l,vbuser,(curpr-pprice)*least(curlt,plots),vtrans_id,NOW(),'B cl Profit');
	ELSEIF curpr < pprice THEN		
		INSERT INTO btc_action(action,account1,account2,amount,trans_id,input_dt,comment) VALUES ('move',vbuser,vp_l,(pprice-curpr)*least(curlt,plots),vtrans_id,NOW(),'B cl Loss');
	END IF;
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
SET done = FALSE;	
OPEN curb;
cur_loop:LOOP
	FETCH curb INTO curposition,curpr,curlt;			
	IF done THEN
		INSERT INTO positions(user_id,contract_id,buy_sell,price,lots,opentime) VALUES (vsuser_id,vcontract,'S',pprice,plots,NOW());
		LEAVE cur_loop;	  
    END IF;
	IF curpr < pprice THEN
		INSERT INTO btc_action(action,account1,account2,amount,trans_id,input_dt,comment) VALUES ('move',vp_l,vsuser,(pprice-curpr)*least(curlt,plots),vtrans_id,NOW(),'S cl Profit');
	ELSEIF curpr > pprice THEN		
		INSERT INTO btc_action(action,account1,account2,amount,trans_id,input_dt,comment) VALUES ('move',vsuser,vp_l,(curpr-pprice)*least(curlt,plots),vtrans_id,NOW(),'S cl Loss');
	END IF;
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
call update_marketinfo(vcontract,pprice);
          
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_marketinfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_marketinfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `update_marketinfo`(IN `pcontract` INTEGER,IN `price` DECIMAL(20,10))
main:BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE highpr,lowpr DECIMAL(20,10);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SELECT high,low INTO highpr,lowpr FROM marketinfo WHERE contract_id = pcontract AND tradedate = CURDATE();
IF done THEN
	INSERT INTO marketinfo(contract_id,OPEN,high,low,CLOSE,tradedate) VALUES(pcontract,price,price,price,price,CURDATE());
ELSE
	IF price > highpr THEN
		SET highpr = price;
	END IF;
	IF price < lowpr THEN
		SET lowpr = price;
	END IF;
	UPDATE marketinfo SET high = highpr,low = lowpr,CLOSE = price WHERE contract_id = pcontract AND tradedate = CURDATE();
END IF;
UPDATE contract SET latestpoint = price / btc_multi WHERE contract_id = pcontract;
END */$$
DELIMITER ;

/*Table structure for table `v_account` */

DROP TABLE IF EXISTS `v_account`;

/*!50001 DROP VIEW IF EXISTS `v_account` */;
/*!50001 DROP TABLE IF EXISTS `v_account` */;

/*!50001 CREATE TABLE  `v_account`(
 `account` varchar(32) ,
 `address` char(34) ,
 `balance` decimal(20,8) 
)*/;

/*Table structure for table `v_btcbal` */

DROP TABLE IF EXISTS `v_btcbal`;

/*!50001 DROP VIEW IF EXISTS `v_btcbal` */;
/*!50001 DROP TABLE IF EXISTS `v_btcbal` */;

/*!50001 CREATE TABLE  `v_btcbal`(
 `user_id` int(11) ,
 `account` varchar(40) ,
 `balance` decimal(42,8) ,
 `bal_unconf` decimal(42,8) ,
 `bal_unact` decimal(43,8) ,
 `bal_avail` decimal(44,8) 
)*/;

/*Table structure for table `v_btcbal_p` */

DROP TABLE IF EXISTS `v_btcbal_p`;

/*!50001 DROP VIEW IF EXISTS `v_btcbal_p` */;
/*!50001 DROP TABLE IF EXISTS `v_btcbal_p` */;

/*!50001 CREATE TABLE  `v_btcbal_p`(
 `account` varchar(40) ,
 `balance` decimal(20,8) ,
 `bal_unconf` decimal(20,8) ,
 `bal_unact` decimal(21,8) 
)*/;

/*Table structure for table `v_pos` */

DROP TABLE IF EXISTS `v_pos`;

/*!50001 DROP VIEW IF EXISTS `v_pos` */;
/*!50001 DROP TABLE IF EXISTS `v_pos` */;

/*!50001 CREATE TABLE  `v_pos`(
 `user_id` int(11) ,
 `contract_id` int(11) ,
 `contract_name` varchar(8) ,
 `buy_sell` char(1) ,
 `lots` decimal(32,0) ,
 `cost` decimal(52,10) ,
 `marketvalue` double ,
 `margin` double 
)*/;

/*View structure for view v_account */

/*!50001 DROP TABLE IF EXISTS `v_account` */;
/*!50001 DROP VIEW IF EXISTS `v_account` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_account` AS select `btc_account`.`account` AS `account`,`btc_account`.`address` AS `address`,`btc_account`.`balance` AS `balance` from `btc_account` */;

/*View structure for view v_btcbal */

/*!50001 DROP TABLE IF EXISTS `v_btcbal` */;
/*!50001 DROP VIEW IF EXISTS `v_btcbal` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_btcbal` AS select `u`.`user_id` AS `user_id`,`t`.`account` AS `account`,sum(`t`.`balance`) AS `balance`,sum(`t`.`bal_unconf`) AS `bal_unconf`,sum(`t`.`bal_unact`) AS `bal_unact`,((sum(`t`.`balance`) + least(sum(`t`.`bal_unconf`),0)) + least(sum(`t`.`bal_unact`),0)) AS `bal_avail` from (`v_btcbal_p` `t` join `user` `u`) where (convert(`t`.`account` using utf8) = convert(`u`.`email` using utf8)) group by `u`.`user_id`,`t`.`account` */;

/*View structure for view v_btcbal_p */

/*!50001 DROP TABLE IF EXISTS `v_btcbal_p` */;
/*!50001 DROP VIEW IF EXISTS `v_btcbal_p` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_btcbal_p` AS select `ac`.`account` AS `account`,`ac`.`balance` AS `balance`,`ac`.`bal_unconf` AS `bal_unconf`,0 AS `bal_unact` from `btc_account` `ac` union all select `a`.`account1` AS `account1`,0 AS `0`,0 AS `0`,(-(1) * `a`.`amount`) AS `-1*a.amount` from `btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` in ('move','sendfrom'))) union all select `a`.`account2` AS `account2`,0 AS `0`,0 AS `0`,`a`.`amount` AS `amount` from `btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` = 'move')) union all select `a`.`account1` AS `account`,0 AS `0`,0 AS `0`,0 AS `0` from `btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` = 'createuser')) */;

/*View structure for view v_pos */

/*!50001 DROP TABLE IF EXISTS `v_pos` */;
/*!50001 DROP VIEW IF EXISTS `v_pos` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_pos` AS select `p`.`user_id` AS `user_id`,`p`.`contract_id` AS `contract_id`,`c`.`name` AS `contract_name`,`p`.`buy_sell` AS `buy_sell`,sum(`p`.`lots`) AS `lots`,sum((`p`.`lots` * `p`.`price`)) AS `cost`,sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) AS `marketvalue`,sum(((((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`) * `c`.`leverage`) / 100)) AS `margin` from (`positions` `p` join `contract` `c`) where (`p`.`contract_id` = `c`.`contract_id`) group by `p`.`user_id`,`p`.`contract_id`,`p`.`buy_sell`,`c`.`name` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
