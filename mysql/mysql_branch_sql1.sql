create database mydb;
use mydb;


select * from tb_numbers;

show tables;

alter table tb_calendar_data rename tb_calendar;

select cd_symd, cd_ly, cd_lm,cd_ld,cd_kk from tb_calendar where cd_ly>1962 and cd_lm=3 and cd_ld=24 order by cd_kk, cd_ly, cd_lm, cd_ld;
select * from tb_calendar where cd_ly>1962 and cd_lm=3 and cd_ld=24 order by cd_ly, cd_lm, cd_ld, cd_kk;

select a.cd_symd, a.cd_ly, a.cd_lm, a.cd_ld, b.* 
from tb_calendar a , tb_anniversary b 
where a.cd_no=b.cd_no;

select cd_no, cd_ly, cd_lm, cd_ld, cd_kk 
from tb_calendar 
where cd_ly>2098 and cd_kk='1' 
order by cd_kk, cd_lm, cd_ld;

select cd_no, cd_ly, cd_lm, cd_ld, cd_kk 
from tb_calendar 
where concat(cd_ly,'-',lpad(cd_lm,2,0)) in ('2090-08','2093-06','2096-04') and cd_kk='1' 
order by cd_kk, cd_lm, cd_ld;

select * from (
	select a.*, count(*) as cnt from (
		select concat(cd_ly,'-',lpad(cd_lm,2,0),'-',lpad(cd_lm,2,0)) as lymd from tb_calendar
	) a
	group by a.lymd
) b
where b.cnt>50;


select *, count(*) cnt from (select left(an_anniversary, 4) anni from tb_anniversary) a group by anni;

select a.*, b.an_no, b.an_anniversary, b.an_expr 
from tb_calendar a 
left join tb_anniversary b on a.cd_no=b.cd_no
where concat(cd_ly,'-',lpad(cd_lm,2,0),'-',lpad(cd_ld,2,0)) between '1963-03-24' and '2025-05-10' and cd_lm=3 and cd_ld=24;

select lpad(3,4,0) from dual;
select * from tmp_calendar_data where '2023-04-17'<cd_symd and cd_week='일';
select * from tmp_calendar_data where '2023-04-17'<cd_symd and cd_sd=18;
select * from tmp_calendar_data where '2023-04-17'<concat(cd_ly,'-',lpad(cd_lm,2,0),'-',lpad(cd_ld,2,0)) and cd_ld=18;

select * from tb_calendar where cd_ly>=2025 and cd_lm=4 and cd_ld=4;

create table if not exists tmp_calendar_data like tb_calendar;

select cd_no, cd_symd, cd_lun_plan, holiday from tb_calendar where cd_lun_plan like '설날%' or cd_lun_plan like '추석%';

select count(*) from tb_calendar where 6<length(cd_hmganjee);
select count(*) from tb_calendar where cd_kk='1';
select count(*) from tb_calendar where cd_hmganjee is null;

select * from tb_calendar where 10000<cd_no limit 1000;

update tb_calendar set holiday=2 where cd_no in (select no from temp);

insert into temp select cd_no from tb_calendar where cd_lun_plan in ('설날', '추석') and holiday<>2;

create table temp (
  no int4
);

select cd_no from tb_calendar where cd_lun_plan in ('설날', '추석') and holiday<>2;
select cd_no from tb_calendar where cd_lun_plan in ('설날', '추석');

update tb_calendar set cd_symd=concat(cd_sy,'-', lpad(cd_sm, 2, 0), '-', lpad(cd_sd, 2, 0)) where cd_no<100000;

select concat(cd_sy,'-', lpad(cd_sm, 2, 0), '-', lpad(cd_sd, 2, 0)) from tb_calendar where cd_no=1;

alter table tb_calendar add cd_symd varchar(10) comment '양력 년월일' after cd_sgi;
desc tb_calendar;

alter table tb_calendar add unique uni_symd (cd_sy, cd_sm, cd_sd);
alter table tb_calendar drop index idx_lymd;
alter table tb_calendar add index idx_lymd (cd_ly, cd_lm, cd_ld, cd_kk);
alter table tb_calendar add index idx_lmd (cd_lm, cd_ld, cd_kk);
alter table tb_calendar add index idx_symd (cd_sy, cd_sm, cd_sd);
alter table tb_calendar add index idx_smd (cd_sm, cd_sd);
alter table tb_calendar add index idx_sd (cd_sd);

alter table tb_calendar add cd_kmganjee varchar(6) default NULL comment '월 한문 간지' after cd_kyganjee;
alter table tb_calendar add cd_hmganjee varchar(6) default NULL comment '월 한문 간지' after cd_kyganjee;
alter table tb_calendar change cd_hmganjee cd_hdganjee varchar(6) default NULL comment '일 한문 간지';
alter table tb_calendar change cd_kmganjee cd_kdganjee varchar(6) default NULL comment '월 한글 간지';

drop table tb_anniversary;
CREATE TABLE tb_anniversary (
  an_no int4 unsigned NOT NULL auto_increment comment 'sequence',
  cd_no int4 unsigned NOT NULL comment '달력 sequence',
  an_anniversary varchar(64) not null comment '기념일',
  an_expr varchar(128) comment '기타 설명',
  PRIMARY KEY  (an_no),
  index idx_cd_no (cd_no)
);

DROP TABLE IF EXISTS `tb_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_calendar` (
  `cd_no` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'sequence',
  `cd_sgi` smallint unsigned NOT NULL DEFAULT '0' COMMENT '단기년도',
  `cd_symd` varchar(10) DEFAULT NULL COMMENT '양력 년월일',
  `cd_sy` smallint unsigned NOT NULL DEFAULT '0' COMMENT '양력 년',
  `cd_sm` enum('1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL DEFAULT '1' COMMENT '양력 월',
  `cd_sd` enum('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31') NOT NULL DEFAULT '1' COMMENT '양력 일',
  `cd_ly` smallint unsigned NOT NULL DEFAULT '0' COMMENT '음력 년',
  `cd_lm` enum('1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL DEFAULT '1' COMMENT '음력 월',
  `cd_ld` enum('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30') NOT NULL DEFAULT '1' COMMENT '음력 일',
  `cd_hyganjee` varchar(6) DEFAULT NULL COMMENT '년 한문 간지',
  `cd_kyganjee` varchar(6) DEFAULT NULL COMMENT '년 한글 간지',
  `cd_hmganjee` varchar(6) DEFAULT NULL COMMENT '월 한문 간지',
  `cd_kmganjee` varchar(6) DEFAULT NULL COMMENT '월 한문 간지',
  `cd_hdganjee` varchar(6) DEFAULT NULL COMMENT '일 한문 간지',
  `cd_kdganjee` varchar(6) DEFAULT NULL COMMENT '월 한글 간지',
  `cd_hterms` varchar(6) DEFAULT NULL COMMENT '한문 절기',
  `cd_kterms` varchar(6) DEFAULT NULL COMMENT '한글 절기',
  `cd_week` char(3) DEFAULT NULL COMMENT '요일(일월화수목금토)',
  `cd_sol_plan` varchar(50) DEFAULT NULL COMMENT '양력 행사(국경일/기념일 등)',
  `cd_lun_plan` varchar(50) DEFAULT NULL COMMENT '음력 행사(절/한식 등)',
  `cd_dogday` varchar(6) DEFAULT NULL COMMENT '복날(초복/중복/말복)',
  `cd_ddi` enum('쥐','소','호랑이','토끼','용','뱀','말','양','원숭이','닭','개','돼지') NOT NULL DEFAULT '쥐' COMMENT '띠(쥐/소/...)',
  `cd_kk` char(1) DEFAULT '0' COMMENT '윤달(1:윤당,0:평달)',
  `holiday` char(1) DEFAULT '0' COMMENT '기념일(1:국경일,2:법정공휴일,3:국가기념일,4:기타 기념일,5:음력절)',
  PRIMARY KEY (`cd_no`),
  UNIQUE KEY `uni_symd` (`cd_sy`,`cd_sm`,`cd_sd`),
  KEY `idx_lymd` (`cd_ly`,`cd_lm`,`cd_ld`,`cd_kk`),
  KEY `idx_lmd` (`cd_lm`,`cd_ld`,`cd_kk`),
  KEY `idx_smd` (`cd_sm`,`cd_sd`),
  KEY `idx_sd` (`cd_sd`),
  KEY `idx_symd` (`cd_sy`,`cd_sm`,`cd_sd`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select sysdate(), curdate(), current_date() from dual;


DROP TABLE IF EXISTS `tb_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_numbers` (
  `round` int2(5) NOT NULL DEFAULT 0 COMMENT 'round',
  `lt_date` varchar(10) NOT NULL COMMENT 'lotted date',
  `n1` int2 NOT NULL COMMENT 'number 1',
  `n2` int2 NOT NULL COMMENT 'number 2',
  `n3` int2 NOT NULL COMMENT 'number 3',
  `n4` int2 NOT NULL COMMENT 'number 4',
  `n5` int2 NOT NULL COMMENT 'number 5',
  `n6` int2 NOT NULL COMMENT 'number 6',
  `bonus` int2 NOT NULL COMMENT 'bonus number',
  `total` int2(3) unsigned COMMENT 'sum of numbers',
  `ac` int2(2) unsigned COMMENT 'ac value',
  `L05` int2(1) unsigned COMMENT 'last 05 count',
  `L10` int2(1) unsigned COMMENT 'last 10 count',
  `n1_count` int2(5) unsigned COMMENT 'first rank count',
  `n1_amount` int8(13) unsigned COMMENT 'first rank amount',
  `n2_count` int2(5) unsigned COMMENT 'second rank count',
  `n2_amount` int4(11) unsigned COMMENT 'second rank amount',
  `n3_count` int2(5) unsigned COMMENT 'third rank count',
  `n3_amount` int4(11) unsigned COMMENT 'third rank amount',
  `n4_count` int4(8) unsigned COMMENT 'fourth rank count',
  `n4_amount` int4(6) unsigned COMMENT 'fourth rank amount',
  `n5_count` int4(8) unsigned COMMENT 'fifth rank count',
  `n5_amount` int2(5) unsigned COMMENT 'fifth rank amount',
  `n1_auto` int2(2) unsigned COMMENT 'first rank auto count',
  `n1_manu` int2(2) unsigned COMMENT 'first rank manu count',
  `n1_half` int2(2) unsigned COMMENT 'first rank half count',
  PRIMARY KEY (`round`),
  UNIQUE KEY `lt_date_UNIQUE` (`lt_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='lotto numbers';


select left(now(),10) from dual;

create database lotto;

create database testDB;

drop database test;

show databases;

use testDB;

create table test (
  id int(4) auto_increment primary key comment 'index',
  name varchar(20) not null comment 'name'
);
show tables;
alter table test add regtime timestamp comment '등록시간';
alter table test add regdt date comment '등록일자';
alter table test add regdttime datetime comment '등록시간';
alter table test add seq long comment 'sequence' after id;
alter table test modify seq int(11) comment 'sequence';
desc test;

insert into test values (0,'name2','expr2'),(0,'name3','expr3');

insert into test value (0,'이름','설명');

select * from test;

update test set regtime='12:12:15', regdt=left(now(),10), regdttime=now() where id=1;
update test set regtime='2025-04-13 12:12:15', regdt=left(now(),10), regdttime=now() where id=2;
update test set regtime='2025-04-13 12:12:15', regdt=left(now(),10), regdttime=now() where id=3;
update test set regtime='2025-04-13 12:12:15', regdt=left(now(),10), regdttime=now() where id=4;
update test set seq=12345 where id<5;