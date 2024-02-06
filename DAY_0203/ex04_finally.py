'''
    finally - 예외 발생 여부 관계없이 항상 수행(주로 파일을 닫는 경우)
'''

def calc(values):
    sum= None
    try:
        sum = values[0] + values[1], values[2]
    except IndexError as err:
        print('인덱스 에러: ', err)
    except Exception as err:        # 예외 처리에도 순서가 중요하다!! 상위개념이 아래로 내려간다.
        print(err)
    else:
        print('에러 없음', values)
    finally:
        print(f'sum={sum}')

calc([1,2,3])
calc([1,2])