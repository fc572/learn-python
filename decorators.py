def check_non_negative(index):
    def validator(f):
        def wrap(*args):
            if args[index] < 0:
                raise ValueError(
                    'Argument {} must be non negative'.format(args.index))
            return f(*args)
        return wrap
    return validator

@check_non_negative(0)
def create_list(value, size):
    return [value] * size

create_list('a', 45)


