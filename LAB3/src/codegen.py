import builtins
import keyword
from tree import Node, CompileError

PRELUDE = '''\
def tdiv(a, b):
    q = abs(a) // abs(b)
    return q if (a < 0) == (b < 0) else -q


def tmod(a, b):
    return a - b * tdiv(a, b)


def out(*args):
    for a in args:
        if isinstance(a, bool):
            a = int(a)
        elif isinstance(a, float):
            a = '%g' % a
        print(a, end='')
'''

DEFAULTS = {'int': '0', 'double': '0.0', 'bool': 'False'}
PYOPS = {'&&': 'and', '||': 'or'}
CMP = ('==', '!=', '<', '<=', '>', '>=', '&&', '||')


# print, len, out ... would shadow python / prelude names
RESERVED = set(dir(builtins)) | {'tdiv', 'tmod', 'out'}


def pyname(name):
    return name + '_' if keyword.iskeyword(name) or name in RESERVED else name


class Gen:
    def __init__(self, prog):
        self.lines = []
        self.depth = 0
        self.scopes = [{}]   # name -> (type, python name)
        self.steps = []      # for-loop steps, continue has to run them
        self.funcs = {f.value[1]: f.value[0] for f in prog.kids if f.kind == 'Func'}
        self.globals = set()
        for item in prog.kids:
            self.stmt(item)
        self.emit('')
        self.emit('')
        self.emit("if __name__ == '__main__':")
        self.emit('    main()')

    def emit(self, line):
        self.lines.append('    ' * self.depth + line if line else '')

    def suite(self, n, tail=None):
        self.depth += 1
        start = len(self.lines)
        self.stmt(n)
        self.stmt(tail)
        if len(self.lines) == start:
            self.emit('pass')
        self.depth -= 1

    def lookup(self, name, line):
        for s in reversed(self.scopes):
            if name in s:
                return s[name]
        raise CompileError(f'line {line}: {name} is not declared')

    # python has no block scope, so a shadowing variable gets a new name
    def declare(self, name, typ):
        py = pyname(name)
        if len(self.scopes) > 1 and any(name in s for s in self.scopes[:-1]):
            py += f'_{len(self.scopes)}'
        self.scopes[-1][name] = (typ, py)
        if len(self.scopes) == 1:
            self.globals.add(py)
        return py

    # static type, needed for int / double division of an expression
    def typ(self, n):
        k = n.kind
        if k == 'Num':
            return 'int' if isinstance(n.value, int) else 'double'
        if k == 'Bool' or (k == 'BinOp' and n.value in CMP) or (k == 'UnOp' and n.value == '!'):
            return 'bool'
        if k == 'Str':
            return 'str'
        if k in ('Id', 'Index'):
            return self.lookup(n.value, n.line)[0]
        if k == 'Call':
            return self.funcs.get(n.value, 'int')
        if k == 'BinOp':
            return 'double' if 'double' in (self.typ(n.kids[0]), self.typ(n.kids[1])) else 'int'
        if k == 'UnOp':
            return 'double' if self.typ(n.kids[0]) == 'double' else 'int'
        return self.typ(n.kids[0])  # Assign, PreOp, PostOp

    def coerce(self, typ, n):
        e = self.expr(n)
        if typ == 'int' and self.typ(n) == 'double':
            return f'int({e})'
        if typ == 'bool' and self.typ(n) != 'bool':
            return f'bool({e})'
        if typ == 'double' and n.kind == 'Num':
            return repr(float(n.value))
        return e

    # statements

    def stmt(self, n):
        if n is None:
            return
        h = getattr(self, 's_' + n.kind, None)
        if h:
            h(n)
        else:
            self.emit(self.expr(n))

    def s_Func(self, n):
        typ, name = n.value
        params, body = n.kids
        names = [p.value[1] for p in params.kids]
        self.emit('')
        self.emit('')
        self.emit(f"def {pyname(name)}({', '.join(map(pyname, names))}):")
        used = self.globals - set(map(pyname, names))
        if used:
            self.emit(f"    global {', '.join(sorted(used))}")
        self.scopes.append({p.value[1]: (p.value[0], pyname(p.value[1])) for p in params.kids})
        self.suite(body)
        self.scopes.pop()

    def s_Block(self, n):
        self.scopes.append({})
        for k in n.kids:
            self.stmt(k)
        self.scopes.pop()

    def s_Decls(self, n):
        for k in n.kids:
            self.stmt(k)

    def s_Decl(self, n):
        typ, name = n.value
        init = self.coerce(typ, n.kids[0]) if n.kids else DEFAULTS[typ]
        self.emit(f'{self.declare(name, typ)} = {init}')

    def s_ArrDecl(self, n):
        typ, name, size = n.value
        self.emit(f'{self.declare(name, typ)} = [{DEFAULTS[typ]}] * {size}')

    def s_If(self, n):
        kw = 'if'
        while True:
            self.emit(f'{kw} {self.expr(n.kids[0])}:')
            self.suite(n.kids[1])
            if len(n.kids) < 3:
                break
            n = n.kids[2]
            if n.kind != 'If':
                self.emit('else:')
                self.suite(n)
                break
            kw = 'elif'

    def s_While(self, n):
        self.emit(f'while {self.expr(n.kids[0])}:')
        self.steps.append(None)
        self.suite(n.kids[1])
        self.steps.pop()

    # for (init; cond; step) body  ->  init; while cond: body; step
    def s_For(self, n):
        init, cond, step, body = n.kids
        self.scopes.append({})
        self.stmt(init)
        self.emit(f"while {self.expr(cond) if cond else 'True'}:")
        self.steps.append(step)
        self.suite(body, step)
        self.steps.pop()
        self.scopes.pop()

    def s_Return(self, n):
        self.emit(f'return {self.expr(n.kids[0])}' if n.kids else 'return')

    def s_Break(self, n):
        self.emit('break')

    def s_Continue(self, n):
        if self.steps and self.steps[-1]:
            self.stmt(self.steps[-1])
        self.emit('continue')

    def s_Cout(self, n):
        self.emit(f"out({', '.join(self.expr(k) for k in n.kids)})")

    def s_Assign(self, n):
        target, rhs = n.kids
        t = self.expr(target)
        if n.value == '=':
            self.emit(f'{t} = {self.coerce(self.typ(target), rhs)}')
            return
        full = Node('BinOp', n.value[0], [target, rhs], n.line)
        if n.value == '/=' or self.typ(target) != self.typ(full):
            self.emit(f'{t} = {self.coerce(self.typ(target), full)}')
        else:
            self.emit(f'{t} {n.value} {self.expr(rhs)}')

    def s_PreOp(self, n):
        self.emit(f'{self.expr(n.kids[0])} {n.value[0]}= 1')

    s_PostOp = s_PreOp

    # expressions

    def expr(self, n):
        h = getattr(self, 'e_' + n.kind, None)
        if h is None:
            # i++ and a = b inside an expression have no python equivalent
            raise CompileError(f'line {n.line}: {n.kind} inside expression is not supported')
        return h(n)

    def e_Num(self, n): return repr(n.value)
    def e_Bool(self, n): return repr(n.value)
    def e_Str(self, n): return repr(n.value)
    def e_Endl(self, n): return repr('\n')

    def e_Id(self, n):
        return self.lookup(n.value, n.line)[1]

    def e_Index(self, n):
        return f'{self.lookup(n.value, n.line)[1]}[{self.expr(n.kids[0])}]'

    def e_Call(self, n):
        if n.value not in self.funcs:
            raise CompileError(f'line {n.line}: unknown function {n.value}')
        return f"{pyname(n.value)}({', '.join(self.expr(a) for a in n.kids)})"

    def e_BinOp(self, n):
        a, b = n.kids
        l, r = self.expr(a), self.expr(b)
        ints = self.typ(a) != 'double' and self.typ(b) != 'double'
        if n.value == '/' and ints:
            return f'tdiv({l}, {r})'
        if n.value == '%':
            return f'tmod({l}, {r})'
        return f'({l} {PYOPS.get(n.value, n.value)} {r})'

    def e_UnOp(self, n):
        e = self.expr(n.kids[0])
        return f'(not {e})' if n.value == '!' else f'(-{e})'


def generate(prog):
    return PRELUDE + '\n'.join(Gen(prog).lines) + '\n'
