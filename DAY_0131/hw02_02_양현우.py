'''
    딕셔너리 생성 및 정렬 프로그램
'''
def menu():
    print('-' * 41)
    print('1. 전체 데이터 출력')
    print('2. 수도 이름 오름차순 출력')
    print('3. 모든 도시의 인구수 내림차순 출력')
    print('4. 특정 도시의 정보 출력')
    print('5. 대륙별 인구수 계산 및 출력')
    print('6. 프로그램 종료')
    print('-' * 41)


def print_dict(dictionary):
    n = 1
    for a,b in dictionary.items():
        print(f'[{n}] {a}: {b}')
        n += 1


def print_capital(dictionary):
    n = 1
    capital =[]
    for a,b in dictionary.items():
        capital.append(a)
    capital.sort()
    for k in capital:
        print(f'[{n}] {k:11}: {dictionary[k][0]:15}'
              f'{dictionary[k][1]:7}{dictionary[k][2]:>13,}')
        n += 1


def print_population(dictionary):
    n = 1
    population = []
    dict2 = {}
    for a, b in dictionary.items():
        dict2[b[2]] = a
    keys = sorted(dict2.keys(), reverse=True)
    for k in keys:
        print(f'[{n}] {dict2[k]:11} : {k:>13,}')
        n += 1


def find_city(dictionary):
    city = input('출력할 도시 이름을 입력하세요: ')
    if city in dictionary:
        print(f'도시:{city}')
        print(f'국가:{dictionary[city][0]}, 대륙:{dictionary[city][1]}, '
              f'인구수:{dictionary[city][2]:,}')
    else:
        print(f'도시이름: {city}은 key에 없습니다.')


def find_continent(dictionary):
    continent = input('대륙 이름을 입력하세요(Asia, Europe, America): ')
    numb=0
    for k, v in dictionary.items():
        if continent in v:
            print(f'{k}: {v[2]:,}')
            numb += v[2]
    print(f'{continent} 전체 인구수: {numb:,}')

dict1 = {'Seoul':['South Korea', 'Asia', 9655000], 'Tokyo':['Japan', 'Asia', 14110000],
         'Beijing':['China', 'Asia', 21540000], 'London':['United Kingdom', 'Europe',14800000],
         'Berlin':['Germany','Europe',3426000], 'Mexico City':['Mexico', 'America', 21200000]}

dict1.values()

while True:
    menu()
    num = input('메뉴를 입력하세요: ')
    if num == '1':
        print_dict(dict1)
    elif num == '2':
        print_capital(dict1)
    elif num == '3':
        print_population(dict1)
    elif num == '4':
        find_city(dict1)
    elif num == '5':
        find_continent(dict1)
    elif num == '6':
        print('프로그램을 종료합니다.')
        break
    else:
        print('해당되는 메뉴는 없습니다.')


