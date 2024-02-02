'''
    조회과정
    cursor 생성 : 데이터가 저장될 공간을 만듦
    fetchall() - 데이터를 다 갖고옴
    fetchone() - 1줄만 들고옴
    fetchmany(n) - n개 만큼 들고옴
'''

'''
    추가, 수정, 삭제 방법
    
    가져 오는것 까지는 같으나
    변경상황을 저장하기위해
    commit()이 필요하다.
'''

# Connection.cursor() 함수
#       - cursor 객체 생성
#       - cursor: 쿼리문에 의해 반환되는 결과값을 저장하는 공간

# cursor.execute('쿼리문장', args=None)함수
#     - 작성한 쿼리를 실행

# cursor.executemany('쿼리문장', 튜플데이터)
#     - 한 번에 여러 개의 데이터(튜플데이터) 처리



# Connection.commit() 함수
#     - 데이터를 추가, 수정, 삭제 등의 작업을 수행한 다음에 실행

# cursor.close() 함수

import pymysql
import pandas as pd

conn = pymysql.connect(host='localhost', user='root',
                       password='1234',
                       db='sakila', charset='utf8')     # MySQL에 연결

cur = conn.cursor()     # cursor 객체 생성
cur.execute('select * from language')
rows = cur.fetchall()   # 모든 데이터를 가져옴
print(rows)
language_df = pd.DataFrame(rows)    # DataFrame 형태로 변환
print(language_df)

cur.close()     # 실행할때 열고 모든게 다끝나고 닫는다.
conn.close()    # 데이터베이스 연결 종료


