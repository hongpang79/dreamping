drop table code;
drop table comboard;
drop table deposit;
drop table member;
drop table reservation;
drop table reservation_day;
drop table refund;
drop table season;
drop table product;
drop table addition;
drop table site_information;
drop table zone_information;
drop table holyday;
drop table siteboard;



CREATE TABLE `comboard` (
  `num` int(11) NOT NULL auto_increment,
  `category` varchar(10) default NULL,
  `writer` varchar(10) default NULL,
  `password` varchar(12) default NULL,
  `email` varchar(30) default NULL,
  `subject` varchar(255) default NULL,
  `reg_date` datetime default NULL,
  `read_count` int(11) default NULL,
  `notice_yn` varchar(1) default 'N',
  `secret_yn` varchar(1) default 'N',
  `ref` int(11) default NULL,
  `re_step` int(11) default NULL,
  `re_level` int(11) default NULL,
  `thumb_img_url` varchar(255) default NULL,
  `description` mediumtext,
  `re_description` mediumtext,
  PRIMARY KEY  (`num`)
) ENGINE=MyISAM;

CREATE TABLE `deposit` (
  `bank_name` varchar(20) NOT NULL,
  `account` varchar(30) NOT NULL,
  `depositor` varchar(20) NOT NULL
) ENGINE=MyISAM;

INSERT INTO `deposit` VALUES ('농협','351-0782-6363-83','맹정환(더드림핑)');

CREATE TABLE `season` (
  `season_code` varchar(1) NOT NULL,
  `season_name` varchar(25) NOT NULL,  
  `start_season` varchar(5) NOT NULL,
  `end_season` varchar(5) NOT NULL
) ENGINE=MyISAM;

/* INSERT INTO `season` VALUES ('L','비수기','01-01','02-29'); */
INSERT INTO `season` VALUES ('M','준성수기','04-01','06-30');
INSERT INTO `season` VALUES ('M','준성수기','09-01','10-31');
INSERT INTO `season` VALUES ('H','성수기','07-01','07-31');
INSERT INTO `season` VALUES ('H','성수기','08-16','08-31');
INSERT INTO `season` VALUES ('P','극성수기','08-01','08-15');
/* INSERT INTO `season` VALUES ('L','비수기','12-01','12-31'); */

CREATE TABLE `zone_information` (
  `zone_no` int(3) NOT NULL auto_increment,
  `zone_name` varchar(20) default NULL,
  `order_no` int(2) NOT NULL,
  `use_start_day` date default NULL,
  `use_end_day` date default NULL,
  `display_yn` varchar(1) default 'Y',
  `del_yn` varchar(1) default 'N',
  PRIMARY KEY  (`zone_no`)
) ENGINE=MyISAM;

CREATE TABLE `site_information` (
  `zone_no` int(3) NOT NULL,
  `site_no` int(3) NOT NULL auto_increment,
  `site_name` varchar(20) default NULL,
  `use_start_day` date default NULL,
  `use_end_day` date default NULL,
  `del_yn` varchar(1) default 'N',
  PRIMARY KEY  (`site_no`)
) ENGINE=MyISAM;


CREATE TABLE `product` (
  `product_no` int(3) NOT NULL auto_increment,
  `product_name` varchar(64) default NULL,
  `zone_no` int(3) NOT NULL,
  `site_no` int(3) NOT NULL,
  `site_name` varchar(20) default NULL,
  `users` int(2) default NULL,
  `max_users` int(2) default NULL,
  `add_child_price` int(6) default '0',
  `add_user_price` int(6) default '0',
  `low_season_weekday` int(6) default NULL, /*비수기 평일*/
  `low_season_weekend` int(6) default NULL, /*비수기 주말*/
  `low_season_picnic` int(6) default NULL, /*비수기 피크닉*/
  `middle_season_weekday` int(6) default NULL,/*준성수기 평일*/
  `middle_season_weekend` int(6) default NULL,/*준성수기 주말*/
  `middle_season_picnic` int(6) default NULL,/*준성수기 피크닉*/
  `high_season_weekday` int(6) default NULL,/*성수기 평일*/
  `high_season_weekend` int(6) default NULL,/*성수기 주말*/
  `high_season_picnic` int(6) default NULL,/*성수기 피크닉*/
  `peak_season_weekday` int(6) default NULL,/*극성수기 평일*/
  `peak_season_weekend` int(6) default NULL,/*극성수기 주말*/
  `peak_season_picnic` int(6) default NULL,/*극성수기 피크닉*/
  `display_start_day` date default NULL,
  `display_end_day` date default NULL,
  `use_yn` varchar(1) default 'Y', 	/*사용여부*/
  `sale` int(2) default NULL, /*sale*/
  `sale_start_day` date default NULL,
  `sale_end_day` date default NULL,
  `sale_memo` varchar(512) default NULL,
  `flat_price` int(6) default NULL, /*균일가*/
  `flat_price_start_day` date default NULL,
  `flat_price_end_day` date default NULL,
  `product_memo` varchar(512) default NULL,
  `del_yn` varchar(1) default 'N',
  PRIMARY KEY  (`product_no`)
) ENGINE=MyISAM;

CREATE TABLE `addition` (
  `addition_no` int(3) NOT NULL auto_increment,
  `addition_name` varchar(64) default NULL,
  `zone_no` int(3) NOT NULL,
  `unit` varchar(32) default NULL,/*단위*/
  `addition_price` int(6) default '0',
  `quantity` int(6) default '9999', /*판매가능한 수량*/
  `addition_memo` varchar(512) default NULL,
  `display_start_day` date default NULL,
  `display_end_day` date default NULL,
  `use_yn` varchar(1) default 'Y', 	/*사용여부*/
  `del_yn` varchar(1) default 'N',
  PRIMARY KEY  (`addition_no`)
) ENGINE=MyISAM;

CREATE TABLE `reservation` (
  `reservation_no` int(11) NOT NULL auto_increment,
  `product_no` int(3) NOT NULL,
  `site_no` int(3) default NULL,
  `member_no` int(11) default NULL,
  `reservation_date` date default NULL,		/*예약일자*/
  `nights` int(2) default NULL,				/*~박*/
  `toddler` int(2) default NULL,			/*유아*/
  `child` int(2) default NULL,				/*어린이*/
  `users` int(2) default NULL,				/*이용인원*/
  `price` int(7) default NULL,				/*이용금액*/
  `payment` char(1) default 'V',			/*무통장입금*/
  `bank_name` varchar(20) default NULL,		/*입금은행명*/
  `account` varchar(20) default NULL,		/*입금계좌번호*/
  `pay_status` char(1) default 'N',			/*입금여부*/
  `addition` varchar(2048) default NULL,    /*부가서비스*/ 
  `reserver` varchar(12) NOT NULL,			/*예약자*/
  `email` varchar(50) default NULL,
  `phone1` varchar(5) default NULL,
  `phone2` varchar(5) default NULL,
  `phone3` varchar(5) default NULL,
  `cell1` varchar(5) default NULL,
  `cell2` varchar(5) default NULL,
  `cell3` varchar(5) default NULL,
  `memo` varchar(2048) default NULL,			/*요청사항*/
  `refund_bank` varchar(25) default NULL,		/*환불받을 은행명*/
  `refund_depositor` varchar(25) default NULL,	/*환불받을 예금주*/
  `refund_account` varchar(48) default NULL,	/*환불받을  계좌번호*/
  `refund_price` int(7) default NULL,		    /*환불금액*/
  `refund_memo` varchar(1024) default NULL,	 	/*환불금액기준*/
  `remark` varchar(1024) default NULL,			/*취소사유*/
  `refund_reg_date` date default NULL,			/*환불요청 일자*/
  `refund_date` date default NULL,				/*환불일자*/
  `admin_memo` varchar(1024) default NULL,		/*요청사항*/
  `reg_date` date default NULL,
  PRIMARY KEY  (`reservation_no`),
  KEY `reservation_rno_fk` (`site_no`)
) ENGINE=MyISAM ;

CREATE TABLE `reservation_day` (
  `reservation_month` varchar(6) default NULL, /*YYYYMM*/
  `reservation_day` varchar(8) default NULL,   /*YYYYMMDD*/
  `zone_name` varchar(20) default NULL,
  `site_no` int(3) default NULL,
  `reservation_no` int(11) default NULL,
  `pay_status` varchar(1) default NULL,
  `reg_date` date default NULL
) ENGINE=MyISAM;

CREATE TABLE `refund` (
  `refund_day_before` int(2) NOT NULL,
  `refund_type` varchar(1) NOT NULL,
  `refund_amount` int(7) default NULL
) ENGINE=MyISAM;

INSERT INTO `refund` VALUES (7,'P',90);
INSERT INTO `refund` VALUES (5,'P',70);
INSERT INTO `refund` VALUES (3,'P',50);
INSERT INTO `refund` VALUES (1,'P',20);
INSERT INTO `refund` VALUES (0,'P',0);

CREATE TABLE `sms_manager` (
  `msg_no` int(5) NOT NULL,
  `dvsn` varchar(25) NOT NULL,
  `description` varchar(255) default NULL,
  `msg` varchar(1024) default NULL,
  PRIMARY KEY  (`msg_no`,`dvsn`)
) ENGINE=MyISAM;

INSERT INTO `sms_manager` VALUES (1,'user','예약접수(무통장입금)','드림핑 [DATE]에 [SITENAME]의 예약신청이 완료되었습니다 입금계좌는 [BANK][ACCOUNT] [DEPOSITOR] [PRICE]원이며, [DEPOSITDATE]까지 입금 부탁 드립니다. 입금이 확인되면 예약이 완료되며, 미입금시에는 예약이 취소됩니다.');
INSERT INTO `sms_manager` VALUES (2,'user','입금안내 메시지(무통장입금)','입금계좌는 [BANK][ACCOUNT] [DEPOSITOR] [PRICE]원이며, [DEPOSITDATE]까지 입금 부탁 드립니다. 입금이 확인되면 예약이 완료되며, 미입금시에는 예약이 취소됩니다.');
INSERT INTO `sms_manager` VALUES (3,'user','결제완료(무통장입금)','드림핑 [DATE]에 [SITENAME]의 입금 확인되었습니다. 감사합니다');
INSERT INTO `sms_manager` VALUES (4,'user','예약취소완료','드림핑 [DATE]에 [SITENAME]의 예약취소가 처리되었습니다');
INSERT INTO `sms_manager` VALUES (5,'user','환불완료','드림핑 [DATE]에 [SITENAME]의 취소하신 예약환불처리가 완료되었습니다');
INSERT INTO `sms_manager` VALUES (1,'admin','예약접수(무통장입금)','드림핑 [DATE]에 [SITENAME]의 예약신청이 접수되었습니다');
INSERT INTO `sms_manager` VALUES (2,'admin','입금안내 메시지(무통장입금)','');
INSERT INTO `sms_manager` VALUES (3,'admin','결제완료(무통장입금)','');
INSERT INTO `sms_manager` VALUES (4,'admin','예약취소완료','드림핑 [DATE]에 [SITENAME]의 예약이 취소되었습니다(환불없음)');
INSERT INTO `sms_manager` VALUES (5,'admin','예약취소(환불요청)','드림핑 [DATE]에 [SITENAME]의 예약취소/환불신청이 접수되었습니다');
INSERT INTO `sms_manager` VALUES (6,'admin','qna질문등록','드림핑 질문이 등록되었습니다. 답변달아주세요');

CREATE TABLE `sms_phone` (
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(25) default NULL,
  `dvsn` varchar(25) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`phone_number`)
) ENGINE=MyISAM ;

INSERT INTO `sms_phone` VALUE ('01093167879','홍성규','manager','관리자');
INSERT INTO `sms_phone` VALUE ('01059699972','이민진','admin','예약관리자');

CREATE TABLE `sms_log` (
  `log_no` int(18) NOT NULL auto_increment,
  `reservation_no` int(11) NOT NULL,
  `msg_no` int(5) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `msg` varchar(2000) default NULL,
  `return_code` varchar(4) default NULL,
  `return_msg` varchar(255) default NULL,
  `reg_date` date default NULL,
  PRIMARY KEY  (`log_no`)
) ENGINE=MyISAM;

CREATE TABLE `member` (
  `member_no` int(5) NOT NULL auto_increment,
  `id` varchar(50) NOT NULL,
  `password` varchar(12) NOT NULL,
  `grade` varchar(1) NOT NULL, /* A:관리자 / B:운영자  */
  `name` varchar(12) NOT NULL,
  `date_of_birth` char(8) default NULL,
  `sex` char(1) default NULL,
  `email` varchar(50) default NULL,
  `recv_yn` char(1) default NULL,
  `phone1` varchar(5) default NULL,
  `phone2` varchar(5) default NULL,
  `phone3` varchar(5) default NULL,
  `cell1` varchar(5) NOT NULL,
  `cell2` varchar(5) NOT NULL,
  `cell3` varchar(5) NOT NULL,
  `zip` char(7) default NULL,
  `address1` varchar(100) default NULL,
  `address2` varchar(50) default NULL,
  `reg_date` date default NULL,
  PRIMARY KEY  (`member_no`,`id`)
) ENGINE=MyISAM;

	insert into member values(0,'admin','mnmdream','A','관리자',20170701,0,'admin@thedreamping.com','n','041','000','0000','010','0000','0000','000-000','금남리123','금남리123',NOW());

CREATE TABLE `call` (
  `call_no` int(5) NOT NULL auto_increment,
  `call_name` varchar(50) default NULL,
  `phone1` varchar(5) default NULL,
  `phone2` varchar(5) default NULL,
  `phone3` varchar(5) default NULL,
  `call_status` varchar(1) default 'W',
  `call_date` datetime default NULL,
  `call_memo` varchar(2000) default NULL,
  `reg_date` datetime default NULL,
  PRIMARY KEY (`call_no`)
) ENGINE=MyISAM;

CREATE TABLE `code` (
  `code_no` int(5) NOT NULL auto_increment,
  `code_group` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `code_name` varchar(48) NOT NULL,
  `code_seq` int(2) NOT NULL,
  `code_description` varchar(255) default NULL,
  PRIMARY KEY (`code_no`)
) ENGINE=MyISAM;

insert into code values(1,'grade','A','관리자',1,'사이트 관리자');
insert into code values(2,'grade','B','운영자',2,'사이트 운영자');
insert into code values(11,'pay_status','Y','예약완료',1,'입금여부');
insert into code values(12,'pay_status','N','예약대기',2,'입금여부');
insert into code values(13,'pay_status','R','예약취소',3,'입금여부');
insert into code values(14,'pay_status','C','취소/환불요청',4,'입금여부');
insert into code values(15,'pay_status','F','환불완료',5,'입금여부');
insert into code values(21,'status','W','입금대기',1,'입금상태');
insert into code values(22,'status','C','입금완료',2,'입금상태');
insert into code values(23,'status','R','환불완료',3,'입금상태');
insert into code values(31,'refund_type','P','퍼센트',1,'환불금액타입');
insert into code values(32,'refund_type','W','원',2,'환불금액타입');


CREATE TABLE `holyday` (
  `dvsn_cd` varchar(5) NOT NULL,
  `mmdd` varchar(4) NOT NULL,
  `use_yn` varchar(1) NOT NULL default 'Y',
  `description` varchar(255) default NULL,
  PRIMARY KEY (`dvsn_cd`, `mmdd`)
) ENGINE=MyISAM;

insert into holyday values('SOLAR','0101','Y','신정');
insert into holyday values('SOLAR','0301','Y','삼일절');
insert into holyday values('SOLAR','0505','Y','어린이날');
insert into holyday values('SOLAR','0606','Y','현충일');
insert into holyday values('SOLAR','0815','Y','광복절');
insert into holyday values('SOLAR','1003','Y','개천절');
insert into holyday values('SOLAR','1009','Y','한글날');
insert into holyday values('SOLAR','1225','Y','크리스마스');
insert into holyday values('LUNAR','1231','Y','설날');
insert into holyday values('LUNAR','0101','Y','설날');
insert into holyday values('LUNAR','0102','Y','설날');
insert into holyday values('LUNAR','0408','Y','석가탄신일');
insert into holyday values('LUNAR','0814','Y','추석');
insert into holyday values('LUNAR','0815','Y','추석');
insert into holyday values('LUNAR','0816','Y','추석');









CREATE TABLE `popup` (
  `layer_id` varchar(25) NOT NULL,
  `style` varchar(255) default NULL,
  `img_src` varchar(255) default NULL,
  `usemap_id` varchar(25) default NULL,
  `area` varchar(1024) default NULL,
  `alt` varchar(255) default NULL,
  `use_yn` varchar(1) default 'Y',
  `display_start_day` date default NULL,
  `display_end_day` date default NULL,
  PRIMARY KEY (`layer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

insert into popup values('layer_pop','position:absolute; width:387px;left:26%;margin-left:500px; top:450px; z-index:1', '/images/main/register.jpg','event_notice','<area shape="rect" coords="355,575,384,589" href="javascript:pop_close(\'layer_pop\');" />','캠핑장등록증','Y',now(),now());
insert into popup values('layer_pop1','position:absolute; width:387px;left:26%;margin-left:110px; top:450px; z-index:1', '/images/main/register1.jpg','event_notice1','<area shape="rect" coords="355,575,384,589" href="javascript:pop_close(\'layer_pop1\');" />','요트프리','N',now(),now());
insert into popup values('layer_pop0','position:absolute; width:387px;left:26%;margin-left:-200px; top:250px; z-index:1', '/images/notice.jpg','event_notice0','<area shape="rect" coords="333,229,379,239" href="javascript:pop_close(\'layer_pop0\');" />','입금자 찾기','N',now(),now());
insert into popup values('layer_pop2','position:absolute; width:387px;left:26%;margin-left:-200px; top:250px; z-index:1', '/images/main/IMG_5939_popup.jpg','event_notice0','<area shape="rect" coords="401,550,430,565" href="javascript:pop_close(\'layer_pop2\');" /><area shape="rect" coords="2,1,430,546" href="/main/board/view.jsp?num=396&pageNum=1&category=notice" />','클캠이벤트','N',now(),now());
insert into popup values('layer_pop3','position:absolute; width:433px;left:26%;margin-left:-200px; top:250px; z-index:1', '/images/main/SOLOCAMP.jpg','event_notice3','<area shape="rect" coords="395,638,433,650" href="javascript:pop_close(\'layer_pop3\');" /><area shape="rect" coords="2,2,433,637" href="/main/board/view.jsp?num=429&pageNum=1&category=notice" />','솔캠이벤트','N',now(),now());
insert into popup values('layer_pop4','position:absolute; width:433px;left:26%;margin-left:500px; top:450px; z-index:1', '/images/main/membershippopup.jpg','event_notice4','<area shape="rect" coords="368,391,408,408" href="javascript:pop_close(\'layer_pop4\');" /><area shape="rect" coords="2,1,415,387" href="/main/board/view.jsp?num=436&pageNum=1&category=notice" />','맴버쉽','Y',now(),now());
insert into popup values('layer_pop5','position:absolute; width:433px;left:26%;margin-left:0px; top:450px; z-index:1', '/images/main/201603event_popup.jpg','event_notice5','<area shape="rect" coords="447,403,488,418" href="javascript:pop_close(\'layer_pop5\');" /><area shape="rect" coords="0,1,487,400" href="/main/board/view.jsp?num=436&pageNum=1&category=notice" />','2016특가이벤트','Y',now(),now());

CREATE TABLE `popup` (
  `popup_no` int(5) NOT NULL auto_increment,
  `popup_subject` varchar(255) NOT NULL,
  `popup_content` varchar(2000) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `use_yn` varchar(1) default 'N',
  PRIMARY KEY (`popup_no`)
) ENGINE=MyISAM;

insert into popup value(0,'입금자를 찾습니다.','7월 22일 최*원님',DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y');

CREATE TABLE `siteboard` (
  `num` int(11) NOT NULL auto_increment,
  `category` varchar(10) default NULL,
  `zone_no` varchar(10) default NULL,
  `subject` varchar(50) default NULL,
  `img_url` varchar(255) default NULL,
  `board_no` int(11),
  `display_start_day` date default NULL,
  `display_end_day` date default NULL,
  `use_yn` varchar(1) default 'Y', 	/*사용여부*/
  `contents` mediumtext,
  PRIMARY KEY  (`num`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

