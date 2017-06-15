drop table code;
drop table comboard;
drop table deposit;
drop table member;
drop table reservation;
drop table reservation_day;
drop table refund;
drop table season;
drop table product;
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
  `subject` varchar(50) default NULL,
  `reg_date` date default NULL,
  `read_count` int(11) default NULL,
  `notice_yn` varchar(1) default 'N',
  `secret_yn` varchar(1) default 'N',
  `ref` int(11) default NULL,
  `re_step` int(11) default NULL,
  `re_level` int(11) default NULL,
  `thumb_img_url` varchar(255) default NULL,
  `description` mediumtext,
  PRIMARY KEY  (`num`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

CREATE TABLE `deposit` (
  `bank_name` varchar(20) NOT NULL,
  `account` varchar(30) NOT NULL,
  `depositor` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

INSERT INTO `deposit` VALUES ('농협','351-0782-6363-83','오연주(어반슬로우시티)');

CREATE TABLE `season` (
  `season_code` varchar(1) NOT NULL,
  `season_name` varchar(25) NOT NULL,  
  `start_season` varchar(5) NOT NULL,
  `end_season` varchar(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

/* INSERT INTO `season` VALUES ('L','비수기','01-01','02-29'); */
INSERT INTO `season` VALUES ('M','준성수기','03-01','06-30');
INSERT INTO `season` VALUES ('M','준성수기','09-01','11-30');
INSERT INTO `season` VALUES ('H','성수기','07-01','08-31');
/* INSERT INTO `season` VALUES ('L','비수기','12-01','12-31'); */

CREATE TABLE `zone_information` (
  `zone_no` int(3) NOT NULL auto_increment,
  `zone_name` varchar(20) default NULL,
  `order_no` int(2) NOT NULL,
  `use_start_day` date default NULL,
  `use_end_day` date default NULL,
  PRIMARY KEY  (`zone_no`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

INSERT INTO `zone_information` VALUES (1,'레인보우',1,'2015-06-01','2024-05-31');
INSERT INTO `zone_information` VALUES (2,'블랙쉘타',2,'2015-06-01','2024-05-31');
INSERT INTO `zone_information` VALUES (3,'유니온잭',3,'2015-06-01','2024-05-31');
INSERT INTO `zone_information` VALUES (4,'빅돔',4,'2015-06-01','2024-05-31');
INSERT INTO `zone_information` VALUES (5,'스파하우스',5,'2015-06-01','2024-05-31');
INSERT INTO `zone_information` VALUES (6,'리스토어차량',6,'2015-06-01','2024-05-31');
INSERT INTO `zone_information` VALUES (7,'셀프존',7,'2015-06-01','2024-05-31');

CREATE TABLE `site_information` (
  `zone_no` int(3) NOT NULL,
  `site_no` int(3) NOT NULL auto_increment,
  `site_name` varchar(20) default NULL,
  `use_start_day` date default NULL,
  `use_end_day` date default NULL,
  PRIMARY KEY  (`site_no`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

INSERT INTO `site_information` VALUES (1,1,'레인보우1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (1,2,'레인보우2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (1,3,'레인보우3','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (1,4,'레인보우4','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (1,5,'레인보우5','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (2,6,'블랙1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (2,7,'블랙2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (2,8,'블랙3','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (2,9,'블랙4','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (2,10,'블랙5','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (3,11,'유니온잭1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (3,12,'유니온잭2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (3,13,'유니온잭3','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (3,14,'유니온잭4','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (4,15,'빅돔1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (4,16,'빅돔2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (4,17,'빅돔3','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (4,18,'빅돔4','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (4,19,'빅돔5','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (4,20,'빅돔6','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (5,21,'스파하우스1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (5,27,'스파하우스2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (6,22,'리스토어차량1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (6,23,'리스토어차량2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (6,24,'리스토어차량3','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (6,25,'리스토어차량4','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (6,26,'리스토어차량5','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,28,'셀프1','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,29,'셀프2','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,30,'셀프3','2015-06-01','2024-05-31');

INSERT INTO `site_information` VALUES (7,31,'셀프4','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,32,'셀프5','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,33,'셀프6','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,34,'셀프7','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,35,'셀프8','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,36,'셀프9','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,37,'셀프10','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,38,'셀프11','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,39,'셀프12','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,40,'셀프13','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,41,'셀프14','2015-06-01','2024-05-31');
INSERT INTO `site_information` VALUES (7,42,'셀프15','2015-06-01','2024-05-31');

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
  PRIMARY KEY  (`product_no`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;


INSERT INTO `product` VALUES (1,'레인보우1',1,1,'레인보우1',2,2,10000,20000,61000,100000,50000,91000,130000,80000,141000,180000,130000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (2,'레인보우2',1,2,'레인보우2',2,2,10000,20000,61000,100000,50000,91000,130000,80000,141000,180000,130000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (3,'레인보우3',1,3,'레인보우3',2,2,10000,20000,61000,100000,50000,91000,130000,80000,141000,180000,130000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (4,'레인보우4',1,4,'레인보우4',2,2,10000,20000,61000,100000,50000,91000,130000,80000,141000,180000,130000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (5,'레인보우5',1,5,'레인보우5',2,2,10000,20000,61000,100000,50000,91000,130000,80000,141000,180000,130000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (6,'블랙1',2,6,'블랙1',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (7,'블랙2',2,7,'블랙2',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (8,'블랙3',2,8,'블랙3',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (9,'블랙4',2,9,'블랙4',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (10,'블랙5',2,10,'블랙5',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (11,'유니온잭1',3,11,'유니온잭1',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (12,'유니온잭2',3,12,'유니온잭2',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (13,'유니온잭3',3,13,'유니온잭3',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (14,'유니온잭4',3,14,'유니온잭4',4,6,10000,20000,96000,150000,70000,126000,180000,100000,176000,230000,150000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (15,'빅돔1',4,15,'빅돔1',4,6,10000,20000,110000,170000,90000,140000,200000,120000,190000,250000,170000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (16,'빅돔2',4,16,'빅돔2',4,6,10000,20000,110000,170000,90000,140000,200000,120000,190000,250000,170000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (17,'빅돔3',4,17,'빅돔3',4,6,10000,20000,110000,170000,90000,140000,200000,120000,190000,250000,170000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (18,'빅돔4',4,18,'빅돔4',4,6,10000,20000,110000,170000,90000,140000,200000,120000,190000,250000,170000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (19,'빅돔5',4,19,'빅돔5',4,6,10000,20000,110000,170000,90000,140000,200000,120000,190000,250000,170000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (20,'빅돔6',4,20,'빅돔6',4,6,10000,20000,110000,170000,90000,140000,200000,120000,190000,250000,170000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (21,'스파하우스1',5,21,'스파하우스1',2,6,10000,20000,184000,290000,0,224000,320000,0,274000,370000,0,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (27,'스파하우스2',5,27,'스파하우스2',2,6,10000,20000,184000,290000,0,224000,320000,0,274000,370000,0,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (22,'리스토어차량1',6,22,'리스토어차량1',2,4,10000,20000,75000,120000,60000,105000,150000,90000,155000,200000,140000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (23,'리스토어차량2',6,23,'리스토어차량2',2,4,10000,20000,75000,120000,60000,105000,150000,90000,155000,200000,140000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (24,'리스토어차량3',6,24,'리스토어차량3',2,4,10000,20000,75000,120000,60000,105000,150000,90000,155000,200000,140000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (25,'리스토어차량4',6,25,'리스토어차량4',2,4,10000,20000,75000,120000,60000,105000,150000,90000,155000,200000,140000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (26,'리스토어차량5',6,26,'리스토어차량5',2,4,10000,20000,75000,120000,60000,105000,150000,90000,155000,200000,140000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',20,DATE_FORMAT('2015-06-25','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'OPEN 특가 세일','');
INSERT INTO `product` VALUES (28,'셀프1',7,28,'셀프1',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (29,'셀프2',7,29,'셀프2',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (30,'셀프3',7,30,'셀프3',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');

INSERT INTO `product` VALUES (31,'패키지1(레인보우1+수상레저)',1,1,'레인보우1',2,2,10000,20000,0,0,0,0,0,0,162000,180000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 2회');
INSERT INTO `product` VALUES (32,'패키지1(레인보우2+수상레저)',1,2,'레인보우2',2,2,10000,20000,0,0,0,0,0,0,162000,180000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 2회');
INSERT INTO `product` VALUES (33,'패키지1(레인보우3+수상레저)',1,3,'레인보우3',2,2,10000,20000,0,0,0,0,0,0,162000,180000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 2회');
INSERT INTO `product` VALUES (34,'패키지1(레인보우4+수상레저)',1,4,'레인보우4',2,2,10000,20000,0,0,0,0,0,0,162000,180000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 2회');
INSERT INTO `product` VALUES (35,'패키지1(레인보우5+수상레저)',1,5,'레인보우5',2,2,10000,20000,0,0,0,0,0,0,162000,180000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 2회');
INSERT INTO `product` VALUES (36,'패키지1(블랙1+수상레저)',2,6,'블랙1',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (37,'패키지1(블랙2+수상레저)',2,7,'블랙2',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (38,'패키지1(블랙3+수상레저)',2,8,'블랙3',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (39,'패키지1(블랙4+수상레저)',2,9,'블랙4',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (40,'패키지1(블랙5+수상레저)',2,10,'블랙5',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (41,'패키지1(유니온잭1+수상레저)',3,11,'유니온잭1',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (42,'패키지1(유니온잭2+수상레저)',3,12,'유니온잭2',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (43,'패키지1(유니온잭3+수상레저)',3,13,'유니온잭3',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (44,'패키지1(유니온잭4+수상레저)',3,14,'유니온잭4',4,6,10000,20000,0,0,0,0,0,0,189000,210000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (45,'패키지1(빅돔1+수상레저)',4,15,'빅돔1',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (46,'패키지1(빅돔2+수상레저)',4,16,'빅돔2',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (47,'패키지1(빅돔3+수상레저)',4,17,'빅돔3',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (48,'패키지1(빅돔4+수상레저)',4,18,'빅돔4',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (49,'패키지1(빅돔5+수상레저)',4,19,'빅돔5',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (50,'패키지1(빅돔6+수상레저)',4,20,'빅돔6',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (51,'패키지1(스파하우스1+수상레저)',5,21,'스파하우스1',2,6,10000,20000,0,0,0,0,0,0,369000,410000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (52,'패키지1(스파하우스2+수상레저)',5,27,'스파하우스2',2,6,10000,20000,0,0,0,0,0,0,369000,410000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','수상레저 1박기준 4회(1일 1인 2회까지 사용가능)');
INSERT INTO `product` VALUES (53,'패키지2(레인보우1+보팅)',1,1,'레인보우1',2,2,10000,20000,0,0,0,0,0,0,180000,200000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (54,'패키지2(레인보우2+보팅)',1,2,'레인보우2',2,2,10000,20000,0,0,0,0,0,0,180000,200000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (55,'패키지2(레인보우3+보팅)',1,3,'레인보우3',2,2,10000,20000,0,0,0,0,0,0,180000,200000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (56,'패키지2(레인보우4+보팅)',1,4,'레인보우4',2,2,10000,20000,0,0,0,0,0,0,180000,200000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (57,'패키지2(레인보우5+보팅)',1,5,'레인보우5',2,2,10000,20000,0,0,0,0,0,0,180000,200000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (58,'패키지2(블랙1+보팅)',2,6,'블랙1',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (59,'패키지2(블랙2+보팅)',2,7,'블랙2',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (60,'패키지2(블랙3+보팅)',2,8,'블랙3',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (61,'패키지2(블랙4+보팅)',2,9,'블랙4',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (62,'패키지2(블랙5+보팅)',2,10,'블랙5',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (63,'패키지2(유니온잭1+보팅)',3,11,'유니온잭1',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (64,'패키지2(유니온잭2+보팅)',3,12,'유니온잭2',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (65,'패키지2(유니온잭3+보팅)',3,13,'유니온잭3',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (66,'패키지2(유니온잭4+보팅)',3,14,'유니온잭4',4,6,10000,20000,0,0,0,0,0,0,207000,230000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (67,'패키지2(빅돔1+보팅)',4,15,'빅돔1',4,6,10000,20000,0,0,0,0,0,0,225000,250000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (68,'패키지2(빅돔2+보팅)',4,16,'빅돔2',4,6,10000,20000,0,0,0,0,0,0,225000,250000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (69,'패키지2(빅돔3+보팅)',4,17,'빅돔3',4,6,10000,20000,0,0,0,0,0,0,225000,250000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (70,'패키지2(빅돔4+보팅)',4,18,'빅돔4',4,6,10000,20000,0,0,0,0,0,0,225000,250000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (71,'패키지2(빅돔5+보팅)',4,19,'빅돔5',4,6,10000,20000,0,0,0,0,0,0,225000,250000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (72,'패키지2(빅돔6+보팅)',4,20,'빅돔6',4,6,10000,20000,0,0,0,0,0,0,225000,250000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (73,'패키지2(스파하우스1+보팅)',5,21,'스파하우스1',2,6,10000,20000,0,0,0,0,0,0,387000,430000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');
INSERT INTO `product` VALUES (74,'패키지2(스파하우스2+보팅)',5,27,'스파하우스2',2,6,10000,20000,0,0,0,0,0,0,387000,430000,0,DATE_FORMAT('2015-07-01','%Y-%m-%d'),DATE_FORMAT('2015-08-31','%Y-%m-%d'),'Y',0,null,null,'','보팅 1박기준 1회');

INSERT INTO `product` VALUES (75,'셀프4',7,31,'셀프4',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (76,'셀프5',7,32,'셀프5',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (77,'셀프6',7,33,'셀프6',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (78,'셀프7',7,34,'셀프7',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (79,'셀프8',7,35,'셀프8',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (80,'셀프9',7,36,'셀프9',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (81,'셀프10',7,37,'셀프10',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (82,'셀프11',7,38,'셀프11',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (83,'셀프12',7,39,'셀프12',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (84,'셀프13',7,40,'셀프13',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (85,'셀프14',7,41,'셀프14',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');
INSERT INTO `product` VALUES (86,'셀프15',7,42,'셀프15',8,8,0,0,55000,55000,55000,55000,55000,55000,55000,55000,55000,DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y',0,null,null,'','');

INSERT INTO `product` VALUES (148, '감성1', 6, 170, '감성1', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (149, '감성2', 6, 171, '감성2', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (150, '감성3', 6, 172, '감성3', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (151, '감성4', 6, 173, '감성4', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (152, '감성5', 6, 174, '감성5', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (153, '감성6', 6, 175, '감성6', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (154, '감성7', 6, 176, '감성7', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);
INSERT INTO `product` VALUES (155, '감성8', 6, 177, '감성8', 4, 4, 10000, 20000, 96000, 96000, 70000, 126000, 180000, 100000, 176000, 230000, 150000, '2016-05-04', '2024-12-31', 'Y', 20, '2016-05-04', '2016-05-31', '5월 가정의 달 20%할인 이벤트 (평일 140,800원 / 주말 184,000원)<br/><불금이벤트 (평일요금)<br/><br/>', '난방비 25,000원 별도', 140800, '2016-05-04', '2016-05-31', NULL);

update `product` set sale_memo = '5~6월 캠핑시즌 이벤트!!<br/><br/>* 주말(토), 공휴일 전날 20%할인 (250,000원 → 200,000원)<br/>* 평일(일~금) 균일가 (190,000원 →  115,000원)<br/><br/>'
                    ,flat_price = '115000'
                    ,flat_price_start_day = '2016-05-01'
                    ,flat_price_end_day = '2016-06-30'
                 where zone_no = '4';
                     


CREATE TABLE `reservation` (
  `reservation_no` int(11) NOT NULL auto_increment,
  `product_no` int(3) NOT NULL
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
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

CREATE TABLE `reservation_day` (
  `reservation_month` varchar(6) default NULL, /*YYYYMM*/
  `reservation_day` varchar(8) default NULL,   /*YYYYMMDD*/
  `zone_name` varchar(20) default NULL,
  `site_no` int(3) default NULL,
  `reservation_no` int(11) default NULL,
  `pay_status` varchar(1) default NULL,
  `reg_date` date default NULL
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

CREATE TABLE `refund` (
  `refund_day_before` int(2) NOT NULL,
  `refund_type` varchar(1) NOT NULL,
  `refund_amount` int(7) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

INSERT INTO `refund` VALUES (7,'P',90);
INSERT INTO `refund` VALUES (5,'P',70);
INSERT INTO `refund` VALUES (3,'P',50);
INSERT INTO `refund` VALUES (1,'P',20);

CREATE TABLE `sms_manager` (
  `msg_no` int(5) NOT NULL,
  `dvsn` varchar(25) NOT NULL,
  `description` varchar(255) default NULL,
  `msg` varchar(1024) default NULL,
  PRIMARY KEY  (`msg_no`,`dvsn`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

INSERT INTO `sms_manager` VALUES (1,'user','예약완료(무통장입금)','어반슬로우시티 [DATE]에 [SITENAME]의 예약신청이 완료되었습니다');
INSERT INTO `sms_manager` VALUES (2,'user','입금안내 메시지(무통장입금)','어반슬로우시티 입금계좌안내 [BANK][ACCOUNT] [DEPOSITOR] [PRICE]원');
INSERT INTO `sms_manager` VALUES (3,'user','결제완료(무통장입금)','어반슬로우시티 [DATE]에 [SITENAME]의 입금 확인되었습니다. 감사합니다');
INSERT INTO `sms_manager` VALUES (4,'user','예약취소완료','어반슬로우시티 [DATE]에 [SITENAME]의 예약취소가 처리되었습니다');
INSERT INTO `sms_manager` VALUES (5,'user','환불완료','어반슬로우시티 [DATE]에 [SITENAME]의 취소하신 예약환불처리가 완료되었습니다');
INSERT INTO `sms_manager` VALUES (1,'admin','예약완료(무통장입금)','어반슬로우시티 [DATE]에 [SITENAME]의 예약신청이 접수되었습니다');
INSERT INTO `sms_manager` VALUES (2,'admin','입금안내 메시지(무통장입금)','');
INSERT INTO `sms_manager` VALUES (3,'admin','결제완료(무통장입금)','');
INSERT INTO `sms_manager` VALUES (4,'admin','예약취소완료','어반슬로우시티 [DATE]에 [SITENAME]의 예약이 취소되었습니다(환불없음)');
INSERT INTO `sms_manager` VALUES (5,'admin','예약취소(환불요청)','어반슬로우시티 [DATE]에 [SITENAME]의 예약취소/환불신청이 접수되었습니다');
INSERT INTO `sms_manager` VALUES (6,'admin','qna질문등록','어반슬로우시티 질문이 등록되었습니다. 답변달아주세요');

CREATE TABLE `sms_phone` (
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(25) default NULL,
  `dvsn` varchar(25) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`phone_number`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

INSERT INTO `sms_phone` VALUE ('01093167879','홍성규','manager','관리자');
INSERT INTO `sms_phone` VALUE ('01023182373','김예은','admin','운영자');

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
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

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
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

insert into member values(0,'admin','admin','A','관리자',20150518,0,'admin@urbanslowcity.com','n','041','000','0000','010','0000','0000','000-000','개옹개길108','개옹개길108',NOW());

CREATE TABLE `popup` (
  `popup_no` int(5) NOT NULL auto_increment,
  `popup_subject` varchar(255) NOT NULL,
  `popup_content` varchar(2000) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `use_yn` varchar(1) default 'N',
  PRIMARY KEY (`popup_no`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

insert into popup value(0,'입금자를 찾습니다.','7월 22일 최*원님',DATE_FORMAT('2015-06-01','%Y-%m-%d'),DATE_FORMAT('2024-12-31','%Y-%m-%d'),'Y');

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
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

CREATE TABLE `code` (
  `code_no` int(5) NOT NULL auto_increment,
  `code_group` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `code_name` varchar(48) NOT NULL,
  `code_seq` int(2) NOT NULL,
  `code_description` varchar(255) default NULL,
  PRIMARY KEY (`code_no`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

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
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

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

ALTER TABLE `urban`.`siteboard` 
ADD COLUMN `contents` MEDIUMTEXT NULL DEFAULT NULL AFTER `use_yn`;

/**
ALTER TABLE `urbanslowcity`.`product` 
CHANGE COLUMN `product_no` `product_no` INT(3) NOT NULL ,
ADD COLUMN `flat_price` INT(6) NULL DEFAULT NULL AFTER `product_memo`,
ADD COLUMN `flat_price_start_day` DATE NULL DEFAULT NULL AFTER `flat_price`,
ADD COLUMN `flat_price_end_day` DATE NULL DEFAULT NULL AFTER `flat_price_start_day`,
ADD COLUMN `productcol` VARCHAR(45) NULL AFTER `flat_price_end_day`;
update product set flat_price = '99000' , flat_price_start_day = '2016-03-01', flat_price_end_day = '2016-03-31';

ALTER TABLE `urbanslowcity`.`zone_information` 
ADD COLUMN `use_start_day` DATE NULL DEFAULT NULL AFTER `order_no`,
ADD COLUMN `use_end_day` DATE NULL DEFAULT NULL AFTER `use_start_day`;
update zone_information set use_start_day = '2015-06-01', use_end_day = '2024-12-31';
