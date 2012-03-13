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
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `btc_action`
--

LOCK TABLES `btc_action` WRITE;
/*!40000 ALTER TABLE `btc_action` DISABLE KEYS */;
INSERT INTO `btc_action` VALUES (162,'createuser','jian.xie@163.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:07:56','2012-01-04 08:18:36','0.44372840'),(163,'createuser','jian.xie@hotmail.com',NULL,NULL,'0.00000000',NULL,'S',NULL,'2012-01-04 08:16:48','2012-01-04 08:18:36','0.02543640'),(164,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001100','F','N',1,'2012-01-11 15:41:52',NULL,NULL),(165,'move','jian.xie@163.com','FEE',NULL,'0.00001100','G','N',1,'2012-01-11 15:41:52',NULL,NULL),(166,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',2,'2012-01-12 09:52:56',NULL,NULL),(167,'move','jian.xie@163.com','FEE',NULL,'0.00001000','G','N',2,'2012-01-12 09:52:56',NULL,NULL),(168,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',3,'2012-01-12 10:39:41',NULL,NULL),(169,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','G','N',3,'2012-01-12 10:39:41',NULL,NULL),(170,'move','jian.xie@hotmail.com','P_L',NULL,'0.01000000','Q','N',3,'2012-01-12 10:39:41',NULL,NULL),(171,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','F','N',4,'2012-01-12 10:40:36',NULL,NULL),(172,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','G','N',4,'2012-01-12 10:40:36',NULL,NULL),(173,'move','jian.xie@hotmail.com','P_L',NULL,'0.00000000','Q','N',4,'2012-01-12 10:40:36',NULL,NULL),(174,'move','jian.xie@163.com','FEE',NULL,'0.00001000','F','N',5,'2012-01-12 15:52:24',NULL,NULL),(175,'move','jian.xie@hotmail.com','FEE',NULL,'0.00001000','G','N',5,'2012-01-12 15:52:24',NULL,NULL),(176,'move','jian.xie@163.com','P_L',NULL,'-0.01000000','P','N',5,'2012-01-12 15:52:24',NULL,NULL),(177,'move','jian.xie@hotmail.com','P_L',NULL,'0.00000000','Q','N',5,'2012-01-12 15:52:24',NULL,NULL),(178,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-13 14:42:02',NULL,NULL),(179,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:40:39',NULL,NULL),(180,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:43:09',NULL,NULL),(181,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:44:30',NULL,NULL),(182,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-16 13:46:43',NULL,NULL),(183,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 10:58:50',NULL,NULL),(184,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 10:59:48',NULL,NULL),(185,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:00:32',NULL,NULL),(186,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:02:13',NULL,NULL),(187,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:02:51',NULL,NULL),(188,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:05:33',NULL,NULL),(189,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-01-17 11:06:58',NULL,NULL),(190,'move','jian.xie@163.com','FEE',NULL,'0.00001000','F','N',6,'2012-02-03 09:00:51',NULL,NULL),(191,'move','jian.xie@163.com','FEE',NULL,'0.00001000','G','N',6,'2012-02-03 09:00:51',NULL,NULL),(192,'move','jian.xie@163.com','FEE',NULL,'0.00000540','F','N',7,'2012-02-03 10:08:39',NULL,NULL),(193,'move','jian.xie@163.com','FEE',NULL,'0.00000540','G','N',7,'2012-02-03 10:08:39',NULL,NULL),(194,'move','jian.xie@163.com','P_L',NULL,'-0.04600000','P','N',7,'2012-02-03 10:08:39',NULL,NULL),(195,'move','jian.xie@163.com','P_L',NULL,'0.04600000','Q','N',7,'2012-02-03 10:08:39',NULL,NULL),(196,'move','jian.xie@163.com','FEE',NULL,'0.00001000','F','N',8,'2012-02-03 10:12:34',NULL,NULL),(197,'move','jian.xie@163.com','FEE',NULL,'0.00001000','G','N',8,'2012-02-03 10:12:34',NULL,NULL),(198,'move','jian.xie@163.com','FEE',NULL,'0.00001100','F','N',9,'2012-02-03 10:12:34',NULL,NULL),(199,'move','jian.xie@163.com','FEE',NULL,'0.00001100','G','N',9,'2012-02-03 10:12:34',NULL,NULL),(200,'move','jian.xie@163.com','FEE',NULL,'0.00001200','F','N',10,'2012-02-03 10:12:34',NULL,NULL),(201,'move','jian.xie@163.com','FEE',NULL,'0.00001200','G','N',10,'2012-02-03 10:12:34',NULL,NULL),(202,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-06 16:36:09',NULL,NULL),(203,'move','jian.xie@163.com','FEE',NULL,'0.00002700','F','N',11,'2012-02-07 13:07:28',NULL,NULL),(204,'move','jian.xie@163.com','FEE',NULL,'0.00002700','G','N',11,'2012-02-07 13:07:28',NULL,NULL),(205,'move','jian.xie@163.com','P_L',NULL,'-0.01000000','P','N',11,'2012-02-07 13:07:28',NULL,NULL),(206,'move','jian.xie@163.com','P_L',NULL,'-0.01000000','P','N',11,'2012-02-07 13:07:28',NULL,NULL),(207,'move','jian.xie@163.com','P_L',NULL,'-0.02000000','P','N',11,'2012-02-07 13:07:28',NULL,NULL),(208,'move','jian.xie@163.com','P_L',NULL,'0.01000000','Q','N',11,'2012-02-07 13:07:28',NULL,NULL),(209,'move','jian.xie@163.com','FEE',NULL,'0.00000900','F','N',12,'2012-02-07 13:07:28',NULL,NULL),(210,'move','jian.xie@163.com','FEE',NULL,'0.00000900','G','N',12,'2012-02-07 13:07:28',NULL,NULL),(211,'move','jian.xie@163.com','P_L',NULL,'-0.03000000','P','N',12,'2012-02-07 13:07:28',NULL,NULL),(212,'move','jian.xie@163.com','FEE',NULL,'0.00000900','F','N',13,'2012-02-07 13:11:21',NULL,NULL),(213,'move','jian.xie@hotmail.com','FEE',NULL,'0.00000900','G','N',13,'2012-02-07 13:11:21',NULL,NULL),(214,'move','jian.xie@163.com','P_L',NULL,'0.00000000','P','N',13,'2012-02-07 13:11:21',NULL,NULL),(215,'move','jian.xie@hotmail.com','P_L',NULL,'0.01000000','Q','N',13,'2012-02-07 13:11:21',NULL,NULL),(216,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 14:16:22',NULL,NULL),(217,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 14:18:00',NULL,NULL),(218,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 14:38:11',NULL,NULL),(219,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 14:42:05',NULL,NULL),(220,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 14:49:15',NULL,NULL),(221,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 15:13:34',NULL,NULL),(222,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 15:17:30',NULL,NULL),(223,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-13 15:27:08',NULL,NULL),(224,'createuser','jian.xie@2263.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-14 11:04:33',NULL,NULL),(225,'move','jian.xie@163.com','FEE',NULL,'0.00001000','F','N',14,'2012-02-14 15:18:25',NULL,NULL),(226,'move','jian.xie@163.com','FEE',NULL,'0.00001000','G','N',14,'2012-02-14 15:18:25',NULL,NULL),(227,'move','jian.xie@163.com','P_L',NULL,'0.01000000','Q','N',14,'2012-02-14 15:18:25',NULL,NULL),(228,'move','jian.xie@163.com','FEE',NULL,'0.00008000','F','N',15,'2012-02-14 15:20:36',NULL,NULL),(229,'move','jian.xie@hotmail.com','FEE',NULL,'0.00008000','G','N',15,'2012-02-14 15:20:36',NULL,NULL),(230,'move','jian.xie@163.com','FEE',NULL,'0.00000990','F','N',16,'2012-02-14 15:21:05',NULL,NULL),(231,'move','jian.xie@hotmail.com','FEE',NULL,'0.00000990','G','N',16,'2012-02-14 15:21:05',NULL,NULL),(232,'move','jian.xie@hotmail.com','FEE',NULL,'0.00000990','F','N',17,'2012-02-14 15:29:30',NULL,NULL),(233,'move','jian.xie@163.com','FEE',NULL,'0.00000990','G','N',17,'2012-02-14 15:29:30',NULL,NULL),(234,'move','jian.xie@hotmail.com','P_L',NULL,'-0.30100000','P','N',17,'2012-02-14 15:29:30',NULL,NULL),(235,'move','jian.xie@163.com','P_L',NULL,'0.02100000','Q','N',17,'2012-02-14 15:29:30',NULL,NULL),(244,'sendfrom','jian.xie@hotmail.com',NULL,'17qLfgv2L7uu6VnX8KuzWYvTQaweYmXDgm','0.10000000','W','N',NULL,'2012-02-16 15:40:13',NULL,NULL),(316,'move','jian.xie@163.com','FEE','201201 10%','-0.00000310','R','N',NULL,'2012-02-21 09:27:01',NULL,NULL),(317,'move','jian.xie@hotmail.com','FEE','201201 10%','-0.00000710','R','N',NULL,'2012-02-21 09:27:01',NULL,NULL),(318,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-21 14:21:53',NULL,NULL),(319,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 10:41:37',NULL,NULL),(320,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:17:38',NULL,NULL),(321,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:19:08',NULL,NULL),(322,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:37:35',NULL,NULL),(323,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:38:12',NULL,NULL),(324,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:38:45',NULL,NULL),(325,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:49:16',NULL,NULL),(326,'createuser','xiejian@mail.rmd-safe.gov.cn',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 13:53:42',NULL,NULL),(327,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 14:01:34',NULL,NULL),(328,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 14:15:34',NULL,NULL),(329,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 14:16:45',NULL,NULL),(330,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:22:40',NULL,NULL),(331,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:25:06',NULL,NULL),(332,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:25:54',NULL,NULL),(333,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:27:10',NULL,NULL),(334,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:27:40',NULL,NULL),(335,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:28:33',NULL,NULL),(336,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:36:37',NULL,NULL),(337,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:38:12',NULL,NULL),(338,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-02-29 16:57:45',NULL,NULL),(339,'createuser','xiejian.cn@gmail.com',NULL,NULL,'0.00000000',NULL,'N',NULL,'2012-03-01 08:04:24',NULL,NULL),(340,'move','jian.xie@163.com','FEE','201202 10%','-0.00002945','R','N',NULL,'2012-03-01 09:14:44',NULL,NULL),(341,'move','jian.xie@hotmail.com','FEE','201202 10%','-0.00001017','R','N',NULL,'2012-03-01 09:14:44',NULL,NULL),(344,'move','jian.xie@hotmail.com','FEE',NULL,'0.20000000','H','N',14,'2012-03-13 17:15:42',NULL,NULL);
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
INSERT INTO `btc_trans` VALUES ('send','jian.xie@163.com','-0.10000000','-0.00050000','1JwXvhNAuvHEHaJbCzWKHaoM4XPXReeu9p',3918,'01943011c067e4195a2c0d891d4c5e1a671fc2e1a192c062eb5592bd16290118','2012-01-01 16:05:48'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',3929,'4c449c7d5e32a45e59f12d7933ecc01b1b9ba5f577b1ebd3427dfb95f6e37dba','2012-01-01 13:45:06'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1MYTaiooQ5szcRxy6fFrsq4d9bhGxUCVVX',2,'5644386327296b568e979cda7df32b32ae1d12ceb29a24bb5995f471d114c745','2012-01-28 10:37:47'),('receive','jian.xie@hotmail.com','0.10000000','0.00000000','155PNrq7SzFHNMwz9tBEbL5DAhWBFjdBtX',3205,'60f42b853c32e7e531c82e1626596bd4572ba86495011f81ab85681ca7594848','2012-01-06 12:45:56'),('receive','jian.xie@163.com','0.10000000','0.00000000','1Db2p6PZKuin3sweKrUh6y2EuVcpggbJJS',4058,'b74cf95558d346cadbee8f88624ede9dc9a40cf843ab9cc1d3b9ea674f388ec4','2012-01-01 12:34:42'),('receive','jian.xie@hotmail.com','0.20000000','0.00000000','1Et91MqiM42ecuHRVXvwJCiztpKSDeUFR3',3959,'cfa6fbaf0a3747edd2fb2915ce9141fa0a93e4d9fcd5877c2e090776732e9cf5','2012-01-01 12:35:35');
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
  `region` char(1) DEFAULT NULL,
  `sector` char(1) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `settleproof` varchar(512) DEFAULT NULL,
  `apinstruction` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (4,'USD','US Dollar','O','1.00000000','2012-01-01 00:00:00',NULL,'2012-06-30 00:00:00',NULL,'0.250',30,NULL,'N','C',NULL,NULL,NULL),(5,'USD','US Dollar','O','1.00000000','2012-01-01 00:00:00',NULL,'2012-09-30 00:00:00',NULL,'0.250',30,NULL,'N','C',NULL,NULL,NULL),(6,'SP500','S&P 500','O','0.00100000','2012-01-01 00:00:00','99.00000000','2012-06-30 00:00:00',NULL,'0.250',28,NULL,'N','C',NULL,NULL,NULL),(7,'USD','US Dollar','C','0.00000100','2012-03-11 00:00:00',NULL,'2012-03-12 00:00:00','2003.00000000','0.100',28,'BTCFE','N','I','US Dollar','fasdfasdfasdf','proof'),(8,'USD','fdasfd','R','0.00000100','2012-03-14 00:00:00',NULL,'2012-04-12 00:00:00',NULL,'1.000',28,'dfasdf','O','S','fasdfsdfad',NULL,NULL),(9,'USD','US Dollar','N','0.10000000','2012-03-14 00:00:00',NULL,'2012-04-12 00:00:00',NULL,'0.100',28,'fasdfa','M','M','fdasfdasfasdfasdf\r\ndfasdf\r\nhello\r\n',NULL,'Full name'),(10,'USD','fdsafsd','N','0.00000100','2012-03-15 00:00:00',NULL,'2012-05-18 00:00:00',NULL,'1.000',28,'fasdf','W','C','',NULL,NULL),(13,'fsdafa','sadfasdf','N','0.00000100','2012-03-15 00:00:00',NULL,'2012-04-13 00:00:00',NULL,'1.000',29,'fasdfasdf','W','C','sadfasd',NULL,NULL),(14,'gafasd','asdfasdf','N','0.00000100','2012-03-15 00:00:00',NULL,'2012-04-13 00:00:00',NULL,'1.000',29,'fasdfasd','W','C','asdfasd',NULL,NULL);
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conts`
--

DROP TABLE IF EXISTS `conts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conts` (
  `conts_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(8) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `btc_multi` decimal(10,8) DEFAULT NULL,
  `leverage` decimal(4,4) DEFAULT NULL,
  `twitter_id` varchar(12) DEFAULT NULL,
  `cycle` char(1) DEFAULT 'N',
  PRIMARY KEY (`conts_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conts`
--

LOCK TABLES `conts` WRITE;
/*!40000 ALTER TABLE `conts` DISABLE KEYS */;
INSERT INTO `conts` VALUES (1,'USD','US Dollar',NULL,NULL,'1','Q'),(2,'SP500','S&P500 Stock Index',NULL,NULL,'2','Q');
/*!40000 ALTER TABLE `conts` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketinfo`
--

LOCK TABLES `marketinfo` WRITE;
/*!40000 ALTER TABLE `marketinfo` DISABLE KEYS */;
INSERT INTO `marketinfo` VALUES (1,6,'110.00000000','110.00000000','110.00000000','110.00000000','2012-01-11'),(2,6,'100.00000000','100.00000000','100.00000000','100.00000000','2012-01-12'),(3,6,'100.00000000','120.00000000','54.00000000','120.00000000','2012-02-03'),(4,6,'90.00000000','90.00000000','90.00000000','90.00000000','2012-02-07'),(5,6,'100.00000000','400.00000000','99.00000000','99.00000000','2012-02-14');
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
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=latin1 COMMENT='deal order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (140,28,6,'B','100.00000000',1,1,'2012-01-10 09:18:02','O','C'),(141,29,6,'S','110.00000000',1,1,'2012-01-11 11:00:07','O','C'),(142,29,6,'S','110.00000000',1,1,'2012-01-11 13:10:37','O','C'),(143,29,6,'S','110.00000000',1,1,'2012-01-11 13:18:46','O','C'),(144,29,6,'S','110.00000000',1,1,'2012-01-11 13:25:40','O','C'),(145,29,6,'S','110.00000000',1,1,'2012-01-11 13:40:03','O','C'),(146,29,6,'S','110.00000000',1,1,'2012-01-11 13:51:01','O','C'),(147,29,6,'B','110.00000000',1,1,'2012-01-11 15:17:22','O','C'),(148,29,6,'B','100.00000000',1,1,'2012-01-11 15:20:22','O','C'),(149,29,6,'B','110.00000000',1,1,'2012-01-11 15:21:28','O','C'),(150,29,6,'B','110.00000000',1,1,'2012-01-11 15:24:38','O','C'),(151,29,6,'B','110.00000000',1,1,'2012-01-11 15:25:46','O','C'),(152,29,6,'B','110.00000000',1,1,'2012-01-11 15:37:44','O','C'),(153,29,6,'B','110.00000000',1,1,'2012-01-11 15:41:05','O','C'),(154,29,6,'B','110.00000000',1,0,'2012-01-11 15:41:17','O','F'),(155,28,6,'S','100.00000000',1,0,'2012-01-11 15:41:52','O','F'),(156,29,6,'B','100.00000000',1,0,'2012-01-12 09:51:59','O','F'),(157,28,6,'S','110.00000000',1,0,'2012-01-12 09:52:22','O','F'),(158,28,6,'S','99.00000000',1,0,'2012-01-12 09:52:56','O','F'),(159,29,6,'B','100.00000000',4,2,'2012-01-12 09:54:59','O','C'),(160,29,6,'B','99.00000000',4,4,'2012-01-12 09:55:16','O','C'),(161,29,6,'B','98.00000000',4,4,'2012-01-12 09:55:29','O','C'),(162,29,6,'B','10.00000000',1,1,'2012-01-12 10:02:45','O','C'),(163,29,6,'B','10.00000000',1,1,'2012-01-12 10:03:27','O','C'),(164,29,6,'B','10.00000000',1,1,'2012-01-12 10:04:03','O','C'),(165,29,6,'B','10.00000000',1,1,'2012-01-12 10:30:57','O','C'),(166,29,6,'B','0.59510000',4,4,'2012-01-12 10:39:05','O','C'),(167,29,6,'S','100.00000000',1,0,'2012-01-12 10:39:41','C','F'),(168,29,6,'S','100.00000000',1,0,'2012-01-12 10:40:36','C','F'),(169,29,6,'B','100.00000000',4,4,'2012-01-12 11:04:26','O','C'),(170,29,6,'B','100.00000000',4,4,'2012-01-12 11:04:40','O','C'),(171,29,6,'B','100.00000000',4,4,'2012-01-12 11:05:46','O','C'),(172,28,6,'B','100.00000000',2,1,'2012-01-12 15:49:04','C','C'),(173,29,6,'S','100.00000000',1,0,'2012-01-12 15:52:24','C','F'),(174,28,6,'B','100.00000000',1,0,'2012-01-13 12:05:34','O','F'),(175,28,6,'B','98.00000000',1,1,'2012-01-13 12:05:43','O','C'),(176,28,6,'S','120.00000000',1,0,'2012-01-16 14:29:24','O','F'),(177,28,6,'S','100.00000000',2,0,'2012-02-03 09:00:51','O','F'),(178,28,6,'B','50.00000000',1,1,'2012-02-03 09:52:34','C','C'),(179,28,6,'B','51.00000000',1,1,'2012-02-03 09:54:44','C','C'),(180,28,6,'B','52.00000000',1,1,'2012-02-03 09:54:58','C','C'),(181,28,6,'B','53.00000000',1,1,'2012-02-03 09:55:43','C','C'),(182,28,6,'B','54.00000000',1,1,'2012-02-03 09:57:00','C','C'),(183,28,6,'B','50.00000000',1,1,'2012-02-03 09:57:21','C','C'),(184,28,6,'B','52.00000000',1,1,'2012-02-03 09:57:29','C','C'),(185,28,6,'B','53.00000000',1,1,'2012-02-03 09:57:34','C','C'),(186,28,6,'B','54.00000000',1,1,'2012-02-03 09:57:40','C','C'),(187,28,6,'B','55.00000000',1,1,'2012-02-03 09:59:20','C','C'),(188,28,6,'B','56.00000000',1,1,'2012-02-03 09:59:58','C','C'),(189,28,6,'B','57.00000000',1,1,'2012-02-03 10:00:37','C','C'),(190,28,6,'B','58.00000000',0,0,'2012-02-03 10:04:13','C','C'),(191,28,6,'B','58.00000000',1,1,'2012-02-03 10:04:13','O','C'),(192,28,6,'B','51.00000000',1,1,'2012-02-03 10:04:39','C','C'),(193,28,6,'B','52.00000000',1,1,'2012-02-03 10:04:44','C','C'),(194,28,6,'B','53.00000000',0,0,'2012-02-03 10:04:51','C','C'),(195,28,6,'B','53.00000000',1,1,'2012-02-03 10:04:51','O','C'),(196,28,6,'B','53.00000000',0,0,'2012-02-03 10:05:44','C','C'),(197,28,6,'B','53.00000000',4,4,'2012-02-03 10:05:44','O','C'),(198,28,6,'B','53.00000000',3,3,'2012-02-03 10:07:58','O','C'),(199,28,6,'B','54.00000000',1,0,'2012-02-03 10:08:07','C','F'),(200,28,6,'B','54.00000000',3,3,'2012-02-03 10:08:07','O','C'),(201,28,6,'S','54.00000000',1,0,'2012-02-03 10:08:39','C','F'),(202,28,6,'B','130.00000000',5,2,'2012-02-03 10:12:34','O','C'),(203,28,6,'S','150.00000000',3,3,'2012-02-03 10:12:59','C','C'),(204,28,6,'B','55.00000000',3,3,'2012-02-03 10:13:13','C','C'),(205,28,6,'B','90.00000000',4,0,'2012-02-07 13:07:09','C','F'),(206,28,6,'S','90.00000000',3,0,'2012-02-07 13:07:28','C','F'),(207,28,6,'S','90.00000000',1,0,'2012-02-07 13:07:28','O','F'),(208,29,6,'S','90.00000000',1,0,'2012-02-07 13:10:51','C','F'),(209,28,6,'B','100.00000000',1,0,'2012-02-07 13:11:21','C','F'),(210,28,6,'B','100.00000000',1,1,'2012-02-07 13:11:21','O','C'),(211,29,6,'S','120.00000000',1,1,'2012-02-07 13:18:09','O','C'),(212,28,6,'B','5.01000000',1,1,'2012-02-08 12:02:24','O','C'),(213,28,6,'S','121.00000000',1,1,'2012-02-08 14:01:29','C','C'),(214,28,6,'B','100.00000000',1,1,'2012-02-08 14:21:14','O','C'),(215,28,6,'B','100.00000000',1,0,'2012-02-08 14:32:52','O','F'),(216,28,6,'B','12.00000000',1,1,'2012-02-08 14:44:26','O','C'),(217,28,6,'B','99.00000000',2,1,'2012-02-14 15:17:30','O','C'),(218,28,6,'B','98.00000000',8,8,'2012-02-14 15:17:43','O','C'),(219,28,6,'S','50.00000000',1,0,'2012-02-14 15:18:25','C','F'),(220,28,6,'B','400.00000000',2,0,'2012-02-14 15:19:56','O','F'),(221,29,6,'S','400.00000000',2,0,'2012-02-14 15:20:36','O','F'),(222,29,6,'S','99.00000000',1,0,'2012-02-14 15:21:05','O','F'),(223,28,6,'S','99.00000000',5,4,'2012-02-14 15:26:31','C','C'),(224,29,6,'B','1.00000000',1,1,'2012-02-14 15:27:44','C','C'),(225,29,6,'B','99.00000000',1,0,'2012-02-14 15:29:30','C','F'),(226,29,6,'B','4.00000000',1,1,'2012-02-14 15:33:48','C','O'),(227,29,6,'B','4.00000000',3,3,'2012-02-14 15:33:48','O','O'),(228,28,6,'S','99.00000000',4,4,'2012-02-14 15:34:15','C','C'),(229,28,6,'S','99.00000000',4,4,'2012-02-14 15:34:57','C','C'),(230,28,6,'S','99.00000000',4,4,'2012-02-14 15:35:09','C','C'),(231,28,6,'S','108.90000000',4,4,'2012-02-14 15:39:58','C','C'),(232,28,6,'S','89.10000000',4,4,'2012-02-14 15:40:35','C','C'),(233,28,6,'S','89.10000000',4,4,'2012-02-15 08:32:52','C','C'),(234,28,6,'S','89.10000000',4,4,'2012-02-16 13:51:04','C','C'),(235,28,6,'S','89.10000000',4,4,'2012-02-16 13:53:04','C','C'),(236,28,6,'S','89.10000000',4,4,'2012-02-16 13:54:04','C','C'),(237,28,6,'S','89.10000000',4,4,'2012-02-16 13:55:05','C','C'),(238,28,6,'S','89.10000000',4,4,'2012-02-16 13:58:05','C','C'),(239,28,6,'S','89.10000000',4,4,'2012-02-16 13:59:05','C','C'),(240,28,6,'S','89.10000000',4,4,'2012-02-16 14:16:05','C','C'),(241,28,6,'S','89.10000000',4,4,'2012-02-16 14:18:05','C','C'),(242,28,6,'S','89.10000000',4,4,'2012-02-17 09:01:58','C','C'),(243,28,6,'S','89.10000000',4,4,'2012-03-08 12:14:01','C','O');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (14,28,6,'B','100.00000000',1,'2012-02-14 15:18:25'),(15,28,6,'B','400.00000000',2,'2012-02-14 15:20:36'),(16,29,6,'S','400.00000000',1,'2012-02-14 15:20:36'),(17,28,6,'B','99.00000000',1,'2012-02-14 15:21:05'),(18,29,6,'S','99.00000000',1,'2012-02-14 15:21:05');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans`
--

LOCK TABLES `trans` WRITE;
/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
INSERT INTO `trans` VALUES (1,154,155,'110.00000000',1,'S','2012-01-10 23:41:52'),(2,156,158,'100.00000000',1,'S','2012-01-12 01:52:56'),(3,159,167,'100.00000000',1,'S','2012-01-12 02:39:41'),(4,159,168,'100.00000000',1,'S','2012-01-12 02:40:36'),(5,172,173,'100.00000000',1,'S','2012-01-12 07:52:24'),(6,174,177,'100.00000000',1,'S','2012-02-03 01:00:51'),(7,199,201,'54.00000000',1,'S','2012-02-03 02:08:39'),(8,202,177,'100.00000000',1,'B','2012-02-03 02:12:34'),(9,202,157,'110.00000000',1,'B','2012-02-03 02:12:34'),(10,202,176,'120.00000000',1,'B','2012-02-03 02:12:34'),(11,205,206,'90.00000000',3,'S','2012-02-07 05:07:28'),(12,205,207,'90.00000000',1,'S','2012-02-07 05:07:28'),(13,209,208,'90.00000000',1,'B','2012-02-07 05:11:21'),(14,215,219,'100.00000000',1,'S','2012-02-14 07:18:25'),(15,220,221,'400.00000000',2,'S','2012-02-14 07:20:36'),(16,217,222,'99.00000000',1,'S','2012-02-14 07:21:05'),(17,225,223,'99.00000000',1,'B','2012-02-14 07:29:30');
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
  `s_coupon` decimal(2,2) DEFAULT NULL,
  `num` smallint(6) DEFAULT NULL,
  `comment` varchar(16) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`userattr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userattr`
--

LOCK TABLES `userattr` WRITE;
/*!40000 ALTER TABLE `userattr` DISABLE KEYS */;
INSERT INTO `userattr` VALUES (5,45,'C','0.10',5,'Invited Registra','2012-02-29 10:41:37'),(4,44,'C','0.10',5,'Invited Registra','2012-02-21 14:21:53'),(6,46,'C','0.10',5,'Invited Registra','2012-02-29 13:17:38'),(7,47,'C','0.10',5,'Invited Registra','2012-02-29 13:19:08'),(8,48,'C','0.10',5,'Invited Registra','2012-02-29 13:37:35'),(9,49,'C','0.10',5,'Invited Registra','2012-02-29 13:38:12'),(10,50,'C','0.10',5,'Invited Registra','2012-02-29 13:38:45'),(11,51,'C','0.10',5,'Invited Registra','2012-02-29 13:49:16'),(12,52,'C','0.10',5,'Invited Registra','2012-02-29 13:53:42'),(13,53,'C','0.10',5,'Invited Registra','2012-02-29 14:01:34'),(14,54,'C','0.10',5,'Invited Registra','2012-02-29 14:15:34'),(15,55,'C','0.10',5,'Invited Registra','2012-02-29 14:16:45'),(16,56,'C','0.10',5,'Invited Registra','2012-02-29 16:22:40'),(17,57,'C','0.10',5,'Invited Registra','2012-02-29 16:25:06'),(18,58,'C','0.10',5,'Invited Registra','2012-02-29 16:25:54'),(19,59,'C','0.10',5,'Invited Registra','2012-02-29 16:27:10'),(20,60,'C','0.10',5,'Invited Registra','2012-02-29 16:27:40'),(21,61,'C','0.10',5,'Invited Registra','2012-02-29 16:28:33'),(22,62,'C','0.10',5,'Invited Registra','2012-02-29 16:36:37'),(23,63,'C','0.10',5,'Invited Registra','2012-02-29 16:38:12'),(24,64,'C','0.10',5,'Invited Registra','2012-02-29 16:57:45'),(25,65,'C','0.10',5,'Invited Registra','2012-03-01 08:04:24');
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
  PRIMARY KEY (`userbalance_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userbalance`
--

LOCK TABLES `userbalance` WRITE;
/*!40000 ALTER TABLE `userbalance` DISABLE KEYS */;
INSERT INTO `userbalance` VALUES (15,28,'2011-12-31','0.00000000','0.00000000','0.00000000','0.00000000'),(16,29,'2011-12-31','0.00000000','0.00000000','0.00000000','0.00000000'),(17,28,'2012-02-20','0.13812050','-0.00037950','0.03900000','0.09950000'),(18,29,'2012-02-20','0.78082730','-0.00017270','0.28100000','0.50000000'),(19,28,'2012-02-21','0.13812050','-0.00037950','0.03900000','0.09950000'),(20,29,'2012-02-21','0.78082730','-0.00017270','0.28100000','0.50000000'),(21,28,'2012-02-22','0.13812050','-0.00037950','0.03900000','0.09950000'),(22,29,'2012-02-22','0.78082730','-0.00017270','0.28100000','0.50000000'),(23,28,'2012-02-26','0.13812050','-0.00037950','0.03900000','0.09950000'),(24,29,'2012-02-26','0.78082730','-0.00017270','0.28100000','0.50000000'),(25,28,'2012-02-27','0.13812050','-0.00037950','0.03900000','0.09950000'),(26,29,'2012-02-27','0.78082730','-0.00017270','0.28100000','0.50000000'),(27,28,'2012-02-28','0.13812050','-0.00037950','0.03900000','0.09950000'),(28,29,'2012-02-28','0.78082730','-0.00017270','0.28100000','0.50000000'),(29,28,'2012-02-29','0.13812050','-0.00037950','0.03900000','0.09950000'),(30,29,'2012-02-29','0.78082730','-0.00017270','0.28100000','0.50000000'),(31,28,'2012-03-07','0.13814995','-0.00035005','0.03900000','0.09950000'),(32,29,'2012-03-07','0.78083747','-0.00016253','0.28100000','0.50000000'),(33,28,'2012-03-08','0.13814995','-0.00035005','0.03900000','0.09950000'),(34,29,'2012-03-08','0.78083747','-0.00016253','0.28100000','0.50000000'),(35,28,'2012-03-11','0.13814995','-0.00035005','0.03900000','0.09950000'),(36,29,'2012-03-11','0.78083747','-0.00016253','0.28100000','0.50000000'),(37,28,'2012-03-12','0.13814995','-0.00035005','0.03900000','0.09950000'),(38,29,'2012-03-12','0.78083747','-0.00016253','0.28100000','0.50000000');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlog`
--

LOCK TABLES `userlog` WRITE;
/*!40000 ALTER TABLE `userlog` DISABLE KEYS */;
INSERT INTO `userlog` VALUES (15,28,'Login','127.0.0.1',166,'2012-01-18 05:47:53'),(16,29,'Login','127.0.0.1',23,'2012-02-02 09:02:43'),(17,43,'Login','127.0.0.1',4,'2012-02-20 01:16:53'),(18,44,'Login','127.0.0.1',3,'2012-02-21 06:22:11'),(19,65,'Login','127.0.0.1',2,'2012-03-08 01:53:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (28,'jian.xie@163.com','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==','UgXYBQe0A4UNKXrp45nRW27afaiHo/jY+Rvbdw==','Y','0.004000',0,0),(29,'jian.xie@hotmail.com','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==','N','0.004000',0,0),(30,'SYS','IOV3LkRV1JsVpCsPUv4JE0dL3o+W4ebP6eo9zw==',NULL,'N','0.004000',0,3),(65,'xiejian.cn@gmail.com','OyZpDNuR3I0xCYo7S4tVy8Q2R5mHRt0PQ1yeJQ==','OyZpDNuR3I0xCYo7S4tVy8Q2R5mHRt0PQ1yeJQ==','N','0.004000',0,3);
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
/*!50003 DROP FUNCTION IF EXISTS `CFEE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `CFEE`( opendate datetime,settledate datetime) RETURNS decimal(6,2)
BEGIN
DECLARE cfee1m decimal(3,2) DEFAULT 0.1;
	RETURN GREATEST(ceiling(datediff(settledate,opendate)/30),2) * cfee1m ;
	   
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FRATE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `FRATE`( pvol DECIMAL(20,8)) RETURNS decimal(6,6)
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
/*!50003 DROP FUNCTION IF EXISTS `N` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `N`( b_s CHAR(1)) RETURNS char(1) CHARSET latin1
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
/*!50003 DROP FUNCTION IF EXISTS `RRATE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `RRATE`( pvol DECIMAL(20,8)) RETURNS decimal(6,6)
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
		IN pbs CHAR(1),IN `ppoint` DECIMAL(20,8),IN plots INTEGER)
BEGIN
declare vplots int default 0;
DECLARE vmargin_req,vbtcavail DECIMAL(20,10) DEFAULT 0;
SELECT ifnull(sum(lots),0) into vplots FROM positions WHERE contract_id = pcontract AND user_id = puser AND buy_sell = N(pbs);
SELECT GREATEST(vplots-IFNULL(sum(rm_lots),0),0)INTO vplots FROM orders WHERE contract_id = pcontract AND user_id = puser AND buy_sell = pbs and type = 'C' and status = 'O';
if vplots >= plots then
	#new order is a cancel order
	INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)
		VALUES(puser,pcontract,pbs,ppoint,plots,plots,'C',NOW(),'N');
	CALL exchange(LAST_INSERT_ID(),puser,'A');
elseif vplots < plots and 0 <= plots then
	if vplots > 0 then
	#cancel those part
		INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)
			VALUES(puser,pcontract,pbs,ppoint,vplots,vplots,'C',NOW(),'N');
		CALL exchange(LAST_INSERT_ID(),puser,'A');
	end if;
	if plots - vplots > 0 then
	#open order
		SELECT ppoint*plots*btc_multi*leverage INTO vmargin_req FROM contract WHERE contract_id = pcontract AND STATUS = 'O';
		select balance - omargin - pmargin + p_l into vbtcavail from v_userbtc where user_id = puser;
		if vbtcavail > vmargin_req then
			INSERT INTO orders(user_id,contract_id,buy_sell,POINT,lots,rm_lots,TYPE,createtime,STATUS)
				VALUES(puser,pcontract,pbs,ppoint,plots-vplots,plots-vplots,'O',NOW(),'N');
			CALL exchange(LAST_INSERT_ID(),puser,'A');
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
/*!50003 DROP PROCEDURE IF EXISTS `forced_close` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `forced_close`(IN `puserid` INTEGER,in prealseamt decimal(20,8))
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
		call addorder(curcid,puserid,N(curbs),vclosepoint,vclots);
		set prealseamt = 0 ;
	else
		call addorder(curcid,puserid,N(curbs),vclosepoint,curlt);
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
/*!50003 DROP PROCEDURE IF EXISTS `update_contract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `update_contract`(IN cid integer,in pcode varchar(8),in pbtc_multi decimal(10,8),in popendate datetime,
in psettledate datetime,in pleverage decimal(4,3),in pfullname varchar(32),in puser INTEGER,in ptwitter_id varchar(16),
in pregion char(1),in psector char(1),in pdescription varchar(512))
main:BEGIN
DECLARE vfee_req,vbtcavail DECIMAL(20,10) DEFAULT 0;
declare res int default 0;
DECLARE vfee VARCHAR(40) default 'FEE';
SELECT count(1) into res FROM contract WHERE code=pcode and DATE_FORMAT(settledate,'%%y%%m') = DATE_FORMAT(psettledate,'%%y%%m');
if res > 0 then
	select 'err',CONCAT(code,DATE_FORMAT(psettledate,'%%y%%m')),cid;
	leave main;
end if;
SELECT CFEE(popendate,psettledate) - IFNULL(max(CFEE( opendate,settledate)),0) INTO vfee_req FROM contract WHERE contract_id = cid ;
SELECT balance - omargin - pmargin + p_l INTO vbtcavail FROM v_userbtc WHERE user_id = puser;
IF vbtcavail > vfee_req THEN
	if cid > 0 then
		UPDATE contract SET code=pcode,btc_multi=pbtc_multi,opendate=popendate,settledate=psettledate,leverage=pleverage,fullname=pfullname,
			twitter_id=ptwitter_id,region=pregion,sector=psector,description=pdescription WHERE contract_id = cid;
	else
		INSERT INTO contract(code,btc_multi,opendate,settledate,leverage,fullname,owner,twitter_id,region,sector,description) VALUES 
            (pcode,pbtc_multi,popendate,psettledate,pleverage,pfullname,puser,ptwitter_id,pregion,psector,pdescription);	
        select last_insert_id() into cid;
	end if;
	INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,TYPE) 
		select 'move',email,vfee,vfee_req,cid,NOW(),'H' from users where user_id = puser;
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
/*!50001 VIEW `v_gl` AS select 'T' AS `sector`,`t`.`trans_id` AS `trans_id`,`t`.`contract_id` AS `contract_id`,`t`.`type` AS `type`,`t`.`user_id` AS `user_id`,`t`.`buy_sell` AS `buy_sell`,`t`.`point` AS `point`,`t`.`lots` AS `lots`,`t`.`value` AS `value`,`t`.`timestamp` AS `timestamp`,`t`.`fee` AS `fee`,`t`.`p_l` AS `p_l`,NULL AS `btc` from `v_trans` `t` union all select 'R' AS `R`,NULL AS `NULL`,NULL AS `NULL`,`a`.`address` AS `address`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`a`.`input_dt` AS `input_dt`,-(`a`.`amount`) AS `-a.amount`,NULL AS `NULL`,NULL AS `NULL` from (`btc_action` `a` join `users` `u`) where ((`a`.`type` = 'R') and (`a`.`account1` = `u`.`email`)) union all select 'B' AS `B`,NULL AS `NULL`,NULL AS `NULL`,`b`.`type` AS `type`,`u`.`user_id` AS `user_id`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,NULL AS `NULL`,`b`.`timestamp` AS `timestamp`,NULL AS `NULL`,NULL AS `NULL`,(`b`.`amount` + `b`.`fee`) AS `b.amount+b.fee` from (`btc_trans` `b` join `users` `u`) where (`b`.`user` = `u`.`email`) */;
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
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_lastmonfee` AS select `btc_action`.`account1` AS `account1`,sum(`btc_action`.`amount`) AS `fee` from `btc_action` where ((`btc_action`.`account2` = 'FEE') and (extract(year_month from `btc_action`.`input_dt`) = extract(year_month from (now() + interval -(1) month)))) group by `btc_action`.`account1` */;
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

-- Dump completed on 2012-03-13 17:17:55
