# 집합 이론
# 합집합 = union
# 교집합 = intersect
# 차집합 = except

select 1 as num, 'abc' as str
union
select 9 as num, 'xyz' as str;

# union- 중복 제거
# union all - 중복되는 모든 값을 보여줌

use sakila;

select c.first_name, c.last_name
from customer c 
where c.first_name like 'J%' and c.last_name like 'D%'
union all
select a.first_name, a.last_name
from actor a 
where a.first_name like 'J%' and a.last_name like 'D%';


select c.first_name, c.last_name
from customer c 
where c.first_name like 'J%' and c.last_name like 'D%'
union
select a.first_name, a.last_name
from actor a 
where a.first_name like 'J%' and a.last_name like 'D%';


select c.first_name, c.last_name
from customer c 
where c.first_name like 'J%' and  c.last_name like 'D%'
intersect 
select a.first_name, a.last_name
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%';


select c.first_name, c.last_name
from customer c 
	inner join actor as a
	on(c.first_name = a.first_name) and (c.last_name = a.last_name)
where a.first_name like 'J%' and a.last_name like 'D%';


# 차집합 except
select first_name, last_name
from actor a 
where last_name  like 'L%'
union
select first_name , last_name 
from customer c 
where last_name like 'L%'
order by last_name ;