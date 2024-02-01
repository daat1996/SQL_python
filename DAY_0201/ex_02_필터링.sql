use sakila;

select c.email
from customer as c
	inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14';

select customer_id, rental_date
from rental
where rental_date <'2005-05-25';


#범위조건 - 해당 식이 특정 범위 내에 있는지 확인
select customer_id, rental_date
from rental
where rental_date <= '2005-06-16'
	and rental_date >= '2005-06-14';
# datetime 속성으로 6월 16일의 시간정보는 포함되지 않음

# 6월 16일 데이터를 포함하기 위해 date()함수 사용
select customer_id, rental_date
from rental
where date(rental_date) <= '2005-06-16'
	and date(rental_date) >= '2005-06-14';

# between 연산자 - between [범위의 하한값] and [범위의 상한값] 상,하한도 범위에 포함이 된다.(반드시! 앞에 하한값)
select customer_id, rental_date
from rental
where date(rental_date) between '2005-06-14' and '2005-06-16';


select customer_id, payment_date, amount
from payment
where amount between 10.0 and 11.99;

# 문자열 범위
select last_name, first_name
from customer
where last_name between 'FA' and 'FRB';
# last_name이 'FA'와 'FRB'로 시작되는 데이터 리턴


# in() 연산 - 컬럼명 in (값1, 값2 ,값3) : or 대신 사용한다.
select title, rating
from film
where rating in ('G','PG');


# 문자열 앞 뒤로 % 포함 : '%pet%' - pet을 포함하는 단어
select title, rating
from film
where rating in (select rating from film where title like '%PET%');# PET을 포함하는 영화의 rating과 같은 rating을 갖는 영화와 rating의 출력

select title, rating from film where title like '%PET%'; #pet 을 포함하는 영화의 제목, rating 리턴
# 2칸 위의 것은 이것과 같음
select title, rating
from film
where rating in ('G','PG');

# not in : 특정 조건이 아닌 것을 고를때 사용
select title, rating
from film
where rating not in ('PG-13','R','NC-17');


# 문자열 부분 가져오기
# left(문자열, n) : 문자열의 가장 왼쪽부터 n개 가져옴
# mid(문자열,시작위치, n) : 시작위치부터 n개 가져옴 		substr()도 동일한 기능 수행: 시작위치는 1부터 시작
# right(문자열, n) : 문자열의 가장 오른쪽 부터 n개 가져옴
# 와일드 카드 '-': 정확히 1문자, '%':개수에 상관없이 모든 문자 포함
# '_A_T%S' : 두 번째 위치에 ‘A’,	네 번째 위치에 ‘T’를 포함하며 마지막은 ‘S’로 끝나는 문자열

select last_name, first_name
from customer
where last_name like 'Q%' or last_name like 'Y%';


# 정규 표현식 사용
# '^[QY]' : Q 또는 Y로 시작하는 단어 검색

select last_name, first_name
from customer
where last_name regexp '^[QY]'	# regexp: 정규표현식


# is null: null 인것만
select rental_id, customer_id, return_date
from rental
where return_date is null;

select rental_id, customer_id, return_date
from rental
where return_date is not null;


# 2005년 5월에서 8월 사이에 반납되지 않은 대여 정보 검색
select rental_id, customer_id, return_date
from rental
where return_date is null	# 반납이 되지 않거나
or date(return_date) not between '2005-05-01' and '2005-08-31'; # 반납날이 5월~ 8월 사이가 아닌 경우

# 서브셋 조건 설정
select payment_id, customer_id, amount, date(payment_date) as payment_date
from payment
where (payment_id between 101 and 120);
