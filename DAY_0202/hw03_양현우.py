'''
    SQL 과제 #3
'''


import pymysql
import pandas as pd

def main():
    # 데이터베이스(sqlclass_db) 연결
    conn = pymysql.connect(host='localhost', user='root',
                       password='1234',
                       db='shoppingmall', charset='utf8')
    # cursor 객체 생성
    cur = conn.cursor()

    # 테이블 생성 함수 호출
    select_2_1(cur)
    select_2_2(cur)
    select_2_3(cur)
    select_2_4(cur)
    select_2_5(cur)

    # 연결 종료
    cur.close()
    conn.close()
    print('Database 연결 종료')


def header_make(cur):
    header = [x[0] for x in cur.description]
    for a in header:
        print(f'{a:11}', end='')
    print()
    print('-' * 50)
    rows = cur.fetchall()
    for row in rows:
        print(row)
    print()

def select_2_1(cur):    # try, except - 함수에서 예외가 발생할때 except로 실행된다.
    try:
        print('문제 1번')
        print('-'*50)
        query1 = '''
            select ut.userName, bt.ProdName, ut.addr, concat(ut.mobile1,ut.mobile2)  as 연락처
            from user_table as ut inner join buy_table as bt
            on ut.userID = bt.userID
                '''
        cur.execute(query1)
        header_make(cur)

    except Exception as e:
        print(e)


def select_2_2(cur):
    try:
        print('문제 2번')
        print('-'*50)
        query2 = '''
            select u.userID, u.userName, bt.prodName, u.addr, concat(u.mobile1,u.mobile2) as 연락처
            from user_table as u inner join buy_table as bt
            on u.userID = bt.userID
            where u.userID = 'KYM'
                '''
        cur.execute(query2)
        header_make(cur)

    except Exception as e:
        print(e)


def select_2_3(cur):
    try:
        print('문제 3번')
        print('-'*50)
        query3 = '''
            select bt.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1,ut.mobile2) as 연락처
            from user_table as ut inner join buy_table as bt
            on ut.userID = bt.userID
            order by userID
                '''
        cur.execute(query3)
        header_make(cur)

    except Exception as e:
        print(e)


def select_2_4(cur):
    try:
        print('문제 4번')
        print('-'*50)
        query4 = '''
            select distinct  bt.userID, ut.userName, ut.addr
            from user_table as ut inner join buy_table as bt
            on ut.userID = bt.userID
            order by userID
                '''
        cur.execute(query4)
        header_make(cur)

    except Exception as e:
        print(e)


def select_2_5(cur):
    try:
        print('문제 5번')
        print('-'*50)
        query5 = '''
            select bt.userID, ut.userName, ut.addr, concat(ut.mobile1,ut.mobile2) as 연락처
            from user_table as ut inner join buy_table as bt
            on ut.userID = bt.userID
            where (ut.addr = '경북') or (ut.addr = '경남')
            order by userID
                '''
        cur.execute(query5)
        header_make(cur)

    except Exception as e:
        print(e)


main()
