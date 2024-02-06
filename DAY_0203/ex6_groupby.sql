use sakila;

select customer_id, count(*)
from rental
group by customer_id
order by 2 desc;		#order by에 인덱스 사용

select customer_id, count(*)
from rental
group by customer_id
order by count(*) desc;		#order by에 컬럼이름 사용

# where 절다음에 group by 연산이 수행 불가능(집계함수 count(*) 사용불가)
select customer_id, count(*)
from rental
group by customer_id 
having count(*) >= 40;		# group 다음에 having 절 사용


#집계함수
# group by를 사용하지 않더라도 집계된다.
select max(amount) as max_amt,
	min(amount) as min_amt,
	avg(amount) as avg_amt,
	sum(amount) as tot_amt,
	count(*) as num_payments
from payment;

# 집계함수를 사용할때 그룹화하지 않은 일반 컬럼이 같이 들어가면 에러 발생
# 같이 써야할때는 group by 절에 그룹화할 열의 이름 지정

select customer_id,
	max(amount) as max_amt,
	min(amount) as min_amt,
	avg(amount) as avg_amt,
	sum(amount) as tot_amt,
	count(*) as num_payments
from payment
group by customer_id;


use sqlclass_db;
create table number_tbl (val smallint);


use sakila;

select actor_id , count(*)
from film_actor
group by actor_id;

# 하나 이상의 열을 이용해서 그룹생성

select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id 
group by fa.actor_id , f.rating 
order by  1, 2;


select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id
group by fa.actor_id, f.rating with rollup 
order by 1, 2;


# 두가지 필터 조건 사용
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id 
where f.rating in ('G','PG')
group by fa.actor_id, f.rating
having count(*) > 9;

