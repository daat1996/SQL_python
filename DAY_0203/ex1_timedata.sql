select cast('2019-09-17 15:30:00' as datetime);

select cast('2019-09-17' as date) date_field,
		cast('108:17:57' as time) time_field;
	
select cast('20190917153000' as datetime);

select str_to_date('September 17, 2019', '%M %d, %Y') as return_date;

select current_date(), current_time(), current_timestamp();

select date_add(current_date(), interval 5 day);


select dayname('1996-02-13');

select extract(day FROM '2019-09-18 22:19:05');

select datediff('2024-02-05','2023-12-25');

