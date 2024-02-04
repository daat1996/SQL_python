show databases;
# 1번
drop database shoppingmall;
create database shoppingmall;
use shoppingmall;
create table user_table
	(userID CHAR(8) not null primary key,
	userName VARCHAR(10) not null,
	birthYear int not null,
	addr CHAR(2) not null,
	mobile1 char(3),
	mobile2 char(8),
	height smallint,
	mDate DATE
	);

insert into user_table values
('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08');


create table buy_table
	(num INT auto_increment not null primary key,
	userID CHAR(8) not null,
	prodName CHAR(6) not null,
	groupName CHAR(4),
	price INT not null,
	amount smallint not null,
	foreign key (userID) references user_table(userID)
	);

insert into buy_table values
(1, 'KHD', '운동화', NULL, 30, 2),
(2, 'KHD', '노트북', '전자', 1000, 1),
(3, 'KYM', '모니터', '전자', 200, 1),
(4, 'PSH', '모니터', '전자', 200, 5),
(5, 'KHD', '청바지', '의류', 50, 3),
(6, 'PSH', '메모리', '전자', 80, 10),
(7, 'KJD', '책', '서적', 15, 5),
(8, 'LHJ', '책', '서적', 15, 2),
(9, 'LHJ', '청바지', '의류', 50, 1),
(10, 'PSH', '운동화', NULL, 30, 2),
(11, 'LHJ', '책', '서적', 15, 1),
(12, 'PSH', '운동화', NULL, 30, 2);


# 2번
# 2-1)
select ut.userName, bt.ProdName, ut.addr, concat(ut.mobile1,ut.mobile2)  as 연락처
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID ;

alter table user_table drop column mobile;
alter table user_table add column mobile char(13);
update user_table set mobile = concat(mobile1,mobile2);

# 2-2)
select u.userID, u.userName, bt.prodName, u.addr, concat(u.mobile1,u.mobile2)
from user_table as u inner join buy_table as bt
on u.userID = bt.userID
where u.userID = 'KYM';

# 2-3)
select bt.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1,ut.mobile2) as 연락
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
order by userID ;

# 2-4)
select distinct  bt.userID, ut.userName, ut.addr
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
order by userID;

# 2-5)
select bt.userID, ut.userName, ut.addr, concat(ut.mobile1,ut.mobile2) as 연락
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
where (ut.addr = '경북') or (ut.addr = '경남')
order by userID ;
