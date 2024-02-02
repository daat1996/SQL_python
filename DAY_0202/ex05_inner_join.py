import pymysql

conn = pymysql.connect(host='localhost', user='root',
                       password='1234',
                       db='sakila', charset='utf8')

# (%s) : 변수, 실제 쿼리와 동일한 문자열 전달

cur = conn.cursor()
query = """
select c.email
from customer as c
    inner join rental as r
    on c.customer_id = r.customer_id
where date(r.rental_date) = (%s)    
"""
cur.execute(query, ('2005-06-14'))  # %s에 '2005-06-14'가 들어감
rows = cur.fetchall()   # 모든 데이터를 가져옴
for row in rows:
    print(row)

cur.close()
conn.close()