show databases;
use sakila;
select now();

create database testdb;
use testdb;

# drop table if exists person;   # table 'person' 을 지워라

create table person
	(person_id smallint unsigned,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color ENUM('BR','BL', 'GR'),
	birth_date DATE,
	street VARCHAR(30),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(20),
	constraint pk_person primary key (person_id));		# ; 하나가 한 개의 명령으로 취급

desc person;

create table favorite_food
	(person_id smallint unsigned,
	food VARCHAR(20),
	constraint pk_favorite_food primary key (person_id, food),# 기본키를 2개 설정
	constraint fk_fav_food_person_id foreign key (person_id) references person(person_id)
	);

desc favorite_food ;		

set foreign_key_checks=0;	# 제약조건 비활성화
alter table person modify person_id smallint unsigned auto_increment;	# 테이블 수정(auto-increment)
set foreign_key_checks=1;	# 제약조건 활성화

desc person;


# 데이터 추가(INSERT INTO   VALUES)
insert into person
	(person_id, fname, lname, eye_color, birth_date)
	values (null, 'william', 'Turner', 'BR', '1972-05-27');		# person_id에는 auto-increment 추가해서 자동으로 설정됨

select * from person;		# select * 는 모든 데이터를 출력
# select ~~ where 은 조건문
select person_id, fname, lname, birth_date from person;
select person_id, fname, lname, birth_date
from person where lname = 'Turner';		# lname이 'Turner'인 데이터에서 person_id, fname, lname, birth_date 열만 출력

# favorite_food 테이블에 데이터 추가 
# 한번에 여러 행 추가
insert into favorite_food (person_id, food)
values (1, 'pizza'),
		(1, 'cookie'),
		(1, 'nachos');

# favorite_food 테이블 데이터 확인
# ORDER BY 컬럼이름: 컬럼의 값을 알파벳 순서로 정렬
select food from favorite_food
where person_id=1 order by food;


# person 테이블에 다른 데이터 추가
insert into person 
(person_id, fname, lname, eye_color, birth_date, 
street, city, state, country, postal_code)
values(null, 'Susan','Smith', 'BL', '1975-11-02',
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

select person_id, fname, lname, birth_date from person;	# person_id 필드에 자동으로 2가 저장됨


# 데이터 수정: update 문
update person 
set street = '1225 Tremon St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02138'
where person_id=1;

select * from person;

# 데이터 삭제 Delete 문
delete from person where person_id=2;	# where 절을 생략하면 테이블의 모든 데이터 삭제(데이터는 삭제 되지 않음)
select * from person;

-- insert into favorite_food (person_id,food) values (3, 'lasgna'); # 에러발생 : person_id=3 인 값이 person에 없음

insert into person 
(person_id, fname, lname, eye_color, birth_date, 
street, city, state, country, postal_code)
values(2, 'Susan','Smith', 'BL', '1975-11-02',
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');


select * from person;
insert into person (person_id,fname,lname) values(3, 'Kevin', 'Kern');
select * from person;

insert into favorite_food (person_id,food) values (3,'lasagna');
select *from favorite_food;

# 잘못된 날짜 변환 (날짜 표현 방식 변경)
# birth_date = 'Dec-21-1980' 로 변경 하기 위해
# 문자열을 format(형식 문자열)을 사용하여 Datetime 값으로 변환 후 반환
update person set birth_date =str_to_date('DEC-21-1980','%b-%d-%Y')
where person_id=1;

select * from person;
