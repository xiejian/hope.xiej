-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: btcfe
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.10

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
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `btc_action`
--

LOCK TABLES `btc_action` WRITE;
/*!40000 ALTER TABLE `btc_action` DISABLE KEYS */;
INSERT INTO `btc_action` VALUES (162,'createuser','jian.xie@163.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:07:56','2012-01-04 08:18:36','0.44372840'),(163,'createuser','jian.xie@hotmail.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:16:48','2012-01-04 08:18:36','0.02543640'),(164,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001100','F','N',1,'2012-01-11 15:41:52',NULL,NULL),(165,'move','jian.xie@163.com','FEE',NULL,'0.00001100','G','N',1,'2012-01-11 15:41:52',NULL,NULL),(166,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',2,'2012-01-12 09:52:56',NULL,NULL),(167,'move','jian.xie@163.com','FEE',NULL,'0.00001000','G','N',2,'2012-01-12 09:52:56',NULL,NULL),(168,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',3,'2012-01-12 10:39:41',NULL,NULL),(169,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','G','N',3,'2012-01-12 10:39:41',NULL,NULL),(170,'move','jian.xie@hotmail.com','P_L',NULL,'0.01000000','Q','N',3,'2012-01-12 10:39:41',NULL,NULL),(171,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',4,'2012-01-12 10:40:36',NULL,NULL),(172,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','G','N',4,'2012-01-12 10:40:36',NULL,NULL),(173,'move','jian.xie@hotmail.com','P_L',NULL,'0.00000000','Q','N',4,'2012-01-12 10:40:36',NULL,NULL),(174,'move','jian.xie@163.com','FEE',NULL,'0.00001000','F','N',5,'2012-01-12 15:52:24',NULL,NULL),(175,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','G','N',5,'2012-01-12 15:52:24',NULL,NULL),(176,'move','jian.xie@163.com','P_L',NULL,'-0.01000000','P','N',5,'2012-01-12 15:52:24',NULL,NULL),(177,'move','jian.xie@hotmail.com','P_L',NULL,'0.00000000','Q','N',5,'2012-01-12 15:52:24',NULL,NULL),(178,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-13 14:42:02',NULL,NULL),(179,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:40:39',NULL,NULL),(180,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:43:09',NULL,NULL),(181,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:44:30',NULL,NULL),(182,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:46:43',NULL,NULL),(183,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 10:58:50',NULL,NULL),(184,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 10:59:48',NULL,NULL),(185,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:00:32',NULL,NULL),(186,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:02:13',NULL,NULL),(187,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:02:51',NULL,NULL),(188,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:05:33',NULL,NULL),(189,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:06:58',NULL,NULL);
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
INSERT INTO `btc_synclog` VALUES ('serv',NULL,'B','2012-01-03 08:18:35','192.168.168.122:8332'),('trans','00000000000001d1744b6c765ef9b92db0ea635232720af6b4c917349659c3a5','S','2012-01-03 08:18:36','5'),('serv',NULL,'E','2012-01-03 08:32:54','192.168.168.122:8332'),('serv',NULL,'B','2012-01-03 10:38:53','192.168.168.122:8332'),('serv',NULL,'B','2012-01-03 11:00:49','192.168.168.122:8332'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:00:49','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:01:19','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:01:50','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:02:20','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:02:50','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:03:20','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:03:51','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:04:21','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:04:51','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:05:21','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:05:52','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:06:22','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:06:52','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:07:23','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:07:53','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:08:23','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:08:53','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:09:24','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:09:54','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:10:24','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:10:54','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:11:25','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:11:55','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:12:25','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:12:55','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:13:26','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:13:56','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:14:26','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:14:56','1'),('trans','0000000000000a42c5562d3a68170327a3bb600942d60a7be34c8710a468f8fd','S','2012-01-03 11:15:26','1'),('trans','0000000000000476935e7bf4700560b7b5461f64c15c707ffb79c279fc75feb4','S','2012-01-03 11:15:56','1'),('serv',NULL,'B','2012-01-05 15:25:23','192.168.168.122:8332'),('serv',NULL,'E','2012-01-05 15:38:38','192.168.168.122:8332'),('serv',NULL,'B','2012-01-05 15:48:01','192.168.168.122:8332'),('serv',NULL,'E','2012-01-05 15:48:08','192.168.168.122:8332'),('serv',NULL,'B','2012-01-05 15:54:42','192.168.168.122:8332');
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
INSERT INTO `btc_trans` VALUES ('send','jian.xie@163.com','-0.10000000','-0.00050000','1JwXvhNAuvHEHaJbCzWKHaoM4XPXReeu9p',3918,'01943011c067e4195a2c0d891d4c5e1a671fc2e1a192c062eb5592bd16290118','2011-12-07 16:05:48'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',3929,'4c449c7d5e32a45e59f12d7933ecc01b1b9ba5f577b1ebd3427dfb95f6e37dba','2011-12-07 13:45:06'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1MYTaiooQ5szcRxy6fFrsq4d9bhGxUCVVX',2,'5644386327296b568e979cda7df32b32ae1d12ceb29a24bb5995f471d114c745','2012-01-03 10:37:47'),('receive','jian.xie@hotmail.com','0.10000000','0.00000000','155PNrq7SzFHNMwz9tBEbL5DAhWBFjdBtX',3205,'60f42b853c32e7e531c82e1626596bd4572ba86495011f81ab85681ca7594848','2011-12-12 12:45:56'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',4058,'b74cf95558d346cadbee8f88624ede9dc9a40cf843ab9cc1d3b9ea674f388ec4','2011-12-07 12:34:42'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1Et91MqiM42ecuHRVXvwJCiztpKSDeUFR3',3959,'cfa6fbaf0a3747edd2fb2915ce9141fa0a93e4d9fcd5877c2e090776732e9cf5','2011-12-07 12:35:35');
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
  `status` char(1) NOT NULL DEFAULT 'N',
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (4,'USD','O','1.00000000','2012-01-01',NULL,'2012-06-30',NULL,NULL,'0.2500','US Dollar Futures'),(5,'USD','O','1.00000000','2012-01-01',NULL,'2012-09-30',NULL,NULL,'0.2500','US Dollar Futures'),(6,'SP500','O','0.00100000','2012-01-01','100.00000000','2012-06-30',NULL,NULL,'0.2500','S&P 500 Index');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketinfo`
--

LOCK TABLES `marketinfo` WRITE;
/*!40000 ALTER TABLE `marketinfo` DISABLE KEYS */;
INSERT INTO `marketinfo` VALUES (1,6,'110.00000000','110.00000000','110.00000000','110.00000000','2012-01-11'),(2,6,'100.00000000','100.00000000','100.00000000','100.00000000','2012-01-12');
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
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=latin1 COMMENT='deal order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (140,28,6,'B','100.00000000',1,1,'2012-01-10 09:18:02','O','C'),(141,29,6,'S','110.00000000',1,1,'2012-01-11 11:00:07','O','C'),(142,29,6,'S','110.00000000',1,1,'2012-01-11 13:10:37','O','C'),(143,29,6,'S','110.00000000',1,1,'2012-01-11 13:18:46','O','C'),(144,29,6,'S','110.00000000',1,1,'2012-01-11 13:25:40','O','C'),(145,29,6,'S','110.00000000',1,1,'2012-01-11 13:40:03','O','C'),(146,29,6,'S','110.00000000',1,1,'2012-01-11 13:51:01','O','C'),(147,29,6,'B','110.00000000',1,1,'2012-01-11 15:17:22','O','C'),(148,29,6,'B','100.00000000',1,1,'2012-01-11 15:20:22','O','C'),(149,29,6,'B','110.00000000',1,1,'2012-01-11 15:21:28','O','C'),(150,29,6,'B','110.00000000',1,1,'2012-01-11 15:24:38','O','C'),(151,29,6,'B','110.00000000',1,1,'2012-01-11 15:25:46','O','C'),(152,29,6,'B','110.00000000',1,1,'2012-01-11 15:37:44','O','C'),(153,29,6,'B','110.00000000',1,1,'2012-01-11 15:41:05','O','C'),(154,29,6,'B','110.00000000',1,0,'2012-01-11 15:41:17','O','F'),(155,28,6,'S','100.00000000',1,0,'2012-01-11 15:41:52','O','F'),(156,29,6,'B','100.00000000',1,0,'2012-01-12 09:51:59','O','F'),(157,28,6,'S','110.00000000',1,1,'2012-01-12 09:52:22','O','O'),(158,28,6,'S','99.00000000',1,0,'2012-01-12 09:52:56','O','F'),(159,29,6,'B','100.00000000',4,2,'2012-01-12 09:54:59','O','C'),(160,29,6,'B','99.00000000',4,4,'2012-01-12 09:55:16','O','C'),(161,29,6,'B','98.00000000',4,4,'2012-01-12 09:55:29','O','C'),(162,29,6,'B','10.00000000',1,1,'2012-01-12 10:02:45','O','C'),(163,29,6,'B','10.00000000',1,1,'2012-01-12 10:03:27','O','C'),(164,29,6,'B','10.00000000',1,1,'2012-01-12 10:04:03','O','C'),(165,29,6,'B','10.00000000',1,1,'2012-01-12 10:30:57','O','C'),(166,29,6,'B','0.59510000',4,4,'2012-01-12 10:39:05','O','O'),(167,29,6,'S','100.00000000',1,0,'2012-01-12 10:39:41','C','F'),(168,29,6,'S','100.00000000',1,0,'2012-01-12 10:40:36','C','F'),(169,29,6,'B','100.00000000',4,4,'2012-01-12 11:04:26','O','C'),(170,29,6,'B','100.00000000',4,4,'2012-01-12 11:04:40','O','C'),(171,29,6,'B','100.00000000',4,4,'2012-01-12 11:05:46','O','C'),(172,28,6,'B','100.00000000',2,1,'2012-01-12 15:49:04','C','C'),(173,29,6,'S','100.00000000',1,0,'2012-01-12 15:52:24','C','F'),(174,28,6,'B','100.00000000',1,1,'2012-01-13 12:05:34','O','O'),(175,28,6,'B','98.00000000',1,1,'2012-01-13 12:05:43','O','C'),(176,28,6,'S','120.00000000',1,1,'2012-01-16 14:29:24','O','O');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (4,28,6,'S','100.00000000',1,'2012-01-12 09:52:56'),(6,29,6,'B','100.00000000',1,'2012-01-12 10:40:36');
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
  `point` decimal(20,8) NOT NULL,
  `lots` int(11) NOT NULL,
  `direct` char(1) DEFAULT 'B',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans`
--

LOCK TABLES `trans` WRITE;
/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
INSERT INTO `trans` VALUES (1,154,155,'110.00000000',1,'S','2012-01-10 23:41:52'),(2,156,158,'100.00000000',1,'S','2012-01-12 01:52:56'),(3,159,167,'100.00000000',1,'S','2012-01-12 02:39:41'),(4,159,168,'100.00000000',1,'S','2012-01-12 02:40:36'),(5,172,173,'100.00000000',1,'S','2012-01-12 07:52:24');
/*!40000 ALTER TABLE `trans` ENABLE KEYS */;
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
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userlog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlog`
--

LOCK TABLES `userlog` WRITE;
/*!40000 ALTER TABLE `userlog` DISABLE KEYS */;
INSERT INTO `userlog` VALUES (2,28,'Login','127.0.0.1','2012-01-16 06:19:02'),(3,29,'Login','127.0.0.1','2012-01-16 08:09:32'),(4,34,'Login','127.0.0.1','2012-01-16 08:25:11'),(5,28,'Login','127.0.0.1','2012-01-16 09:36:29'),(6,28,'Login','127.0.0.1','2012-01-17 02:10:51'),(7,28,'Login','127.0.0.1','2012-01-17 03:07:49'),(8,28,'Login','127.0.0.1','2012-01-17 05:21:32'),(9,28,'Login','127.0.0.1','2012-01-17 05:27:44'),(10,28,'Login','127.0.0.1','2012-01-17 05:29:24'),(11,28,'Login','127.0.0.1','2012-01-17 07:02:31'),(12,28,'Login','127.0.0.1','2012-01-17 08:09:19'),(13,29,'Login','127.0.0.1','2012-01-17 08:12:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (28,'jian.xie@163.com','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==','N','0.000100',0,0),(29,'jian.xie@hotmail.com','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==','N','0.000100',0,3);
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
  `cost` decimal(62,16),
  `marketvalue` decimal(62,16),
  `p_l` decimal(63,16),
  `margin` decimal(65,20)
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
-- Dumping routines for database 'btcfe'
--
/*!50003 DROP PROCEDURE IF EXISTS `addorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `addorder`(IN `pcontract` INTEGER,IN `puser` INTEGER,
		IN pbs CHAR(1),in ptype CHAR(1),IN `ppoint` DECIMAL(20,8),IN plots INTEGER)
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE vmargin_req,vmargin,vbtcavail,vlock,vp_l DECIMAL(20,10) DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
if ptype = 'C' then
	INSERT INTO orders(user_id,contract_id,buy_sell,point,lots,rm_lots,type,createtime,STATUS)
		VALUES(puser,pcontract,pbs,ppoint,plots,plots,ptype,NOW(),'N');
		CALL exchange(LAST_INSERT_ID(),puser,'A');
elseif ptype = 'O' then 
	SELECT IFNULL(SUM(margin),0) INTO vmargin FROM v_pos WHERE user_id = puser GROUP BY user_id;
	SELECT IFNULL(SUM(p_l),0) INTO vp_l FROM v_pos WHERE user_id = puser GROUP BY user_id;
	SELECT b.balance + IFNULL(a.amount,0) INTO vbtcavail FROM users u, btc_account b LEFT JOIN v_btcunact a 
		ON b.account = a.account where u.email = b.account and u.user_id = puser;
		
	SELECT IFNULL(SUM(o.point*o.lots*c.btc_multi*c.leverage),0) INTO vlock FROM orders o, contract c 
		WHERE o.contract_id = c.contract_id AND o.status = 'O' AND o.type = 'O' AND o.user_id = puser;
	SET done = FALSE;
	SELECT ppoint*plots*btc_multi*leverage INTO vmargin_req FROM contract WHERE contract_id = pcontract AND STATUS = 'O';
	IF NOT done AND vbtcavail + vp_l - vlock - vmargin >= vmargin_req THEN
		INSERT INTO orders(user_id,contract_id,buy_sell,point,lots,rm_lots,type,createtime,STATUS)
			VALUES(puser,pcontract,pbs,ppoint,plots,plots,ptype,NOW(),'N');
			CALL exchange(LAST_INSERT_ID(),puser,'A');
	ELSE
	SELECT 'err',CONCAT('Margin is Not Enough.', vbtcavail,vp_l,vlock,vmargin,vmargin_req);
	END IF;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `contractsettle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `contractsettle`(IN `pcontract` INTEGER,IN `pprice` DECIMAL(20,10))
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
/*!50003 DROP PROCEDURE IF EXISTS `eod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `eod`(IN `poid` INTEGER,IN `puserid` INTEGER,IN `paction` CHAR)
main:BEGIN
DECLARE done,dealflag INT DEFAULT FALSE;
DECLARE locktype CHAR(4);
DECLARE pcontract INT;
DECLARE vbuy_sell CHAR(1);
DECLARE vpoint,curpr DECIMAL(20,8);
DECLARE vuser,vrm_lots, curoid,curuser,curlt INT;
DECLARE curs CURSOR FOR SELECT order_id,POINT,rm_lots FROM orders 
    WHERE contract_id = pcontract AND STATUS = 'O' AND buy_sell ='S' ORDER BY POINT ,createtime;
DECLARE curb CURSOR FOR SELECT order_id,POINT,rm_lots FROM orders 
    WHERE contract_id = pcontract AND STATUS = 'O' AND buy_sell ='B' ORDER BY POINT DESC ,createtime;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;SELECT 'Err','SQLEXCEPTION';
  END;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SELECT user_id,contract_id,buy_sell,POINT,rm_lots INTO vuser,pcontract,vbuy_sell,vpoint,vrm_lots FROM orders WHERE order_id = poid AND STATUS IN('N','O');
IF done OR vuser <> puserid THEN
	SELECT 'Err','Have not found your Order.';
	LEAVE main;
END IF;
SELECT MAX(TYPE) INTO locktype FROM exchange_lock WHERE contract_id = pcontract;
IF locktype IS NOT NULL THEN
	SELECT 'Err',CONCAT('Exchange Server Locked by ',contractlock);
	LEAVE main;
END IF;
INSERT INTO exchange_lock(contract_id,connect_id) VALUES(pcontract,CONNECTION_ID());
COMMIT;
SELECT MAX(TYPE) INTO locktype FROM exchange_lock WHERE contract_id = pcontract AND connect_id <> CONNECTION_ID();
IF locktype IS NOT NULL THEN
	DELETE FROM exchange_lock WHERE contract_id = pcontract AND connect_id = CONNECTION_ID();
	COMMIT;
	SELECT 'Err',('Exchange Server Locked Failed by',locktype);
	LEAVE main ;
END IF;
START TRANSACTION;	
IF paction = 'C' THEN
	UPDATE orders SET STATUS = 'C' WHERE order_id = poid AND STATUS IN('N','O');
	SELECT 'suc','Cancel Order Successfully.';
ELSEIF paction = 'A' THEN
	IF vbuy_sell = 'B' THEN				
		SET done = FALSE;	
		OPEN curs;
		cur_loop:LOOP
			FETCH curs INTO curoid,curpr,curlt;					
			IF done OR curpr > vpoint THEN
				UPDATE orders SET STATUS = 'O',rm_lots = vrm_lots WHERE order_id = poid; 
				LEAVE cur_loop;	
			END IF;
			CALL makedeal(poid,curoid,curpr,LEAST(vrm_lots,curlt),'B');
			SET dealflag = TRUE;
			IF curlt <= vrm_lots THEN
				UPDATE orders SET STATUS = 'F',rm_lots = 0 WHERE order_id = curoid;            
			END IF;
			IF curlt < vrm_lots THEN
				SET vrm_lots = vrm_lots - curlt;					
			ELSEIF curlt >= vrm_lots THEN
				UPDATE orders SET STATUS = 'F',rm_lots = 0 WHERE order_id = poid;             
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
				UPDATE orders SET STATUS = 'O',rm_lots = vrm_lots WHERE order_id = poid; 
				LEAVE cur_loop;	
			END IF;
      		CALL makedeal(curoid,poid,curpr,LEAST(vrm_lots,curlt),'S');
			SET dealflag = TRUE;       		
       		IF curlt <= vrm_lots THEN
       			UPDATE orders SET STATUS = 'F',rm_lots = 0 WHERE order_id = curoid;            
			END IF;
			IF curlt < vrm_lots THEN
			    SET vrm_lots = vrm_lots - curlt;					
			ELSEIF curlt >= vrm_lots THEN
				UPDATE orders SET STATUS = 'F',rm_lots = 0 WHERE order_id = poid;             
				UPDATE orders SET rm_lots = curlt - vrm_lots WHERE order_id = curoid; 
				LEAVE cur_loop;           
			END IF; 
		END LOOP;
		CLOSE curb;
	END IF;
	IF dealflag THEN
		SELECT 'suc','Deal had been Maded.';
	ELSE
		SELECT 'suc','Order had been Added succesfully.';
	END IF;
END IF;
DELETE FROM exchange_lock WHERE contract_id = pcontract;
COMMIT;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `exchange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `exchange`(IN `poid` integer,IN `puserid` INTEGER,IN `paction` char)
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `makedeal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `makedeal`(IN pbuy_oid INTEGER,IN psell_oid INTEGER,IN ppoint DECIMAL(20,8),IN plots INTEGER,IN pdirect CHAR(1))
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
          
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_marketinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `update_marketinfo`(IN `pcontract` INTEGER,IN `point` DECIMAL(20,10))
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
/*!50001 VIEW `v_pos` AS select `p`.`user_id` AS `user_id`,`p`.`contract_id` AS `contract_id`,`c`.`name` AS `contract_name`,`p`.`buy_sell` AS `buy_sell`,sum(`p`.`lots`) AS `lots`,sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`)) AS `cost`,sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) AS `marketvalue`,(case when (`p`.`buy_sell` = 'B') then (sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`)) - sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`))) else (sum(((`p`.`lots` * `p`.`point`) * `c`.`btc_multi`)) - sum(((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`))) end) AS `p_l`,sum((((`p`.`lots` * `c`.`latestpoint`) * `c`.`btc_multi`) * `c`.`leverage`)) AS `margin` from (`positions` `p` join `contract` `c`) where (`p`.`contract_id` = `c`.`contract_id`) group by `p`.`user_id`,`p`.`contract_id`,`p`.`buy_sell`,`c`.`name` */;
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
/*!50001 VIEW `v_tradevol` AS select `v_trans`.`user_id` AS `user_id`,sum(`v_trans`.`value`) AS `tradevol` from `v_trans` where (`v_trans`.`timestamp` > (now() + interval -(30) day)) group by `v_trans`.`user_id` */;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-17 17:09:53
