-- MySQL dump 10.13  Distrib 5.1.61, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: btcfe
-- ------------------------------------------------------
-- Server version	5.1.61-0ubuntu0.10.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `btc_account`
--

DROP TABLE IF EXISTS `btc_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `btc_account` (
  `account` varchar(32) NOT NULL,
  `address` char(34) NOT NULL,
  `balance` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `bal_unconf` decimal(20,8) NOT NULL DEFAULT '0.00000000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `btc_action`
--

DROP TABLE IF EXISTS `btc_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `btc_action` (
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
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `btc_synclog`
--

DROP TABLE IF EXISTS `btc_synclog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `btc_synclog` (
  `type` char(8) NOT NULL,
  `lastblock` varchar(64) DEFAULT NULL,
  `status` char(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` varchar(96) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `btc_trans`
--

DROP TABLE IF EXISTS `btc_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `contract_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `fullname` varchar(32) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'N',
  `btc_multi` decimal(10,8) NOT NULL DEFAULT '1.00000000',
  `opendate` datetime DEFAULT NULL,
  `latestpoint` decimal(20,8) DEFAULT NULL,
  `settledate` datetime DEFAULT NULL,
  `settlepoint` decimal(20,8) DEFAULT NULL,
  `leverage` decimal(4,3) NOT NULL DEFAULT '0.250',
  `movelimit` decimal(3,2) NOT NULL DEFAULT '0.10',
  `owner` int(11) DEFAULT NULL,
  `twitter_id` varchar(16) DEFAULT NULL,
  `write_fee` decimal(6,6) unsigned DEFAULT '0.000000',
  `region` char(1) DEFAULT NULL,
  `sector` char(1) DEFAULT NULL,
  `settlemargin` decimal(20,8) DEFAULT '0.00000000',
  `description` varchar(512) DEFAULT NULL,
  `settleproof` varchar(512) DEFAULT NULL,
  `apinstruction` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_lock`
--

DROP TABLE IF EXISTS `exchange_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_lock` (
  `contract_id` int(11) NOT NULL,
  `connect_id` int(16) NOT NULL,
  `type` char(4) DEFAULT 'Deal',
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketinfo`
--

DROP TABLE IF EXISTS `marketinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketinfo` (
  `marketinfo_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `open` decimal(20,8) DEFAULT NULL,
  `high` decimal(20,8) DEFAULT NULL,
  `low` decimal(20,8) DEFAULT NULL,
  `close` decimal(20,8) DEFAULT NULL,
  `tradedate` date NOT NULL,
  PRIMARY KEY (`marketinfo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
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
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=latin1 COMMENT='deal order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `point` decimal(20,8) NOT NULL,
  `lots` int(11) NOT NULL,
  `opentime` datetime NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_status`
--

DROP TABLE IF EXISTS `sys_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_status` (
  `ss_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item` varchar(8) DEFAULT NULL,
  `value` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `teset` char(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trans`
--

DROP TABLE IF EXISTS `trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trans` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `buy_oid` int(11) NOT NULL,
  `sell_oid` int(11) NOT NULL,
  `point` decimal(20,8) NOT NULL,
  `lots` int(11) NOT NULL,
  `direct` char(1) DEFAULT 'B',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userattr`
--

DROP TABLE IF EXISTS `userattr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userattr` (
  `userattr_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` char(1) DEFAULT 'C',
  `coupon` decimal(2,2) DEFAULT NULL,
  `month` varchar(8) DEFAULT NULL,
  `comment` varchar(16) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`userattr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userbalance`
--

DROP TABLE IF EXISTS `userbalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userbalance` (
  `userbalance_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `balance_dt` date DEFAULT NULL,
  `balance` decimal(20,8) DEFAULT '0.00000000',
  `bal_fee` decimal(20,8) DEFAULT '0.00000000',
  `bal_pl` decimal(20,8) DEFAULT '0.00000000',
  `bal_btc` decimal(20,8) DEFAULT '0.00000000',
  `trade_vol` decimal(20,8) unsigned DEFAULT '0.00000000',
  PRIMARY KEY (`userbalance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userlog`
--

DROP TABLE IF EXISTS `userlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userlog` (
  `userlog_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `action` varchar(8) NOT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `times` smallint(6) DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userlog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `password2` varchar(40) DEFAULT NULL,
  `email_v` char(1) NOT NULL DEFAULT 'N',
  `feerate` decimal(6,6) NOT NULL DEFAULT '0.000100',
  `referrer` int(11) DEFAULT '0',
  `invite` decimal(3,1) DEFAULT '0.0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `v_btcunact`
--

DROP TABLE IF EXISTS `v_btcunact`;
/*!50001 DROP VIEW IF EXISTS `v_btcunact`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_btcunact` (
  `account` varchar(40),
  `amount` decimal(43,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_gl`
--

DROP TABLE IF EXISTS `v_gl`;
/*!50001 DROP VIEW IF EXISTS `v_gl`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_gl` (
  `sector` varchar(1),
  `trans_id` int(11),
  `contract_id` int(11),
  `type` varchar(34),
  `user_id` int(11),
  `buy_sell` char(1),
  `point` decimal(20,8),
  `lots` int(11),
  `value` decimal(40,16),
  `timestamp` datetime,
  `fee` decimal(21,8),
  `p_l` decimal(21,8),
  `btc` decimal(21,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_lastmonfee`
--

DROP TABLE IF EXISTS `v_lastmonfee`;
/*!50001 DROP VIEW IF EXISTS `v_lastmonfee`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_lastmonfee` (
  `account1` varchar(40),
  `fee` decimal(42,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_omargin`
--

DROP TABLE IF EXISTS `v_omargin`;
/*!50001 DROP VIEW IF EXISTS `v_omargin`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_omargin` (
  `user_id` int(11),
  `margin` decimal(65,19)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_orders`
--

DROP TABLE IF EXISTS `v_orders`;
/*!50001 DROP VIEW IF EXISTS `v_orders`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_orders` (
  `order_id` int(11),
  `user_id` int(11),
  `contract_id` int(11),
  `buy_sell` char(1),
  `point` decimal(20,8),
  `lots` int(11),
  `rm_lots` int(11),
  `createtime` datetime,
  `type` char(1),
  `status` char(1),
  `margin` decimal(44,19)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_pos`
--

DROP TABLE IF EXISTS `v_pos`;
/*!50001 DROP VIEW IF EXISTS `v_pos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_pos` (
  `user_id` int(11),
  `contract_id` int(11),
  `code` varchar(6),
  `buy_sell` char(1),
  `lots` decimal(32,0),
  `cost` decimal(62,16),
  `marketvalue` decimal(62,16),
  `p_l` decimal(63,16),
  `margin` decimal(65,19)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_rtradevol`
--

DROP TABLE IF EXISTS `v_rtradevol`;
/*!50001 DROP VIEW IF EXISTS `v_rtradevol`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_rtradevol` (
  `rtvol` decimal(65,16),
  `num` bigint(21),
  `user_id` int(11)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_tradevol`
--

DROP TABLE IF EXISTS `v_tradevol`;
/*!50001 DROP VIEW IF EXISTS `v_tradevol`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_tradevol` (
  `user_id` int(11),
  `tradevol` decimal(62,16)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_trans`
--

DROP TABLE IF EXISTS `v_trans`;
/*!50001 DROP VIEW IF EXISTS `v_trans`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_trans` (
  `trans_id` int(11),
  `contract_id` int(11),
  `type` char(1),
  `user_id` int(11),
  `buy_sell` char(1),
  `point` decimal(20,8),
  `lots` int(11),
  `value` decimal(40,16),
  `timestamp` timestamp,
  `fee` decimal(21,8),
  `p_l` decimal(21,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_userbtc`
--

DROP TABLE IF EXISTS `v_userbtc`;
/*!50001 DROP VIEW IF EXISTS `v_userbtc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_userbtc` (
  `user_id` int(11),
  `balance` decimal(44,8),
  `bal_unconf` decimal(20,8),
  `bal_unact` decimal(43,8),
  `onum` bigint(20),
  `omargin` decimal(65,19),
  `pnum` bigint(20),
  `pmargin` decimal(65,19),
  `p_l` decimal(65,16)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_userbtc_o`
--

DROP TABLE IF EXISTS `v_userbtc_o`;
/*!50001 DROP VIEW IF EXISTS `v_userbtc_o`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_userbtc_o` (
  `user_id` int(11),
  `num` bigint(21),
  `margin` decimal(65,19)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_userbtc_p`
--

DROP TABLE IF EXISTS `v_userbtc_p`;
/*!50001 DROP VIEW IF EXISTS `v_userbtc_p`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_userbtc_p` (
  `user_id` int(11),
  `num` bigint(21),
  `margin` decimal(65,19),
  `p_l` decimal(65,16)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'btcfe'
--
/*!50003 DROP FUNCTION IF EXISTS `f_CFEE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `f_CFEE`(`opendate` datetime, `settledate` datetime) RETURNS decimal(6,2)
BEGIN

DECLARE cfee1m decimal(3,2) DEFAULT 1;

	RETURN GREATEST(ceiling(datediff(settledate,opendate)/30),2) * cfee1m ;
	   
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_coupon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `f_coupon`(`puser` INT, `pmon` TINYINT) RETURNS decimal(6,6)
BEGIN

declare v_tvol,v_rtvol DECIMAL(20,8);

declare res decimal(6,6);

declare basedt datetime;



select NOW() +interval- pmon month into basedt;

select ifnull(sum(b.value),0) into v_tvol from v_trans b where b.user_id = puser and b.timestamp >= DATE_FORMAT(basedt+interval-1 month, '%Y-%m-01') and b.timestamp < DATE_FORMAT(basedt, '%Y-%m-01');

select ifnull(sum(b.value),0) into v_rtvol from v_trans b, users u where b.user_id = u.referrer and u.user_id = puser and b.timestamp >= DATE_FORMAT(basedt+interval-1 month, '%Y-%m-01') and b.timestamp < DATE_FORMAT(basedt, '%Y-%m-01');

select 1 - (1-ifnull(max(a.coupon),0)) * (1-f_RRate(v_tvol + v_rtvol)) into res  from userattr a where a.user_id = puser and a.month = DATE_FORMAT(basedt, '%Y-%m') and a.`type`='C';



return res;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_FRATE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `f_FRATE`(`pvol` DECIMAL(20,8)) RETURNS decimal(6,6)
BEGIN

#	IF pvol < 50 THEN

#		RETURN 0.004;

#    else

	IF pvol < 100 THEN

		RETURN 0.002;

	ELSEIF pvol < 200 THEN

		RETURN 0.0016;

	ELSEIF pvol < 500 THEN

		RETURN 0.0013;

	ELSEIF pvol < 1000 THEN

		RETURN 0.0011;

	ELSEIF pvol < 2000 THEN

		RETURN 0.001;

	ELSEIF pvol < 5000 THEN

		RETURN 0.0009;

	ELSEIF pvol < 10000 THEN

		RETURN 0.0008;

	ELSEIF pvol < 20000 THEN

		RETURN 0.0007;

	ELSE

		RETURN 0.002;

	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_N` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `f_N`(`b_s` CHAR(1)) RETURNS char(1) CHARSET latin1
BEGIN

    if b_s = 'B' then

		return 'S';

	elseif b_s = 'S' then

		return 'B';

	else

		return null;

	end if;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_RRATE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `f_RRATE`(`pvol` DECIMAL(20,8)) RETURNS decimal(6,6)
BEGIN

    IF pvol < 100 THEN

		RETURN 0.1;

	ELSEIF pvol < 400 THEN

		RETURN 0.2;

	ELSEIF pvol < 1500 THEN

		RETURN 0.3;

	ELSEIF pvol < 5000 THEN

		RETURN 0.4;

	ELSEIF pvol < 20000 THEN

		RETURN 0.5;

	ELSEIF pvol < 100000 THEN

		RETURN 0.6;

	ELSEIF pvol >= 500000 THEN

		RETURN 0.7;

	ELSEIF pvol >= 2000000 THEN

		RETURN 0.8;

	ELSE

		RETURN 0.1;

	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_addorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_addorder`(IN `pcontract` INTEGER, IN `puser` INTEGER, IN `pbs` CHAR(1), IN `ppoint` DECIMAL(20,8), IN `plots` INTEGER, IN `ptype` cHAR(1))
BEGIN

declare vplots int default 0;

DECLARE vmargin_req,vbtcavail DECIMAL(20,10) DEFAULT 0;

SELECT ifnull(sum(lots),0) into vplots FROM positions WHERE contract_id = pcontract AND user_id = puser AND buy_sell = f_N(pbs);

SELECT GREATEST(vplots-IFNULL(sum(rm_lots),0),0)INTO vplots FROM orders WHERE contract_id = pcontract AND user_id = puser AND buy_sell = pbs and type in('C','F') and status = 'O';

if vplots >= plots then

	#new order is a close order

	if ptype = 'F' then

		INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)

			VALUES(puser,pcontract,pbs,ppoint,plots,plots,'F',NOW(),'N');

	else

		INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)

			VALUES(puser,pcontract,pbs,ppoint,plots,plots,'C',NOW(),'N');

	end if;

	CALL p_exchange(LAST_INSERT_ID(),puser,'A');

elseif vplots < plots and 0 <= plots then

	if vplots > 0 then

	#close those part

		if ptype = 'F' then

			INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)

				VALUES(puser,pcontract,pbs,ppoint,vplots,vplots,'F',NOW(),'N');

		else

			INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)

				VALUES(puser,pcontract,pbs,ppoint,vplots,vplots,'C',NOW(),'N');		

		end if;

		CALL p_exchange(LAST_INSERT_ID(),puser,'A');

	end if;

	if plots - vplots > 0 then

	#open order

		SELECT ppoint*plots*btc_multi*leverage INTO vmargin_req FROM contract WHERE contract_id = pcontract AND STATUS = 'O';

		select balance - omargin - pmargin + p_l into vbtcavail from v_userbtc where user_id = puser;

		if vbtcavail > vmargin_req then

			INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)

				VALUES(puser,pcontract,pbs,ppoint,plots-vplots,plots-vplots,'O',NOW(),'N');

			CALL p_exchange(LAST_INSERT_ID(),puser,'A');

		else

			SELECT 'err',CONCAT('Margin is Not Enough.', vbtcavail,' | ',vmargin_req);

		end if;

	end if;	

end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_contractsettle_bak` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_contractsettle_bak`(IN `pcontract` INTEGER, IN `pprice` DECIMAL(20,10))
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

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_eod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_eod`()
BEGIN

declare v_lasteod date;

declare cursettledate datetime;

declare curcontract_id,curowner int;

declare curwrite_fee decimal(6,6);

declare v_cfee decimal(20,8);

DECLARE done INT DEFAULT FALSE;

DECLARE curc CURSOR FOR SELECT contract_id,write_fee,settledate,owner FROM contract where status in('O','C');

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

select ifnull(max(value),DATE_FORMAT(NOW()+interval - 1 month, '%Y-%m-%d')) into v_lasteod from sys_status where item = 'LAST_EOD';



if DATE_FORMAT(NOW(), '%Y-%m-%d') > DATE_FORMAT(v_lasteod+ interval +1 day, '%Y-%m-%d') then

	update users u join v_gl g on u.user_id = g.user_id and g.timestamp >= DATE_FORMAT(v_lasteod+ interval +1 day, '%Y-%m-%d') and g.timestamp < DATE_FORMAT(NOW(), '%Y-%m-%d')

		set u.invite = u.invite + 1/(u.invite + 1);



OPEN curc;

cur_loop:LOOP

	FETCH curc INTO curcontract_id,curwrite_fee,cursettledate,curowner;

	IF done THEN LEAVE cur_loop; end if;

	

	if DATE_FORMAT(v_lasteod+ interval +1 day, '%Y-%m-%d') < DATE_FORMAT(NOW(), '%Y-%m-01') then

		select ifnull(sum(t.value * c.write_fee*(1-f_coupon(t.user_id,1))),0) into v_cfee from v_trans t,contract c 

			where t.contract_id = c.contract_id and t.contract_id = curcontract_id and t.timestamp >= DATE_FORMAT(v_lasteod+ interval +1 day, '%Y-%m-%d') and t.timestamp < DATE_FORMAT(NOW(), '%Y-%m-01');

		select ifnull(sum(t.value * c.write_fee*(1-f_coupon(t.user_id,0))),0) + v_cfee into v_cfee from v_trans t,contract c 

			where t.contract_id = c.contract_id and t.contract_id = curcontract_id and t.timestamp >= DATE_FORMAT(NOW(), '%Y-%m-01') and t.timestamp < DATE_FORMAT(NOW(), '%Y-%m-%d');

	else

		select ifnull(sum(t.value * c.write_fee*(1-f_coupon(t.user_id,0))),0) into v_cfee from v_trans t,contract c 

			where t.contract_id = c.contract_id and t.contract_id = curcontract_id and t.timestamp >= DATE_FORMAT(v_lasteod+ interval +1 day, '%Y-%m-%d') and t.timestamp < DATE_FORMAT(NOW(), '%Y-%m-%d');

	end if;

	if v_cfee > 0 then

		if datediff(cursettledate,v_lasteod) >30 then 

			insert into btc_action(action,account1,account2,address,amount,trans_id,type,input_dt) 

				select 'move',u.email,'FEE',concat(DATE_FORMAT(NOW() + interval -1 day, '%Y-%m-%d')),-1*v_cfee,curcontract_id,'C',NOW() from users u 

				where u.user_id = curowner ;

		else

			update contract set settlemargin = settlemargin + v_cfee where contract_id = curcontract_id;

		end if;

	end if;

end loop;

insert into sys_status(item,value) values('LAST_EOD',DATE_FORMAT(NOW() + interval -1 day, '%Y-%m-%d'));

commit;

end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_eom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_eom`()
BEGIN

declare v_lastr datetime;

select ifnull(max(input_dt),NOW() + interval -1 month) into v_lastr from btc_action where account2 = 'FEE' and type = 'R';

if DATE_FORMAT(NOW(), '%Y-%m') > DATE_FORMAT(v_lastr, '%Y-%m') then

	insert into btc_action(action,account1,account2,address,amount,type,input_dt) 

		select 'move',u.email,'FEE',concat(DATE_FORMAT(NOW()+interval-1 month, '%Y-%m'),' ',round(100*f_coupon(b.user_id,1),1),'%'),ifnull(sum(b.fee),0)*f_coupon(b.user_id,1),'R',NOW() from v_trans b ,users u

		where b.user_id = u.user_id and b.timestamp >= DATE_FORMAT(NOW()+interval-1 month, '%Y-%m-01') and b.timestamp < DATE_FORMAT(NOW(), '%Y-%m-01')	group by u.email,b.user_id;

	delete from userattr where month < DATE_FORMAT(NOW()+interval-1 month, '%Y-%m');

	commit;

end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_eom_bak` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `p_eom_bak`()
BEGIN

declare v_month1,v_month2,curemail varchar(8);

declare curuid int;

declare v_cp DECIMAL(8,7);

declare v_tvol,v_rtvol,v_ufee DECIMAL(20,8);

DECLARE done INT DEFAULT FALSE;

DECLARE curu CURSOR FOR SELECT user_id,email FROM users;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;



select ifnull(max(value),DATE_FORMAT(NOW()+interval - 1 month, '%Y-%m')) into v_month1 from sys_status where item = 'NX_EOM';

set v_month2 = DATE_FORMAT(now(), '%Y-%m');



if v_month2 > v_month1 then



OPEN curu;

cur_loop:LOOP

	FETCH curu INTO curuid,curemail;	

	IF done THEN LEAVE cur_loop; end if;

	

	select ifnull(sum(b.value),0),ifnull(sum(b.fee),0) into v_tvol,v_ufee from v_trans b where b.user_id = curuid and b.timestamp >= concat(v_month1,'-01') and b.timestamp < concat(v_month2,'-01');

	select ifnull(sum(b.value),0) into v_rtvol from v_trans b, users u where b.user_id = u.referrer and u.user_id = curuid and b.timestamp >= concat(v_month1,'-01') and b.timestamp < concat(v_month2,'-01');

	

	insert into userattr(user_id,type,coupon,month,comment,create_dt) 

		values(curuid,'M',f_RRate(v_tvol + v_rtvol),v_month2,v_tvol + v_rtvol,NOW());



	select ifnull(max(a.coupon),0) into v_cp from userattr a where a.user_id = curuid and a.month = v_month1 and a.`type`='C';

	select 1 - (1-ifnull(max(a.coupon),0)) * (1-v_cp) into v_cp from userattr a where a.user_id = curuid and a.month = v_month1 and a.`type`='M';

	

	if v_ufee <> 0 then

		insert into btc_action(action,account1,account2,address,amount,type,input_dt) 

			values('move',curemail,'FEE',concat(v_month1), -v_ufee * v_cp,'R',NOW());

	end if;

end loop;



insert into sys_status(item,value) values('NX_EOM',v_month2);

commit;

end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_exchange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_exchange`(IN `poid` integer, IN `puserid` INTEGER, IN `paction` char)
main:BEGIN

DECLARE done,dealflag INT DEFAULT FALSE;

DECLARE locktype char(4);

DECLARE pcontract INT;

DECLARE vbuy_sell CHAR(1);

DECLARE vpoint,curpr DECIMAL(20,8);

DECLARE vuser,vrm_lots, curoid,curuser,curlt INT;

DECLARE curs CURSOR FOR SELECT order_id,point,rm_lots FROM orders 

    where contract_id = pcontract AND status = 'O' AND buy_sell ='S' ORDER BY point ,type='F' DESC,createtime;

DECLARE curb CURSOR FOR SELECT order_id,point,rm_lots FROM orders 

    where contract_id = pcontract AND status = 'O' AND buy_sell ='B' ORDER BY point DESC ,type='F' DESC,createtime;

DECLARE EXIT HANDLER FOR SQLEXCEPTION

  BEGIN

    ROLLBACK;select 'Err','SQLEXCEPTION';

  END;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

SELECT user_id,contract_id,buy_sell,point,rm_lots INTO vuser,pcontract,vbuy_sell,vpoint,vrm_lots FROM orders where order_id = poid and status IN('N','O');

if done or vuser <> puserid then

	SELECT 'Err','Have not found your Order.';

	leave main;

end if;

SELECT max(type) into locktype from exchange_lock where contract_id = pcontract;

IF locktype is not null THEN

	select 'Err',concat('Exchange Server Locked by ',contractlock);

	leave main;

END IF;

INSERT into exchange_lock(contract_id,connect_id) VALUES(pcontract,CONNECTION_ID());

COMMIT;

SELECT max(type) into locktype from exchange_lock where contract_id = pcontract and connect_id <> CONNECTION_ID();

IF locktype is not null THEN

	delete from exchange_lock where contract_id = pcontract AND connect_id = CONNECTION_ID();

	commit;

	SELECT 'Err',('Exchange Server Locked Failed by',locktype);

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

			call p_makedeal(poid,curoid,curpr,LEAST(vrm_lots,curlt),'B');

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

      		call p_makedeal(curoid,poid,curpr,LEAST(vrm_lots,curlt),'S');

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

		SELECT 'suc','Order had been Added.';

	end if;

END IF;

DELETE FROM exchange_lock where contract_id = pcontract;

COMMIT;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_forced_close` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_forced_close`(IN `puserid` INTEGER, IN `prealseamt` decimal(20,8))
main:BEGIN

DECLARE done INT DEFAULT FALSE;

DECLARE curcid,curlt,vclots INT default 0;

declare curbs char(1);

declare vclosepoint DECIMAL(20,8);

DECLARE curp CURSOR FOR SELECT contract_id,buy_sell,lots FROM v_pos WHERE user_id = puserid ORDER BY p_l Desc;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN curp;

cur_loop:LOOP

	FETCH curp INTO curcid,curbs,curlt;	

	IF done OR prealseamt <= 0 THEN

		LEAVE cur_loop;					

	end if;

	select CEIL(prealseamt/(latestpoint*btc_multi*leverage)),latestpoint into vclots,vclosepoint from contract where contract_id = curcid;

	# move 10% latest point as close point

	if curbs = 'S' then

		set vclosepoint = vclosepoint * 1.1;

	else

		SET vclosepoint = vclosepoint * 0.9;

	end if;	

	if vclots < curlt then

		call p_addorder(curcid,puserid,f_N(curbs),vclosepoint,vclots);

		set prealseamt = 0 ;

	else

		call p_addorder(curcid,puserid,f_N(curbs),vclosepoint,curlt);

		SELECT prealseamt - (curlt*latestpoint*btc_multi*leverage) INTO prealseamt FROM contract WHERE contract_id = curcid;

	end if;

end loop;

select prealseamt;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_makedeal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_makedeal`(IN `pbuy_oid` INTEGER, IN `psell_oid` INTEGER, IN `ppoint` DECIMAL(20,8), IN `plots` INTEGER, IN `pdirect` CHAR(1))
BEGIN

DECLARE done INT DEFAULT FALSE;

DECLARE vbfeerate,vsfeerate,vcfeerate DECIMAL(6,6);

DECLARE vcbtcmulti DECIMAL(10,8);

DECLARE curpr,vplamount DECIMAL(20,8);

declare vbtype, vstype char(1);

DECLARE curposition,curlt,vcontract,vbuser_id,vsuser_id,vtrans_id,v_lots INT;

DECLARE vbuser,vsuser,vfee,vcfee,vp_l VARCHAR(40);

DECLARE curb CURSOR FOR SELECT position_id,point,lots FROM positions

	WHERE contract_id = vcontract AND buy_sell ='B' AND user_id = vsuser_id ORDER BY opentime;

DECLARE curs CURSOR FOR SELECT position_id,point,lots FROM positions 

	WHERE contract_id = vcontract AND buy_sell ='S' AND user_id = vbuser_id ORDER BY opentime;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

SET vfee ='FEE'; SET vp_l ='P_L';

SELECT u.user_id,u.email,u.feerate,o.contract_id,o.type INTO vbuser_id,vbuser,vbfeerate,vcontract,vbtype FROM orders o, users u WHERE o.user_id = u.user_id AND o.order_id = pbuy_oid;

SELECT u.user_id,u.email,u.feerate,o.type,c.btc_multi,c.write_fee INTO vsuser_id,vsuser,vsfeerate,vstype,vcbtcmulti,vcfeerate FROM orders o, users u,contract c WHERE o.contract_id = c.contract_id and o.user_id = u.user_id AND o.order_id = psell_oid;

INSERT INTO trans(buy_oid,sell_oid,point,lots,direct) VALUES (pbuy_oid,psell_oid,ppoint,plots,pdirect);

SELECT LAST_INSERT_ID() INTO vtrans_id;

INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vbuser,vfee,ppoint*plots*vcbtcmulti*(vbfeerate+vcfeerate),vtrans_id,NOW(),'F')

		, ('move',vsuser,vfee,ppoint*plots*vcbtcmulti*(vsfeerate+vcfeerate),vtrans_id,NOW(),'G');



SET done = FALSE;	

SET v_lots = plots; SET vplamount = 0;

if vbtype = 'O' then	#open order

	INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vbuser_id,vcontract,'B',ppoint,v_lots,NOW());

else				#close order

	OPEN curs;

	cur_loop:LOOP

	FETCH curs INTO curposition,curpr,curlt;			

		IF done THEN



			INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vbuser_id,vcontract,'B',ppoint,v_lots,NOW());

			LEAVE cur_loop;	  

		END IF;

		SET vplamount = vplamount + (ppoint-curpr)*vcbtcmulti*LEAST(curlt,v_lots);		

		IF curlt <= v_lots THEN

			DELETE FROM positions WHERE position_id = curposition;            

		END IF;

		IF curlt < v_lots THEN

			SET v_lots = v_lots - curlt;					

		ELSEIF curlt >= v_lots THEN

			UPDATE positions SET lots = curlt - v_lots WHERE position_id = curposition; 

			LEAVE cur_loop;           

		END IF; 

	END LOOP;

	CLOSE curs;

	if vplamount <> 0 then

		INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vbuser,vp_l,vplamount,vtrans_id,NOW(),'P');

	end if;

end if;

SET v_lots = plots; SET vplamount = 0;

if vstype = 'O' then	#open order

	INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vsuser_id,vcontract,'S',ppoint,v_lots,NOW());

else		#close order

	SET done = FALSE;	

	OPEN curb;

	cur_loop:LOOP

		FETCH curb INTO curposition,curpr,curlt;			

		IF done THEN

			INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vsuser_id,vcontract,'S',ppoint,v_lots,NOW());

			LEAVE cur_loop;	  

		END IF;

		SET vplamount = vplamount + (curpr-ppoint)*vcbtcmulti*LEAST(curlt,v_lots);			

		IF curlt <= v_lots THEN

			DELETE FROM positions WHERE position_id = curposition;            

		END IF;

		IF curlt < v_lots THEN

			SET v_lots = v_lots - curlt;					

		ELSEIF curlt >= v_lots THEN

			UPDATE positions SET lots = curlt - v_lots WHERE position_id = curposition; 

			LEAVE cur_loop;           

		END IF; 

	END LOOP;

	CLOSE curb;     

	if vplamount <> 0 then

		INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vsuser,vp_l,vplamount,vtrans_id,NOW(),'Q');

	end if;

end if;

UPDATE contract SET latestpoint = ppoint WHERE contract_id = vcontract;

#CALL p_update_marketinfo(vcontract,ppoint);

          

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_contract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_update_contract`(IN `cid` integer, IN `pcode` varchar(8), IN `pbtc_multi` decimal(10,8), IN `popendate` datetime, IN `psettledate` datetime, IN `pleverage` decimal(4,3), IN `pfullname` varchar(32), IN `puser` INTEGER, IN `ptwitter_id` varchar(16), IN `pwrite_fee` deCIMAL(6,6), IN `pregion` char(1), IN `psector` char(1), IN `pdescription` varchar(512), IN `pmovelimit` decIMAL(3,2))
main:BEGIN

DECLARE vfee_req,vbtcavail DECIMAL(20,10) DEFAULT 0;

declare res int default 0;

DECLARE vfee VARCHAR(40) default 'FEE';

SELECT count(1) into res FROM contract WHERE code=pcode and DATE_FORMAT(settledate,'%%y%%m') = DATE_FORMAT(psettledate,'%%y%%m') and 

    contract_id <> cid and status <> 'D';

if res > 0 then

	select 'err',CONCAT('Contract ',pcode,DATE_FORMAT(psettledate,'%y%m'),' already exist.'),cid;

	leave main;

end if;

SELECT f_CFEE(popendate,psettledate) - IFNULL(max(f_CFEE( opendate,settledate)),0) INTO vfee_req FROM contract WHERE contract_id = cid ;

SELECT balance - omargin - pmargin + p_l INTO vbtcavail FROM v_userbtc WHERE user_id = puser;

IF vbtcavail > vfee_req THEN

	if cid > 0 then

		UPDATE contract SET code=pcode,btc_multi=pbtc_multi,opendate=popendate,settledate=psettledate,leverage=pleverage,fullname=pfullname,

			twitter_id=ptwitter_id,write_fee=pwrite_fee,region=pregion,sector=psector,description=pdescription,movelimit=pmovelimit WHERE contract_id = cid;

		if vfee_req <> 0 then

	      INSERT INTO btc_action(ACTION,account1,account2,address,amount,trans_id,input_dt,TYPE) 

			select 'move',email,vfee,'update',vfee_req,cid,NOW(),'H' from users where user_id = puser;

		end if;

    else

		INSERT INTO contract(code,btc_multi,opendate,settledate,leverage,fullname,owner,twitter_id,write_fee,region,sector,description,movelimit) VALUES 

            (pcode,pbtc_multi,popendate,psettledate,pleverage,pfullname,puser,ptwitter_id,pwrite_fee,pregion,psector,pdescription,pmovelimit);	

      	select last_insert_id() into cid;

      	if vfee_req <> 0 then

	      INSERT INTO btc_action(ACTION,account1,account2,address,amount,trans_id,input_dt,TYPE) 

            select 'move',email,vfee,'create',vfee_req,cid,NOW(),'H' from users where user_id = puser;

    	end if;

	end if;

	commit;

	select 'suc',concat('Contract ',cid,' Saved successfully.'),cid;

ELSE

	SELECT 'err',CONCAT('BTC is Not Enough. ',vfee_req,' required, ',vbtcavail,' available.'),cid;

END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_update_marketinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_update_marketinfo`(IN `pcontract` INTEGER, IN `point` DECIMAL(20,10))
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

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_btcunact`
--

/*!50001 DROP TABLE IF EXISTS `v_btcunact`*/;
/*!50001 DROP VIEW IF EXISTS `v_btcunact`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_btcunact` AS select `a`.`account1` AS `account`,(-(1) * sum(`a`.`amount`)) AS `amount` from `btc_action` `a` where (`a`.`status` = 'N') group by `a`.`account1` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_gl`
--

/*!50001 DROP TABLE IF EXISTS `v_gl`*/;
/*!50001 DROP VIEW IF EXISTS `v_gl`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_gl` AS select 'T' AS `sector`,`t`.`trans_id` AS `trans_id`,`t`.`contract_id` AS `contract_id`,`t`.`type` AS `type`,`t`.`user_id` AS `user_id`,`t`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,`t`.`value` AS `value`,`t`.`timestamp` AS `timestamp`,`t`.`fee` AS `fee`,`t`.`p_l` AS `p_l`,NULL AS `btc` from `v_trans` `t` union all select 'R' AS `R`,NULL AS `NULL`,`a`.`trans_id` AS `trans_id`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'R') and (`a`.`account1` = `u`.`email`)) union all select 'C' AS `C`,NULL AS `NULL`,`a`.`trans_id` AS `trans_id`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,NULL AS `NULL`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'C') and (`a`.`account1` = `u`.`email`)) union all select 'H' AS `H`,NULL AS `NULL`,`a`.`trans_id` AS `trans_id`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'H') and (`a`.`account1` = `u`.`email`)) union all select 'A' AS `H`,NULL AS `NULL`,NULL AS `NULL`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,NULL AS `NULL`,`a`.`amount` AS `a.amount`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'A') and (`a`.`account1` = `u`.`email`)) union all select 'B' AS `B`,NULL AS `NULL`,NULL AS `NULL`,`b`.`type` AS `type`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`b`.`timestamp` AS `timestamp`,NULL AS `NULL`,NULL AS `NULL`,(`b`.`amount` + `b`.`fee`) AS `b.amount+b.fee` from (`btc_trans` `b` join `users` `u`) where (`b`.`user` = `u`.`email`) union all select 'B' AS `B`,NULL AS `NULL`,NULL AS `NULL`,'in way' AS `in way`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,NULL AS `NULL`,NULL AS `NULL`,-(`a`.`amount`) AS `-a.amount` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'W') and (`a`.`status` = 'N') and (`a`.`account1` = `u`.`email`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_lastmonfee`
--

/*!50001 DROP TABLE IF EXISTS `v_lastmonfee`*/;
/*!50001 DROP VIEW IF EXISTS `v_lastmonfee`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_lastmonfee` AS select `btc_action`.`account1` AS `account1`,sum(`btc_action`.`amount`) AS `fee` from `btc_action` where ((`btc_action`.`account2` = 'FEE') and (`btc_action`.`type` in ('F','G')) and (extract(year_month from `btc_action`.`input_dt`) = extract(year_month from (now() + interval -(1) month)))) group by `btc_action`.`account1` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_omargin`
--

/*!50001 DROP TABLE IF EXISTS `v_omargin`*/;
/*!50001 DROP VIEW IF EXISTS `v_omargin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_omargin` AS select `o`.`user_id` AS `user_id`,sum((((`o`.`point` * `o`.`rm_lots`) * `c`.`btc_multi`) * `c`.`leverage`)) AS `margin` from (`orders` `o` join `contract` `c`) where ((`o`.`status` = 'O') and (`o`.`type` = 'O') and (`o`.`contract_id` = `c`.`contract_id`)) group by `o`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_orders`
--

/*!50001 DROP TABLE IF EXISTS `v_orders`*/;
/*!50001 DROP VIEW IF EXISTS `v_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_orders` AS select `o`.`order_id` AS `order_id`,`o`.`user_id` AS `user_id`,`o`.`contract_id` AS `contract_id`,`o`.`buy_sell` AS `buy_sell`,`o`.`point` AS `point`,`o`.`lots` AS `lots`,`o`.`rm_lots` AS `rm_lots`,`o`.`createtime` AS `createtime`,`o`.`type` AS `type`,`o`.`status` AS `status`,(case when (`o`.`type` = 'O') then (((`o`.`lots` * `o`.`point`) * `c`.`btc_multi`) * `c`.`leverage`) else 0 end) AS `margin` from (`orders` `o` join `contract` `c`) where ((`o`.`contract_id` = `c`.`contract_id`) and (`o`.`status` = 'O')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_pos`
--

/*!50001 DROP TABLE IF EXISTS `v_pos`*/;
/*!50001 DROP VIEW IF EXISTS `v_pos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_pos` AS select `p`.`user_id` AS `user_id`,`p`.`contract_id` AS `contract_id`,`c`.`code` AS `code`,`p`.`buy_sell` AS `buy_sell`,sum(`p`.`lots`) AS `lots`,sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`)) AS `cost`,sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) AS `marketvalue`,(case when (`p`.`buy_sell` = 'B') then (sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) - sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`))) else (sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`)) - sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`))) end) AS `p_l`,sum((((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`) * `c`.`leverage`)) AS `margin` from (`positions` `p` join `contract` `c`) where (`p`.`contract_id` = `c`.`contract_id`) group by `p`.`user_id`,`p`.`contract_id`,`p`.`buy_sell`,`c`.`code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_rtradevol`
--

/*!50001 DROP TABLE IF EXISTS `v_rtradevol`*/;
/*!50001 DROP VIEW IF EXISTS `v_rtradevol`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_rtradevol` AS select sum(`v`.`tradevol`) AS `rtvol`,count(1) AS `num`,`u`.`referrer` AS `user_id` from (`users` `u` left join `v_tradevol` `v` on((`v`.`user_id` = `u`.`user_id`))) group by `u`.`referrer` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_tradevol`
--

/*!50001 DROP TABLE IF EXISTS `v_tradevol`*/;
/*!50001 DROP VIEW IF EXISTS `v_tradevol`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tradevol` AS select `v_trans`.`user_id` AS `user_id`,sum(`v_trans`.`value`) AS `tradevol` from `v_trans` where (`v_trans`.`timestamp` > (now() + interval -(1) month)) group by `v_trans`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_trans`
--

/*!50001 DROP TABLE IF EXISTS `v_trans`*/;
/*!50001 DROP VIEW IF EXISTS `v_trans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_trans` AS select `t`.`trans_id` AS `trans_id`,`o`.`contract_id` AS `contract_id`,`o`.`type` AS `type`,`o`.`user_id` AS `user_id`,`o`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,((`t`.`point` * `t`.`lots`) * `c`.`btc_multi`) AS `value`,`t`.`timestamp` AS `timestamp`,-(`a`.`amount`) AS `fee`,-(`b`.`amount`) AS `p_l` from (`orders` `o` join (`contract` `c` join ((`trans` `t` left join `btc_action` `a` on(((`t`.`trans_id` = `a`.`trans_id`) and (`a`.`type` = 'F')))) left join `btc_action` `b` on(((`t`.`trans_id` = `b`.`trans_id`) and (`b`.`type` = 'P')))))) where ((`t`.`buy_oid` = `o`.`order_id`) and (`o`.`contract_id` = `c`.`contract_id`)) union all select `t`.`trans_id` AS `trans_id`,`o`.`contract_id` AS `contract_id`,`o`.`type` AS `type`,`o`.`user_id` AS `user_id`,`o`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,((`t`.`point` * `t`.`lots`) * `c`.`btc_multi`) AS `VALUE`,`t`.`timestamp` AS `timestamp`,-(`a`.`amount`) AS `fee`,-(`b`.`amount`) AS `p_l` from (`orders` `o` join (`contract` `c` join ((`trans` `t` left join `btc_action` `a` on(((`t`.`trans_id` = `a`.`trans_id`) and (`a`.`type` = 'G')))) left join `btc_action` `b` on(((`t`.`trans_id` = `b`.`trans_id`) and (`b`.`type` = 'Q')))))) where ((`t`.`sell_oid` = `o`.`order_id`) and (`o`.`contract_id` = `c`.`contract_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_userbtc`
--

/*!50001 DROP TABLE IF EXISTS `v_userbtc`*/;
/*!50001 DROP VIEW IF EXISTS `v_userbtc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_userbtc` AS select `u`.`user_id` AS `user_id`,(ifnull(`b`.`balance`,0) + ifnull(`a`.`amount`,0)) AS `balance`,ifnull(`b`.`bal_unconf`,0) AS `bal_unconf`,ifnull(`a`.`amount`,0) AS `bal_unact`,ifnull(`o`.`num`,0) AS `onum`,ifnull(`o`.`margin`,0) AS `omargin`,ifnull(`p`.`num`,0) AS `pnum`,ifnull(`p`.`margin`,0) AS `pmargin`,ifnull(`p`.`p_l`,0) AS `p_l` from ((((`users` `u` left join `v_userbtc_o` `o` on((`u`.`user_id` = `o`.`user_id`))) left join `v_userbtc_p` `p` on((`u`.`user_id` = `p`.`user_id`))) left join `btc_account` `b` on((`u`.`email` = `b`.`account`))) left join `v_btcunact` `a` on((`u`.`email` = `a`.`account`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_userbtc_o`
--

/*!50001 DROP TABLE IF EXISTS `v_userbtc_o`*/;
/*!50001 DROP VIEW IF EXISTS `v_userbtc_o`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_userbtc_o` AS select `v_orders`.`user_id` AS `user_id`,count(1) AS `num`,sum(`v_orders`.`margin`) AS `margin` from `v_orders` group by `v_orders`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_userbtc_p`
--

/*!50001 DROP TABLE IF EXISTS `v_userbtc_p`*/;
/*!50001 DROP VIEW IF EXISTS `v_userbtc_p`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_userbtc_p` AS select `v_pos`.`user_id` AS `user_id`,count(1) AS `num`,sum(`v_pos`.`margin`) AS `margin`,sum(`v_pos`.`p_l`) AS `p_l` from `v_pos` group by `v_pos`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-29 13:35:35
