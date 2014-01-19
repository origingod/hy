import inspect
import functools


def curry(fn):
    sig = inspect.signature(fn)
    count = len(sig.parameters)  # Arg count.
    def _(*args):
        if len(args) < count:
            return functools.partial(curry(fn), *args)
        return fn(*args)
    return _
