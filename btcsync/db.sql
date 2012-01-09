-- MySQL dump 10.13  Distrib 5.1.59, for Win32 (ia32)
--
-- Host: localhost    Database: btcfe
-- ------------------------------------------------------
-- Server version	5.1.59-community

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `buy_sell` char(1) NOT NULL,
  `lots` int(11) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `btc_account` VALUES ('FEE','1DSxsg47KjqtZhC9tEvyiSCSViV2PCknKt','0.00127560','0.00000000'),('jian.xie@hotmail.com','17qLfgv2L7uu6VnX8KuzWYvTQaweYmXDgm','0.36511610','0.00000000'),('jian.xie@163.com','12NuhVyvntvBZdcaLPUojkMa455wNoF1kX','0.30300830','0.00000000'),('P_L','1NzDocGM8WbjwPkZ6oXanfHybubbC7ZZME','-0.06990000','0.00000000');
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
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `btc_action`
--

LOCK TABLES `btc_action` WRITE;
/*!40000 ALTER TABLE `btc_action` DISABLE KEYS */;
INSERT INTO `btc_action` VALUES (162,'createuser','jian.xie@163.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:07:56','2012-01-04 08:18:36','0.44372840'),(163,'createuser','jian.xie@hotmail.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:16:48','2012-01-04 08:18:36','0.02543640'),(164,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',1,'2012-01-08 12:24:27',NULL,NULL),(165,'move','jian.xie@163.com','FEE',NULL,'0.00001000','G','N',1,'2012-01-08 12:24:27',NULL,NULL);
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
INSERT INTO `btc_synclog` VALUES ('serv',NULL,'B','2012-01-04 00:18:35','192.168.168.122:8332'),('trans','00000000000001d1744b6c765ef9b92db0ea635232720af6b4c917349659c3a5','S','2012-01-04 00:18:36','5'),('serv',NULL,'E','2012-01-04 00:32:54','192.168.168.122:8332'),('serv',NULL,'B','2012-01-04 02:38:53','192.168.168.122:8332'),('serv',NULL,'B','2012-01-04 03:00:49','192.168.168.122:8332'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:00:49','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:01:19','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:01:50','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:02:20','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:02:50','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:03:20','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:03:51','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:04:21','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:04:51','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:05:21','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:05:52','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:06:22','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:06:52','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:07:23','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:07:53','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:08:23','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:08:53','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:09:24','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:09:54','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:10:24','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:10:54','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:11:25','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:11:55','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:12:25','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:12:55','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:13:26','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:13:56','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:14:26','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:14:56','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-04 03:15:26','1'),('trans','0000000000000476935e7bf4700560b7b5461f64c15c707ffb79c279fc75feb4','S','2012-01-04 03:15:56','1'),('serv',NULL,'B','2012-01-06 07:25:23','192.168.168.122:8332'),('serv',NULL,'E','2012-01-06 07:38:38','192.168.168.122:8332'),('serv',NULL,'B','2012-01-06 07:48:01','192.168.168.122:8332'),('serv',NULL,'E','2012-01-06 07:48:08','192.168.168.122:8332'),('serv',NULL,'B','2012-01-06 07:54:42','192.168.168.122:8332');
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
INSERT INTO `btc_trans` VALUES ('send','jian.xie@163.com','-0.10000000','-0.00050000','1JwXvhNAuvHEHaJbCzWKHaoM4XPXReeu9p',3918,'01943011c067e4195a2c0d891d4c5e1a671fc2e1a192c062eb5592bd16290118','2011-12-08 08:05:48'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',3929,'4c449c7d5e32a45e59f12d7933ecc01b1b9ba5f577b1ebd3427dfb95f6e37dba','2011-12-08 05:45:06'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1MYTaiooQ5szcRxy6fFrsq4d9bhGxUCVVX',2,'5644386327296b568e979cda7df32b32ae1d12ceb29a24bb5995f471d114c745','2012-01-04 02:37:47'),('receive','jian.xie@hotmail.com','0.10000000','0.00000000','155PNrq7SzFHNMwz9tBEbL5DAhWBFjdBtX',3205,'60f42b853c32e7e531c82e1626596bd4572ba86495011f81ab85681ca7594848','2011-12-13 04:45:56'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',4058,'b74cf95558d346cadbee8f88624ede9dc9a40cf843ab9cc1d3b9ea674f388ec4','2011-12-08 04:34:42'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1Et91MqiM42ecuHRVXvwJCiztpKSDeUFR3',3959,'cfa6fbaf0a3747edd2fb2915ce9141fa0a93e4d9fcd5877c2e090776732e9cf5','2011-12-08 04:35:35');
/*!40000 ALTER TABLE `btc_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(8) NOT NULL,
  `status` char(1) NOT NULL,
  `btc_multi` decimal(10,8) NOT NULL DEFAULT '1.00000000',
  `opendate` date NOT NULL,
  `latestpoint` decimal(20,10) DEFAULT NULL,
  `settledate` date DEFAULT NULL,
  `settlepoint` decimal(20,10) DEFAULT NULL,
  `settleproof` varchar(64) DEFAULT NULL,
  `leverage` decimal(4,4) NOT NULL DEFAULT '0.2500',
  `discription` varchar(64) NOT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (4,'USD','O','1.00000000','2012-01-01',NULL,'2012-06-30',NULL,NULL,'0.2500','US Dollar Futures'),(5,'USD','O','1.00000000','2012-01-01',NULL,'2012-09-30',NULL,NULL,'0.2500','US Dollar Futures'),(6,'SP500','O','0.00100000','2012-01-01','100.0000000000','2012-06-30',NULL,NULL,'0.2500','S&P 500 Index');
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
  `connect_id` int(16) DEFAULT NULL,
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
  `open` decimal(20,10) DEFAULT NULL,
  `high` decimal(20,10) DEFAULT NULL,
  `low` decimal(20,10) DEFAULT NULL,
  `close` decimal(20,10) DEFAULT NULL,
  `tradedate` date NOT NULL,
  PRIMARY KEY (`marketinfo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketinfo`
--

LOCK TABLES `marketinfo` WRITE;
/*!40000 ALTER TABLE `marketinfo` DISABLE KEYS */;
INSERT INTO `marketinfo` VALUES (7,5,'0.0001000000','0.1100000000','0.0001000000','0.1100000000','2012-01-04'),(8,5,'0.1100000000','0.4000000000','0.0100000000','0.1500000000','2012-01-06'),(9,4,'0.1500000000','0.1500000000','0.1500000000','0.1500000000','2012-01-06'),(10,4,'0.1000000000','0.1000000000','0.1000000000','0.1000000000','2012-01-07'),(11,6,'0.1000000000','0.1000000000','0.1000000000','0.1000000000','2012-01-08');
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
  `price` decimal(20,10) NOT NULL,
  `lots` int(11) NOT NULL,
  `rm_lots` int(11) NOT NULL,
  `createtime` datetime NOT NULL,
  `type` char(1) NOT NULL DEFAULT 'O',
  `status` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=latin1 COMMENT='deal order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (137,29,6,'B','1.0000000000',1,1,'2012-01-08 09:23:27','O','C'),(138,29,6,'B','0.1000000000',1,0,'2012-01-08 11:17:16','O','F'),(139,28,6,'S','0.0990000000',2,1,'2012-01-08 12:24:27','O','O');
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
  `price` decimal(20,10) NOT NULL,
  `lots` int(11) NOT NULL,
  `opentime` datetime NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (1,29,6,'B','0.1000000000',1,'2012-01-08 12:24:27'),(2,28,6,'S','0.1000000000',1,'2012-01-08 12:24:27');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
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
  `price` decimal(20,10) NOT NULL,
  `lots` int(11) NOT NULL,
  `direct` char(1) DEFAULT 'B',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans`
--

LOCK TABLES `trans` WRITE;
/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
INSERT INTO `trans` VALUES (1,138,139,'0.1000000000',1,'S','2012-01-08 04:24:27');
/*!40000 ALTER TABLE `trans` ENABLE KEYS */;
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
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (28,'jian.xie@163.com','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==',NULL,'N','0.000100'),(29,'jian.xie@hotmail.com','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==',NULL,'N','0.000100');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_account`
--

DROP TABLE IF EXISTS `v_account`;
/*!50001 DROP VIEW IF EXISTS `v_account`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_account` (
  `account` varchar(32),
  `address` char(34),
  `balance` decimal(20,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_btcbal`
--

DROP TABLE IF EXISTS `v_btcbal`;
/*!50001 DROP VIEW IF EXISTS `v_btcbal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_btcbal` (
  `user_id` int(11),
  `account` varchar(40),
  `balance` decimal(42,8),
  `bal_unconf` decimal(42,8),
  `bal_unact` decimal(43,8),
  `bal_avail` decimal(44,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_btcbal_p`
--

DROP TABLE IF EXISTS `v_btcbal_p`;
/*!50001 DROP VIEW IF EXISTS `v_btcbal_p`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_btcbal_p` (
  `account` varchar(40),
  `balance` decimal(20,8),
  `bal_unconf` decimal(20,8),
  `bal_unact` decimal(21,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

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
-- Temporary table structure for view `v_pos`
--

DROP TABLE IF EXISTS `v_pos`;
/*!50001 DROP VIEW IF EXISTS `v_pos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_pos` (
  `user_id` int(11),
  `contract_id` int(11),
  `contract_name` varchar(8),
  `buy_sell` char(1),
  `lots` decimal(32,0),
  `cost` decimal(52,10),
  `marketvalue` decimal(62,18),
  `margin` decimal(65,26)
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
  `price` decimal(20,10),
  `lots` int(11),
  `timestamp` timestamp,
  `fee` decimal(21,8),
  `p_l` decimal(21,8)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_account`
--

/*!50001 DROP TABLE IF EXISTS `v_account`*/;
/*!50001 DROP VIEW IF EXISTS `v_account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_account` AS select `btc_account`.`account` AS `account`,`btc_account`.`address` AS `address`,`btc_account`.`balance` AS `balance` from `btc_account` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_btcbal`
--

/*!50001 DROP TABLE IF EXISTS `v_btcbal`*/;
/*!50001 DROP VIEW IF EXISTS `v_btcbal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_btcbal` AS select `u`.`user_id` AS `user_id`,`t`.`account` AS `account`,sum(`t`.`balance`) AS `balance`,sum(`t`.`bal_unconf`) AS `bal_unconf`,sum(`t`.`bal_unact`) AS `bal_unact`,((sum(`t`.`balance`) + least(sum(`t`.`bal_unconf`),0)) + least(sum(`t`.`bal_unact`),0)) AS `bal_avail` from (`v_btcbal_p` `t` join `users` `u`) where (convert(`t`.`account` using utf8) = convert(`u`.`email` using utf8)) group by `u`.`user_id`,`t`.`account` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_btcbal_p`
--

/*!50001 DROP TABLE IF EXISTS `v_btcbal_p`*/;
/*!50001 DROP VIEW IF EXISTS `v_btcbal_p`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_btcbal_p` AS select `ac`.`account` AS `account`,`ac`.`balance` AS `balance`,`ac`.`bal_unconf` AS `bal_unconf`,0 AS `bal_unact` from `btc_account` `ac` union all select `a`.`account1` AS `account1`,0 AS `0`,0 AS `0`,(-(1) * `a`.`amount`) AS `-1*a.amount` from `btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` in ('move','sendfrom'))) union all select `a`.`account2` AS `account2`,0 AS `0`,0 AS `0`,`a`.`amount` AS `amount` from `btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` = 'move')) union all select `a`.`account1` AS `account`,0 AS `0`,0 AS `0`,0 AS `0` from `btc_action` `a` where ((`a`.`status` = 'N') and (`a`.`action` = 'createuser')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

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
/*!50001 VIEW `v_pos` AS select `p`.`user_id` AS `user_id`,`p`.`contract_id` AS `contract_id`,`c`.`name` AS `contract_name`,`p`.`buy_sell` AS `buy_sell`,sum(`p`.`lots`) AS `lots`,sum((`p`.`lots` * `p`.`price`)) AS `cost`,sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) AS `marketvalue`,sum(((((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`) * `c`.`leverage`) / 100)) AS `margin` from (`positions` `p` join `contract` `c`) where (`p`.`contract_id` = `c`.`contract_id`) group by `p`.`user_id`,`p`.`contract_id`,`p`.`buy_sell`,`c`.`name` */;
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
/*!50001 VIEW `v_trans` AS select `t`.`trans_id` AS `trans_id`,`o`.`contract_id` AS `contract_id`,`o`.`type` AS `type`,`o`.`user_id` AS `user_id`,`o`.`buy_sell` AS `buy_sell`,`t`.`price` AS `price`,`t`.`lots` AS `lots`,`t`.`timestamp` AS `timestamp`,-(`a`.`amount`) AS `fee`,-(`b`.`amount`) AS `p_l` from (`orders` `o` join ((`trans` `t` left join `btc_action` `a` on(((`t`.`trans_id` = `a`.`trans_id`) and (`a`.`type` = 'F')))) left join `btc_action` `b` on(((`t`.`trans_id` = `b`.`trans_id`) and (`b`.`type` = 'P'))))) where (`t`.`buy_oid` = `o`.`order_id`) union all select `t`.`trans_id` AS `trans_id`,`o`.`contract_id` AS `contract_id`,`o`.`type` AS `type`,`o`.`user_id` AS `user_id`,`o`.`buy_sell` AS `buy_sell`,`t`.`price` AS `price`,`t`.`lots` AS `lots`,`t`.`timestamp` AS `timestamp`,-(`a`.`amount`) AS `fee`,-(`b`.`amount`) AS `p_l` from (`orders` `o` join ((`trans` `t` left join `btc_action` `a` on(((`t`.`trans_id` = `a`.`trans_id`) and (`a`.`type` = 'G')))) left join `btc_action` `b` on(((`t`.`trans_id` = `b`.`trans_id`) and (`b`.`type` = 'Q'))))) where (`t`.`sell_oid` = `o`.`order_id`) */;
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

-- Dump completed on 2012-01-09 21:08:13
