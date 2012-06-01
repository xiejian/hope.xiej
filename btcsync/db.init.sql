delimiter //
drop procedure if exists `p_update_contract``stored procedure` //

CREATE DEFINER=`root`@`%` PROCEDURE `p_update_contract`(IN `cid` integer, IN `pcode` varchar(8), IN `pbtc_multi` decimal(10,8), IN `popendate` datetime, IN `psettledate` datetime, IN `pleverage` decimal(4,3), IN `pfullname` varchar(32), IN `puser` INTEGER, IN `ptwitter_id` varchar(16), IN `pwrite_fee` deCIMAL(6,6), IN `pregion` char(1), IN `psector` char(1), IN `pdescription` varchar(512), IN `pmovelimit` decIMAL(3,2))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
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
END //

DELIMITER ;