import sys
from tree import CompileError

DEFAULTS = {'int': 0, 'double': 0.0, 'bool': False}
CASTS = {'int': int, 'double': float, 'bool': bool}


class ReturnSignal(Exception):
    def __init__(self, value):
        self.value = value


class BreakSignal(Exception):
    pass


class ContinueSignal(Exception):
    pass


def cast(typ, v):
    return CASTS[typ](v) if typ in CASTS else v


def fmt(v):
    if isinstance(v, bool):
        return str(int(v))
    if isinstance(v, float):
        return '%g' % v
    return str(v)


# C++ int division truncates toward zero, python // floors
def tdiv(a, b):
    q = abs(a) // abs(b)
    return q if (a < 0) == (b < 0) else -q


def binop(op, a, b, line):
    if op in ('/', '%') and b == 0:
        raise CompileError(f'line {line}: division by zero')
    both_int = isinstance(a, int) and isinstance(b, int)
    if op == '+': return a + b
    if op == '-': return a - b
    if op == '*': return a * b
    if op == '/': return tdiv(a, b) if both_int else a / b
    if op == '%': return a - b * tdiv(a, b)
    if op == '==': return a == b
    if op == '!=': return a != b
    if op == '<': return a < b
    if op == '<=': return a <= b
    if op == '>': return a > b
    if op == '>=': return a >= b


class Interpreter:
    def __init__(self, prog, out=sys.stdout):
        self.out = out
        self.funcs = {}
        self.scopes = [{}]  # [globals, ...locals]; a var is [type, value]
        for item in prog.kids:
            if item.kind == 'Func':
                self.funcs[item.value[1]] = item
            else:
                self.run(item)

    def main(self):
        return self.call('main', [], 0)

    def run(self, n):
        return getattr(self, 'do_' + n.kind)(n)

    def call(self, name, args, line):
        f = self.funcs.get(name)
        if f is None:
            raise CompileError(f'line {line}: unknown function {name}')
        params, body = f.kids
        if len(args) != len(params.kids):
            raise CompileError(f'line {line}: wrong number of args for {name}')
        frame = {p.value[1]: [p.value[0], cast(p.value[0], a)] for p, a in zip(params.kids, args)}
        saved, self.scopes = self.scopes, [self.scopes[0], frame]
        try:
            self.run(body)
            ret = None
        except ReturnSignal as r:
            ret = r.value
        finally:
            self.scopes = saved
        return None if ret is None else cast(f.value[0], ret)

    def lookup(self, name, line):
        for s in reversed(self.scopes):
            if name in s:
                return s[name]
        raise CompileError(f'line {line}: {name} is not declared')

    def declare(self, name, cell, line):
        if name in self.scopes[-1]:
            raise CompileError(f'line {line}: {name} redeclared')
        self.scopes[-1][name] = cell

    # lvalue -> (container, key, type)
    def ref(self, n):
        cell = self.lookup(n.value, n.line)
        if n.kind == 'Id':
            return cell, 1, cell[0]
        if not isinstance(cell[1], list):
            raise CompileError(f'line {n.line}: {n.value} is not an array')
        i = self.run(n.kids[0])
        if not 0 <= i < len(cell[1]):
            raise CompileError(f'line {n.line}: index {i} out of range')
        return cell[1], i, cell[0]

    # statements

    def do_Block(self, n):
        self.scopes.append({})
        try:
            for k in n.kids:
                self.run(k)
        finally:
            self.scopes.pop()

    def do_Decls(self, n):
        for k in n.kids:
            self.run(k)

    def do_Decl(self, n):
        typ, name = n.value
        v = cast(typ, self.run(n.kids[0])) if n.kids else DEFAULTS[typ]
        self.declare(name, [typ, v], n.line)

    def do_ArrDecl(self, n):
        typ, name, size = n.value
        self.declare(name, [typ, [DEFAULTS[typ]] * size], n.line)

    def do_If(self, n):
        if self.run(n.kids[0]):
            self.run(n.kids[1])
        elif len(n.kids) == 3:
            self.run(n.kids[2])

    def do_While(self, n):
        cond, body = n.kids
        while self.run(cond):
            try:
                self.run(body)
            except BreakSignal:
                break
            except ContinueSignal:
                pass

    def do_For(self, n):
        init, cond, step, body = n.kids
        self.scopes.append({})
        try:
            if init:
                self.run(init)
            while cond is None or self.run(cond):
                try:
                    self.run(body)
                except BreakSignal:
                    break
                except ContinueSignal:
                    pass
                if step:
                    self.run(step)
        finally:
            self.scopes.pop()

    def do_Return(self, n):
        raise ReturnSignal(self.run(n.kids[0]) if n.kids else None)

    def do_Break(self, n):
        raise BreakSignal()

    def do_Continue(self, n):
        raise ContinueSignal()

    def do_Cout(self, n):
        for k in n.kids:
            self.out.write(fmt(self.run(k)))

    # expressions

    def do_Num(self, n): return n.value
    def do_Bool(self, n): return n.value
    def do_Str(self, n): return n.value
    def do_Endl(self, n): return '\n'

    def do_Id(self, n):
        return self.lookup(n.value, n.line)[1]

    def do_Index(self, n):
        cont, i, _ = self.ref(n)
        return cont[i]

    def do_Call(self, n):
        return self.call(n.value, [self.run(a) for a in n.kids], n.line)

    def do_BinOp(self, n):
        if n.value == '&&':
            return bool(self.run(n.kids[0])) and bool(self.run(n.kids[1]))
        if n.value == '||':
            return bool(self.run(n.kids[0])) or bool(self.run(n.kids[1]))
        return binop(n.value, self.run(n.kids[0]), self.run(n.kids[1]), n.line)

    def do_UnOp(self, n):
        v = self.run(n.kids[0])
        return -v if n.value == '-' else not v

    def do_Assign(self, n):
        cont, key, typ = self.ref(n.kids[0])
        v = self.run(n.kids[1])
        if n.value != '=':
            v = binop(n.value[0], cont[key], v, n.line)
        cont[key] = cast(typ, v)
        return cont[key]

    def do_PreOp(self, n):
        cont, key, typ = self.ref(n.kids[0])
        cont[key] = cast(typ, cont[key] + (1 if n.value == '++' else -1))
        return cont[key]

    def do_PostOp(self, n):
        cont, key, typ = self.ref(n.kids[0])
        old = cont[key]
        cont[key] = cast(typ, old + (1 if n.value == '++' else -1))
        return old
