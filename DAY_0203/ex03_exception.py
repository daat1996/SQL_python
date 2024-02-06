(x,y) = (2,0)

try:
    z = x/y
except ZeroDivisionError as e:  # e는 발생 예외에 대한 정보를 가지고 있음
    print(e)


while True:
    try:
        n= input("숫자를 입력하세요: ")
        n=int(n)
        break
    except Exception as e:  # 최상위 에러 키
        print('정수가 아닙니다:',e)
print('정수 입력이 성공하였습니다!')