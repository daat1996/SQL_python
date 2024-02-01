use sakila;

select * from `language`;

select language_id, name, last_update from `language`;

select name from `language` ;


# select절에 추가할 수 있는 항목
select language_id,			# 원래 language 테이블에는 없는 칼럼(가상컬럼)
	'COMMON' language_usage,
	language_id * 3.14 lang_pi_value,
	upper(name) language_name
from `language` ;
# 열의 별칭 - as 키워드를 사용하여 열의 별칭을 지정할 수 있음


select actor_id from film_actor order by actor_id ;		# 동일한 배우가 여러 영화에 출현: 중복된 actor_id 발생
# distinct 키워드 : 중복 제거
select distinct actor_id from film_actor fa order by actor_id ;


# From 절 역할 - 쿼리에 사용되는 테이블 명시, 테이블을 연결하는 수단
select concat(cust.last_name, ',', cust.first_name) full_name
from (select first_name, last_name, email	 # from 아래의 절 :서브쿼리-파생 테이블
		from customer		
		where first_name = 'JESSIE') as cust;

# 임시테이블
# 데이터베이스 세션이 닫힐때 사라짐
create temporary table actors_j		# 임시테이블 (actors_j)생성
	(actor_id smallint(5),
	first_name varchar(45),
	last_name varchar(45));
desc actors_j;	

insert into actors_j
	select actor_id, first_name, last_name
	from actor where last_name like 'J%';	# actor 테이블에서 'J'로 시작하는 데이터를 찾아서 actors_j 임시 테이블에 저장
# '%J' : J로 끝나는 데이터
select * from actors_j;


# 가상 테이블 (view)
# 쿼리의 결과셋을 기반으로 만들어진 가상 테이블
# 복잡한 쿼리문을 매번 사용하지 않고 가상 테이블로 만들어서 쉽게 접근함

create view cust_vw as
	select customer_id, first_name, last_name, active
	from customer c ;

select * from cust_vw cv


select first_name, last_name from cust_vw cv 
where active=0;

# drop view cust_vw;

# 테이블 연결
# join(inner join) 두 개 이상의 테이블을 묶어서 하나의 결과 집합을 만들어 내는 것
select customer.first_name, customer.last_name,
	time(rental.rental_date) as rental_time
	from customer inner join rental
	on customer.customer_id = rental.customer_id 
where date(rental.rental_date) = '2005-06-14';


# date() 함수 => datetime데이터에서 date 만 추출
# time() 함수 => time 정보만 추출


select customer.first_name, customer.last_name,
	time(rental.rental_date) rental_date
from customer inner join rental
	on customer.customer_id = rental.customer_id 
where date(rental.rental_date) = '2005-06-14';



select c.first_name, c.last_name,
	time(r.rental_date) as rental_date
from customer as c inner join rental as  r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14';



select title
from film
where rating='G' and rental_duration >= 7;

select title, rating, rental_duration
from film
where(rating='G' and rental_duration >= 7)
	or (rating='PG-13' and rental_duration <4);


# group by - 컬럼의 데이터를 그룹화
# 그룹화 한 후에는 where 보다 having을 쓴다
select c.first_name, c.last_name, count(*)	# count(*): 그룹화 한 전체 행의 수
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
group by c.first_name, c.last_name
having count(*) >= 40;


# order by 절 : 컬럼을 기준으로 결과를 정렬 ( 다중컬럼의 경우, 왼쪽부터 정렬)
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by c.last_name, c.first_name asc;	# 영화고객의 last_name을 기준으로 정렬(같다면 firstname으로 정렬)


# 순서를 통한 정렬 - 컬럼의 순서(index)를 사용하여 정렬
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c
 inner join rental as r
 on c.customer_id = r.customer_id 
 where date(r.rental_date) = '2005-06-14'
 order by 1 desc;

# 연습문제 1
select actor_id, first_name,last_name	
from actor order by last_name , first_name ;


select actor_id, first_name,last_name
from actor 
where last_name ='WILLIAMS' or last_name ='DAVIS';


select customer_id
from rental
where date(return_date ) = '2005-07-05';


select store_id, email, rental_date, return_date
from customer as c inner join rental as r
on c.customer_id  = r.customer_id 
where date(r.rental_date)='2005-06-14'
order by r.return_date desc;
 

