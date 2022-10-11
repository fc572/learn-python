from functools import reduce

def add(*args):
    b = 0
    for a in args:
        print('args: ', a)
        b+=a
        print('AA', b)

def useReduce(*args):
    for a in args:
        print(reduce(a))