-- MySQL dump 10.13  Distrib 5.1.63, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: btcfe
-- ------------------------------------------------------
-- Server version	5.1.63-0ubuntu0.10.04.1

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

	RETURN GREATEST(ceiling(datediff(settledate,opendate)/31),2) * cfee1m ;
	   
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

DECLARE curc CURSOR FOR SELECT contract_id,write_fee,settledate,owner FROM contract where status in('O','C','Q','S');

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

				select 'move',u.email,'FEE',concat(DATE_FORMAT(NOW() + interval -1 day, '%d%b%Y')),-1*v_cfee,curcontract_id,'C',NOW() from users u 

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
DECLARE minfee DECIMAL(20,8) DEFAULT '0.00005';

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

INSERT INTO btc_action(ACTION,account1,account2,amount,trans_id,input_dt,type) VALUES ('move',vbuser,vfee,(1+(vbtype ='F')) * GREATEST(minfee,ppoint*plots*vcbtcmulti*(vbfeerate+vcfeerate)),vtrans_id,NOW(),'F')

		, ('move',vsuser,vfee,(1+(vstype ='F')) * GREATEST(minfee,ppoint*plots*vcbtcmulti*(vsfeerate+vcfeerate)),vtrans_id,NOW(),'G');



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

SELECT count(1) into res FROM contract WHERE code=pcode and DATE_FORMAT(settledate,'%y%m') = DATE_FORMAT(psettledate,'%y%m') and 
    contract_id <> cid and status <> 'D';

if res > 0 then
	select 'err',CONCAT('Contract ',pcode,DATE_FORMAT(psettledate,'%y%m'),' already exist.'),cid;
	leave main;
end if;

SELECT f_CFEE(popendate,psettledate) - IFNULL(max(f_CFEE( opendate,settledate)),0) INTO vfee_req FROM contract WHERE contract_id = cid ;
SELECT balance - omargin - pmargin + p_l INTO vbtcavail FROM v_userbtc WHERE user_id = puser;

IF vbtcavail >= vfee_req THEN
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
/*!50003 DROP PROCEDURE IF EXISTS `p__del_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `p__del_table`()
BEGIN

delete from btc_account;
delete from btc_action;
delete from btc_synclog;
delete from btc_trans;
delete from contract;
delete from marketinfo;
delete from orders;
delete from positions;
delete from sys_status;
delete from trans;
delete from userattr;
delete from userbalance;
delete from userlog;
delete from users;
commit;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-09-03 15:48:08
