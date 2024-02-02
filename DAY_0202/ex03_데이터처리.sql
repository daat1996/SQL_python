# char 고정길이 문자열 자료형
#		지정한 크기보다 문자열이 작으면 나머지 공간을 공백으로 채움(MySQL 255글자)
# varchar: 가변길이 문자열 자료형
#			크기만큼 데이터가 들어오지 않으면 그 크기에 맞춰 공간 할당
# text: 매우 큰 가변길이 문자열 자료형

use testdb;

create table string_tbl
(char_fld CHAR(30),
vchar_fld varchar(30),
text_fld text
);

insert into  string_tbl (char_fld, vchar_fld, text_fld) 
values('This is char data',
		'This is varchar data',
		'This is text data'
);


select * from string_tbl ;

update string_tbl
set vchar_fld = 'This is a piece of extremely long varchar data';	# 너무 길어서 안 들어간다는 말
DELETE FROM string_tbl;

select @@session.sql_mode;


# 문자열 내부에 작은 따옴표를 포함하는 경우(작은 따옴표를 하나 더 추가)
update string_tbl 
text text_fld = 'This string didn''t work, but it does now';

update string_tbl 
set text_fld = 'This string didn\'t work, but it does now';

select text_fld from string_tbl;

# quote() 내장함수 전체 문자열을 따옴표로 묶고 문자열 내부의 작은 따옴표에 escape문자를 추가
select quote(text_fld)
from string_tbl;

select length(char_fld) as char_length,
	length(vchar_fld) as varchar_length,
	length(text_fld) as text_length
from string_tbl;


# MySQL은 index가 1부터 시작한다!!(파이썬과는 다름)
# position() - 부분 문자열의 시작위치를 반환
# 				부분 문자열을 찾을 수 없는 겨우, 0을 반환함
# locate('문자열', 열이름, 시작위치) - 시작위치부터 문자열 검색: 처음 발견되는 인덱스 리턴

select position('piece' in vchar_fld), vchar_fld
from string_tbl;


# strcmp('문자열1','문자열2') 함수 비교: 문자열 비교
# 대소문자 구분 안 함
# 문자열1 > 문자열 2 -> +1
# 문자열1 < 문자열 2 -> -1
delete from string_tbl ;	# table은 그대로 두고 내용물 지우는 것
insert into string_tbl (vchar_fld)
values('abcd'),
		('xyz'),
		('QRSTUV'),
		('qrstuv'),
		('12345');
select vchar_fld from string_tbl st order by vchar_fld ;


select strcmp('12345', '12345')  12345_12345,
		strcmp('abcd','xyz') abcd_xyz,
		strcmp('abcd', 'QRSTUV') abcd_Qustuv, 	#대소별 문자 구분 안함
		strcmp('qrstuv', 'QROSTUV') qurstuv_orstuv,
		strcmp('12345','xyz') 12345_xyz,
		strcmp('xyz','qrstuv') xyz_qrstuv;
		
select strcmp('text2', 'text1'),
		strcmp('text', 'text1'),
		strcmp('text', 'text0');	# null 은 1보다 앞이기 때문


# select 절에 like 연산자나 regexp 연산자를 사용
# 0또는 1의 값을 반환
use sakila;

select name, name like '%y' as ends_in_y	# 끝이 y로 끝나면 1 아니면 0
from category;

select name, name regexp 'y$' as ends_in_y		# 'y$':name 컬럼 값이 'y'로 끝나면 1 반환
from category;


use testdb;

delete  from string_tbl;

insert into string_tbl (text_fld)
values ('This string was 29 characters');

select * from string_tbl st;

# concat() : 문자열 추가 함수 - 기존 문자열에 다른 문자열 추가
update string_tbl 
set text_fld  = concat(text_fld, ', but not it is longer'); # 끝에 이 문자열이 추가되었다.

# concat()함수 내부에서 date(create_date)를 문자열로 변환
use sakila;
select concat(first_name, ' ', last_name,
' has been a customer since ', date(create_date)) as cust_narrative
from customer;

# insert()함수 
# 4개의 인수로 구성 
# insert(문자열, 시작위치, 길이, 새로운 문자열) # 세 번쨰 인수값(길이)=0 이면 새로운 문자열이 삽입
select insert('goodbye world', 9, 0, 'cruel ')

# 세번째 인수값>0 : 해당 문자열로 대치   세번째 인수값은 대체할 문자열의 길이
select insert('goodbye world', 1, 7, 'hello')


# replace() 함수
# replace(문자열, 기존문자열, 새로운 문자열)
# 기존 문자열을 찾아서 제거하고, 새로운 문자열을 삽입
select replace('goodbye world', 'goodbye', 'hello') as replace_str;

# substr() 또는 substring() 함수
# substr(문자열, 시작위치, 개수)
# 문자열 시작위치에서 개수만큼 추출
select substr('goodbye cruel world', 9, 5);