# 교차 조인(cross join) : join의 조건 없이 모든 행을 결합
# 		상품 테이블(n개) * 재고 테이블(m개) = 전체 n*m개

# 내부조인(inner join) : 가장 일반적인 join 유형
# 		일치하지 않는 데이터는 검색하지 않음
# 	select <열목록>
#	from <기준 테이블> inner join <참조할 테이블>
#	on <조인 조건>
#	where <검색 조건>

use sakila


select c.first_name, c.last_name, a.address 
from customer as c inner join address as a
on c.address_id = a.address_id ;

select count(*)
from customer as c inner join address as a
on c.address_id = a.address_id ;

select count(*)
from customer;


# 외부조인(outer join) : 한쪽 테이블에만 존재하는 데이터들을 다른 테이블에 결합하는 방식
# 	select <열목록>
#	from <첫번쨰 테이블>
#	on <조인 조건>
#	where <검색 조건>
#	조인 조건과 필터조건을 구분하기 어려움
#	-> on 절 안에 join 조건을 넣기로 결정
#	필터 조건:where 절

select c.first_name, c.last_name , a.address 
from customer as c join address as a
where c.address_id = a.address_id and a.postal_code = 52137;

select c.first_name, c.last_name , a.address 
from customer as c join address as a
on c.address_id = a.address_id 
where a.postal_code = 52137;

# city에서 key 칼럼의 MUL: 다른 테이블의 기본키를 참조하려는 외래키인 경우
select c.first_name, c.last_name , ct.city, a.address ,a.district, a.postal_code 
from customer as c
	inner join address as a
	on c.address_id=a.address_id
	inner join city as ct
	on a.city_id = ct.city_id ;


select c.first_name, c.last_name , addr.address, addr.city, addr.district
from customer as c 
	inner join
	(select a.address_id ,a.address, ct.city, a.district
	from address as a
		inner join city as ct
		on a.city_id = ct.city_id
	where a.district = 'California'
	) as addr
on c.address_id = addr.address_id;


select a.address_id, a.address , ct.city, a.district
from address as a
		inner join city ct
		on a.city_id =ct.city_id 
	where a.district ='California';
	

# 테이블 재사용
# 두 배우가 각각 출연한 영화 출력
select f.title, a.first_name, a.last_name
from film as f
	inner join film_actor as fa
	on f.film_id = fa.film_id 
	inner join actor as a
	on fa.actor_id = a.actor_id
where ((a.first_name = 'CATE' and a.last_name = 'MCQUEEN')
	or (a.first_name = 'CUBA' and a.last_name = 'BIRCH'));

# 두 배우가 같이 출연한 영화만 검색(2개의 분리된 쿼리)
	# CATE MCQUEEN만 검색
select f.title, a1. first_name , a1.last_name 
from film as f
	inner join film_actor as fa1
	on f.film_id = fa1.film_id 
	inner join actor as a1
	on fa1.actor_id =a1.actor_id 
where(a1.first_name = 'CATE' and a1.last_name = 'MCQUEEN');
	# CUBA BIRCH만 검색
select f.title, a1. first_name , a1.last_name 
from film as f
	inner join film_actor as fa2
	on f.film_id = fa2.film_id 
	inner join actor as a1
	on fa2.actor_id =a1.actor_id 
where(a1.first_name = 'CUBA' and a1.last_name = 'BIRCH');

# 둘을 합친다.	같은 테이블을 여러번 사용하기 때문에 테이블 별칭 사용
select f.title
from film as f
	inner join film_actor as fa1
	on f.film_id = fa1.film_id 
	inner join actor as a1
	on fa1.actor_id = a1.actor_id 
	inner join film_actor as fa2
	on f.film_id = fa2.film_id 
	inner join actor as a2
	on fa2.actor_id = a2.actor_id 
where(a1.first_name='CATE' and a1.last_name='MCQUEEN')
	and (a2.first_name='CUBA' and a2.last_name='BIRCH');



# 셀프 조인
use sqlclass_db;

create table customer
	(customer_id smallint unsigned,
	first_name varchar(20),
	last_name varchar(20),
	birth_date date,
	spouse_id smallint unsigned,
	constraint primary key (customer_id));
	
desc customer ;

insert into customer (customer_id, first_name, last_name, birth_date, spouse_id)
values
(1,'John','Mayer','1983-05-12', 2),
(2,	'Mary',	'Mayer','1990-07-30',1),
(3,	'Lisa',	'Ross','1989-04-15',5),
(4,	'Anna',	'Timothy','1988-12-26',6),
(5,	'Tim','Ross','1957-08-15',3),
(6,	'Steve','Donell','1967-07-09',4);

insert into customer (customer_id, first_name, last_name, birth_date)
values (7, 'Donna', 'Trapp', '1978-06-23');

select * from customer;

select cust.customer_id,
	cust.first_name,
	cust.last_name,
	cust.birth_date,
	cust.spouse_id,
	spouse.first_name as spouse_firstname,
	spouse.last_name as spouse_lastname
from customer as cust
	join customer as spouse
	on cust.spouse_id = spouse.customer_id;


use sakila;
select a1.address as addr1, a2.address as addr2, a1.city_id, a1.district
from address as a1
	inner join address as a2
where (a1.city_id = a2.city_id)	
	and(a1.address_id != a2.address_id);