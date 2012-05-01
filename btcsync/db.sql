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
-- Dumping data for table `btc_account`
--

LOCK TABLES `btc_account` WRITE;
/*!40000 ALTER TABLE `btc_account` DISABLE KEYS */;
INSERT INTO `btc_account` VALUES ('P_L','1NzDocGM8WbjwPkZ6oXanfHybubbC7ZZME','0.00000000','0.00000000'),('jian.xie@hotmail.com','17qLfgv2L7uu6VnX8KuzWYvTQaweYmXDgm','0.20000000','0.00000000'),('FEE','1DSxsg47KjqtZhC9tEvyiSCSViV2PCknKt','0.30000000','0.00000000'),('jian.xie@163.com','12PmmPcqY6SJfhwzSzbHmCXQ61wPjM9vCs','0.39950000','0.00000000');
/*!40000 ALTER TABLE `btc_account` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=890422 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `btc_action`
--

LOCK TABLES `btc_action` WRITE;
/*!40000 ALTER TABLE `btc_action` DISABLE KEYS */;
INSERT INTO `btc_action` VALUES (437,'createuser','jian.xie@163.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-03-28 14:22:40','2012-03-28 14:22:56','0.09950000'),(438,'createuser','jian.xie@hotmail.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-03-28 14:23:52','2012-03-28 14:23:57','0.50000000'),(439,'move','jian.xie@hotmail.com','FEE','create','0.30000000','H','S',27,'2012-03-28 15:07:35','2012-03-28 15:07:37','1'),(890400,'move','jian.xie@hotmail.com','FEE',NULL,'0.00050000','F','N',22,'2012-03-30 16:52:34',NULL,NULL),(890401,'move','jian.xie@163.com','FEE',NULL,'0.00050000','G','N',22,'2012-03-30 16:52:34',NULL,NULL),(890402,'move','jian.xie@hotmail.com','FEE','2012-03-30','-0.00018000','C','N',27,'2012-03-31 16:52:52',NULL,NULL),(890403,'move','jian.xie@hotmail.com','FEE',NULL,'0.00050000','F','N',23,'2012-03-31 16:53:20',NULL,NULL),(890404,'move','jian.xie@163.com','FEE',NULL,'0.00050000','G','N',23,'2012-03-31 16:53:20',NULL,NULL),(890405,'move','jian.xie@hotmail.com','FEE','2012-03-31','-0.00018000','C','N',27,'2012-04-01 16:53:55',NULL,NULL),(890406,'move','jian.xie@163.com','FEE','2012-03 10.0%','-0.00010000','R','N',NULL,'2012-04-01 16:53:55',NULL,NULL),(890407,'move','jian.xie@hotmail.com','FEE','2012-03 10.0%','-0.00010000','R','N',NULL,'2012-04-01 16:53:55',NULL,NULL),(890409,'move','jian.xie@hotmail.com','FEE',NULL,'0.00050000','F','N',24,'2012-04-01 16:54:43',NULL,NULL),(890410,'move','jian.xie@163.com','FEE',NULL,'0.00050000','G','N',24,'2012-04-01 16:54:43',NULL,NULL),(890411,'move','jian.xie@hotmail.com','FEE','2012-04-01','-0.00016200','C','N',27,'2012-04-02 16:54:56',NULL,NULL),(890412,'move','jian.xie@hotmail.com','FEE',NULL,'0.00050000','F','N',25,'2012-04-02 17:00:16',NULL,NULL),(890413,'move','jian.xie@163.com','FEE',NULL,'0.00050000','G','N',25,'2012-04-02 17:00:16',NULL,NULL),(890414,'move','jian.xie@163.com','FEE','2012-04 19.0%','-0.00019000','R','N',NULL,'2012-05-01 17:02:55',NULL,NULL),(890415,'move','jian.xie@hotmail.com','FEE','2012-04 19.0%','-0.00019000','R','N',NULL,'2012-05-01 17:02:55',NULL,NULL),(890417,'move','jian.xie@163.com','FEE',NULL,'0.00240000','F','N',26,'2012-05-01 17:03:55',NULL,NULL),(890418,'move','jian.xie@hotmail.com','FEE',NULL,'0.00240000','G','N',26,'2012-05-01 17:03:55',NULL,NULL),(890419,'move','jian.xie@163.com','P_L',NULL,'0.08000000','P','N',26,'2012-05-01 17:03:55',NULL,NULL),(890420,'move','jian.xie@163.com','P_L',NULL,'-0.08000000','Q','N',26,'2012-05-01 17:03:55',NULL,NULL),(890421,'move','jian.xie@hotmail.com','FEE','settle','-0.00016200','C','N',27,'2012-05-01 17:03:55',NULL,NULL);
/*!40000 ALTER TABLE `btc_action` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `btc_synclog`
--

LOCK TABLES `btc_synclog` WRITE;
/*!40000 ALTER TABLE `btc_synclog` DISABLE KEYS */;
INSERT INTO `btc_synclog` VALUES ('serv',NULL,'B','2012-03-28 06:08:31','192.168.168.122:8332'),('trans','0000000000000513d81e6acfd9fc22d61f319f1dbf196a2f9eff5fc66a79b957','S','2012-03-28 06:08:34','6'),('serv',NULL,'E','2012-03-28 06:14:56','192.168.168.122:8332'),('serv',NULL,'B','2012-03-28 06:14:57','192.168.168.122:8332'),('serv',NULL,'E','2012-03-28 06:17:51','192.168.168.122:8332'),('serv',NULL,'B','2012-03-28 06:17:52','192.168.168.122:8332'),('serv',NULL,'E','2012-03-28 06:30:38','192.168.168.122:8332'),('serv',NULL,'B','2012-03-28 06:30:40','192.168.168.122:8332'),('trans','00000000000007a7ed28ddcb2114acd06ec599e64722a6fb2dab949efd1dcd73','S','2012-03-28 06:53:15','1'),('trans','00000000000005d3137f7252420c8f2345f7dea7b5716dd0372bb08ea04e0828','S','2012-03-28 07:05:03','1'),('trans','000000000000097260f4faa542cea17b506aee0bc4c3dd2d74df9a10bf073593','S','2012-03-28 07:10:43','1'),('trans','00000000000005f789e072a3ffd840d6787ebc950627c467187bedccfd2fe431','S','2012-03-28 07:11:14','1'),('serv',NULL,'E','2012-03-28 07:27:58','192.168.168.122:8332');
/*!40000 ALTER TABLE `btc_synclog` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `btc_trans`
--

LOCK TABLES `btc_trans` WRITE;
/*!40000 ALTER TABLE `btc_trans` DISABLE KEYS */;
INSERT INTO `btc_trans` VALUES ('send','jian.xie@163.com','-0.10000000','-0.00050000','1JwXvhNAuvHEHaJbCzWKHaoM4XPXReeu9p',16643,'01943011c067e4195a2c0d891d4c5e1a671fc2e1a192c062eb5592bd16290118','2011-12-08 08:05:48'),('receive','jian.xie@163.com','0.30000000','0.00000000','12NuhVyvntvBZdcaLPUojkMa455wNoF1kX',2,'2c9f01baeead84ec3a872beac3a44979df69e68eb7e8b1543f7094ba0299253a','2012-03-28 06:17:19'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',16654,'4c449c7d5e32a45e59f12d7933ecc01b1b9ba5f577b1ebd3427dfb95f6e37dba','2011-12-08 05:45:06'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1MYTaiooQ5szcRxy6fFrsq4d9bhGxUCVVX',12703,'5644386327296b568e979cda7df32b32ae1d12ceb29a24bb5995f471d114c745','2012-01-04 02:37:47'),('receive','jian.xie@hotmail.com','0.10000000','0.00000000','155PNrq7SzFHNMwz9tBEbL5DAhWBFjdBtX',15930,'60f42b853c32e7e531c82e1626596bd4572ba86495011f81ab85681ca7594848','2011-12-13 04:45:56'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',16783,'b74cf95558d346cadbee8f88624ede9dc9a40cf843ab9cc1d3b9ea674f388ec4','2011-12-08 04:34:42'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1Et91MqiM42ecuHRVXvwJCiztpKSDeUFR3',16684,'cfa6fbaf0a3747edd2fb2915ce9141fa0a93e4d9fcd5877c2e090776732e9cf5','2011-12-08 04:35:35');
/*!40000 ALTER TABLE `btc_trans` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (27,'SP5k','S&P500','S','0.00010000','2012-03-27 00:00:00','1200.00000000','2012-05-01 13:00:00','1200.00000000','0.250',73,'BTCFE','0.001000','N','I','0.00016200','Spot Price:\r\nhttp://www.google.com/finance?q=INDEXSP:.INX','Nonefdasfsdf','more description');
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `exchange_lock`
--

LOCK TABLES `exchange_lock` WRITE;
/*!40000 ALTER TABLE `exchange_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_lock` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketinfo`
--

LOCK TABLES `marketinfo` WRITE;
/*!40000 ALTER TABLE `marketinfo` DISABLE KEYS */;
INSERT INTO `marketinfo` VALUES (19,27,'1000.00000000','1000.00000000','1000.00000000','1000.00000000','2012-03-30'),(20,27,'1000.00000000','1000.00000000','1000.00000000','1000.00000000','2012-03-31'),(21,27,'1000.00000000','1000.00000000','1000.00000000','1000.00000000','2012-04-01'),(22,27,'1000.00000000','1000.00000000','1000.00000000','1000.00000000','2012-04-02'),(23,27,'1200.00000000','1200.00000000','1200.00000000','1200.00000000','2012-05-01');
/*!40000 ALTER TABLE `marketinfo` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1 COMMENT='deal order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (40,73,27,'B','1000.00000000',2,0,'2012-03-30 16:52:21','O','F'),(41,72,27,'S','1000.00000000',1,0,'2012-03-30 16:52:34','O','F'),(42,72,27,'S','1000.00000000',2,0,'2012-03-31 16:53:20','O','F'),(43,73,27,'B','1000.00000000',2,0,'2012-04-01 16:54:43','O','F'),(44,72,27,'S','1000.00000000',2,1,'2012-04-02 17:00:16','O','C'),(45,72,27,'B','1200.00000000',4,0,'2012-05-01 17:03:55','C','F'),(46,73,27,'S','1200.00000000',4,0,'2012-05-01 17:03:55','C','F');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_status`
--

LOCK TABLES `sys_status` WRITE;
/*!40000 ALTER TABLE `sys_status` DISABLE KEYS */;
INSERT INTO `sys_status` VALUES (53,'LAST_EOD','2012-03-29'),(54,'LAST_EOD','2012-03-30'),(55,'LAST_EOD','2012-03-31'),(56,'LAST_EOD','2012-04-01'),(57,'LAST_EOD','2012-04-02'),(58,'LAST_EOD','2012-04-30');
/*!40000 ALTER TABLE `sys_status` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans`
--

LOCK TABLES `trans` WRITE;
/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
INSERT INTO `trans` VALUES (22,40,41,'1000.00000000',1,'S','2012-03-30 08:52:34'),(23,40,42,'1000.00000000',1,'S','2012-03-31 08:53:20'),(24,43,42,'1000.00000000',1,'B','2012-04-01 08:54:43'),(25,43,44,'1000.00000000',1,'S','2012-04-02 09:00:16'),(26,45,46,'1200.00000000',4,'S','2012-05-01 09:03:55');
/*!40000 ALTER TABLE `trans` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userattr`
--

LOCK TABLES `userattr` WRITE;
/*!40000 ALTER TABLE `userattr` DISABLE KEYS */;
INSERT INTO `userattr` VALUES (46,72,'C','0.10','2012-04','Invited Sign Up','2012-03-28 14:22:40'),(47,72,'C','0.10','2012-05','Invited Sign Up','2012-03-28 14:22:40'),(48,72,'C','0.10','2012-06','Invited Sign Up','2012-03-28 14:22:40'),(49,72,'C','0.10','2012-07','Invited Sign Up','2012-03-28 14:22:40'),(50,72,'C','0.10','2012-08','Invited Sign Up','2012-03-28 14:22:40'),(52,73,'C','0.10','2012-04','Invited Sign Up','2012-03-28 14:23:52'),(53,73,'C','0.10','2012-05','Invited Sign Up','2012-03-28 14:23:52'),(54,73,'C','0.10','2012-06','Invited Sign Up','2012-03-28 14:23:52'),(55,73,'C','0.10','2012-07','Invited Sign Up','2012-03-28 14:23:52'),(56,73,'C','0.10','2012-08','Invited Sign Up','2012-03-28 14:23:52');
/*!40000 ALTER TABLE `userattr` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userbalance`
--

LOCK TABLES `userbalance` WRITE;
/*!40000 ALTER TABLE `userbalance` DISABLE KEYS */;
INSERT INTO `userbalance` VALUES (92,72,'2011-10-31','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000'),(93,73,'2011-10-31','0.00000000','0.00000000','0.00000000','0.00000000','0.00000000'),(95,72,'2012-03-29','0.39950000','0.00000000','0.00000000','0.39950000','0.00000000'),(96,73,'2012-03-29','0.20000000','-0.30000000','0.00000000','0.50000000','0.00000000'),(98,72,'2012-03-30','0.79850000','-0.00050000','0.00000000','0.79900000','0.10000000'),(99,73,'2012-03-30','0.39950000','-0.60050000','0.00000000','1.00000000','0.10000000'),(101,72,'2012-03-31','0.39850000','-0.00100000','0.00000000','0.39950000','0.20000000'),(102,73,'2012-03-31','0.19918000','-0.30100000','0.00018000','0.50000000','0.20000000'),(104,72,'2012-04-01','0.39810000','-0.00140000','0.00000000','0.39950000','0.30000000'),(105,73,'2012-04-01','0.19896000','-0.30140000','0.00036000','0.50000000','0.30000000'),(107,72,'2012-04-02','0.39760000','-0.00190000','0.00000000','0.39950000','0.40000000'),(108,73,'2012-04-02','0.19862200','-0.30190000','0.00052200','0.50000000','0.40000000'),(110,72,'2012-04-30','0.39760000','-0.00190000','0.00000000','0.39950000','0.40000000'),(111,73,'2012-04-30','0.19862200','-0.30190000','0.00052200','0.50000000','0.40000000');
/*!40000 ALTER TABLE `userbalance` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlog`
--

LOCK TABLES `userlog` WRITE;
/*!40000 ALTER TABLE `userlog` DISABLE KEYS */;
INSERT INTO `userlog` VALUES (24,70,'Login','127.0.0.1',2,'2012-03-28 06:09:51'),(25,71,'Login','127.0.0.1',1,'2012-03-28 06:19:26'),(26,72,'Login','127.0.0.1',9,'2012-03-28 06:22:45'),(27,73,'Login','127.0.0.1',6,'2012-03-28 06:23:57');
/*!40000 ALTER TABLE `userlog` ENABLE KEYS */;
UNLOCK TABLES;

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
  `invite` smallint(6) DEFAULT '3',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (72,'jian.xie@163.com','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==',NULL,'N','0.004000',0,3),(73,'jian.xie@hotmail.com','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==',NULL,'N','0.004000',0,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

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
DECLARE cfee1m decimal(3,2) DEFAULT 0.1;
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
	IF pvol < 50 THEN
		RETURN 0.004;
    elseIF pvol < 100 THEN
		RETURN 0.003;
	ELSEIF pvol < 200 THEN
		RETURN 0.0025;
	ELSEIF pvol < 400 THEN
		RETURN 0.002;
	ELSEIF pvol < 1000 THEN
		RETURN 0.0015;
	ELSEIF pvol < 2000 THEN
		RETURN 0.001;
	ELSEIF pvol < 5000 THEN
		RETURN 0.0008;
	ELSEIF pvol < 10000 THEN
		RETURN 0.0007;
	ELSE
		RETURN 0.004;
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_addorder`(IN `pcontract` INTEGER, IN `puser` INTEGER, IN `pbs` CHAR(1), IN `ppoint` DECIMAL(20,8), IN `plots` INTEGER)
BEGIN
declare vplots int default 0;
DECLARE vmargin_req,vbtcavail DECIMAL(20,10) DEFAULT 0;
SELECT ifnull(sum(lots),0) into vplots FROM positions WHERE contract_id = pcontract AND user_id = puser AND buy_sell = f_N(pbs);
SELECT GREATEST(vplots-IFNULL(sum(rm_lots),0),0)INTO vplots FROM orders WHERE contract_id = pcontract AND user_id = puser AND buy_sell = pbs and type = 'C' and status = 'O';
if vplots >= plots then
	#new order is a cancel order
	INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)
		VALUES(puser,pcontract,pbs,ppoint,plots,plots,'C',NOW(),'N');
	CALL p_exchange(LAST_INSERT_ID(),puser,'A');
elseif vplots < plots and 0 <= plots then
	if vplots > 0 then
	#cancel those part
		INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)
			VALUES(puser,pcontract,pbs,ppoint,vplots,vplots,'C',NOW(),'N');
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
/*!50003 SET sql_mode              = '' */ ;
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
    where contract_id = pcontract AND status = 'O' AND buy_sell ='S' ORDER BY point ,createtime;
DECLARE curb CURSOR FOR SELECT order_id,point,rm_lots FROM orders 
    where contract_id = pcontract AND status = 'O' AND buy_sell ='B' ORDER BY point DESC ,createtime;
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
		SELECT 'suc','Order had been Added succesfully.';
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
		call addorder(curcid,puserid,f_N(curbs),vclosepoint,vclots);
		set prealseamt = 0 ;
	else
		call addorder(curcid,puserid,f_N(curbs),vclosepoint,curlt);
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
if vbtype = 'O' then
	INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vbuser_id,vcontract,'B',ppoint,v_lots,NOW());
elseif vbtype = 'C' then
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
if vstype = 'O' then
	INSERT INTO positions(user_id,contract_id,buy_sell,point,lots,opentime) VALUES (vsuser_id,vcontract,'S',ppoint,v_lots,NOW());
elseif vstype = 'C' then
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
		INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vbuser,vp_l,vplamount,vtrans_id,NOW(),'Q');
	end if;
end if;
CALL p_update_marketinfo(vcontract,ppoint);
          
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p_update_contract`(IN `cid` integer, IN `pcode` varchar(8), IN `pbtc_multi` decimal(10,8), IN `popendate` datetime, IN `psettledate` datetime, IN `pleverage` decimal(4,3), IN `pfullname` varchar(32), IN `puser` INTEGER, IN `ptwitter_id` varchar(16), IN `pwrite_fee` deCIMAL(6,6), IN `pregion` char(1), IN `psector` char(1), IN `pdescription` varchar(512))
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
			twitter_id=ptwitter_id,write_fee=pwrite_fee,region=pregion,sector=psector,description=pdescription WHERE contract_id = cid;
		if vfee_req <> 0 then
	      INSERT INTO btc_action(ACTION,account1,account2,address,amount,trans_id,input_dt,TYPE) 
			select 'move',email,vfee,'update',vfee_req,cid,NOW(),'H' from users where user_id = puser;
		end if;
    else
		INSERT INTO contract(code,btc_multi,opendate,settledate,leverage,fullname,owner,twitter_id,write_fee,region,sector,description) VALUES 
            (pcode,pbtc_multi,popendate,psettledate,pleverage,pfullname,puser,ptwitter_id,pwrite_fee,pregion,psector,pdescription);	
      	select last_insert_id() into cid;
      	if vfee_req <> 0 then
	      INSERT INTO btc_action(ACTION,account1,account2,address,amount,trans_id,input_dt,TYPE) 
            select 'move',email,vfee,'create',vfee_req,cid,NOW(),'H' from users where user_id = puser;
    	end if;
	end if;
	commit;
	select 'suc',concat('Contract ',cid,' Saved successfully.'),cid;
ELSE
	SELECT 'err',CONCAT('Contract Fee is Not Enough.', vbtcavail,' | ',vfee_req),cid;
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
/*!50001 VIEW `v_gl` AS select 'T' AS `sector`,`t`.`trans_id` AS `trans_id`,`t`.`contract_id` AS `contract_id`,`t`.`type` AS `type`,`t`.`user_id` AS `user_id`,`t`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,`t`.`value` AS `value`,`t`.`timestamp` AS `timestamp`,`t`.`fee` AS `fee`,`t`.`p_l` AS `p_l`,NULL AS `btc` from `v_trans` `t` union all select 'R' AS `R`,NULL AS `NULL`,`a`.`trans_id` AS `trans_id`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'R') and (`a`.`account1` = `u`.`email`)) union all select 'C' AS `C`,NULL AS `NULL`,`a`.`trans_id` AS `trans_id`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,NULL AS `NULL`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'C') and (`a`.`account1` = `u`.`email`)) union all select 'H' AS `H`,NULL AS `NULL`,`a`.`trans_id` AS `trans_id`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'H') and (`a`.`account1` = `u`.`email`)) union all select 'B' AS `B`,NULL AS `NULL`,NULL AS `NULL`,`b`.`type` AS `type`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`b`.`timestamp` AS `timestamp`,NULL AS `NULL`,NULL AS `NULL`,(`b`.`amount` + `b`.`fee`) AS `b.amount+b.fee` from (`btc_trans` `b` join `users` `u`) where (`b`.`user` = `u`.`email`) */;
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

-- Dump completed on 2012-05-01 17:05:31
