class CompileError(Exception):
    pass


class Node:
    def __init__(self, kind, value=None, kids=(), line=0):
        self.kind = kind
        self.value = value
        self.kids = list(kids)
        self.line = line

    def __repr__(self):
        return f'Node({self.kind}, {self.value!r}, {self.kids})'

    # format for d3.hierarchy: {name, children}
    def to_dict(self):
        name = self.kind
        if isinstance(self.value, tuple):
            name += ' ' + ' '.join(map(str, self.value))
        elif self.kind == 'Str':
            name += ' ' + repr(self.value)
        elif self.value is not None:
            name += ' ' + str(self.value)
        d = {'name': name}
        kids = [k.to_dict() for k in self.kids if k is not None]
        if kids:
            d['children'] = kids
        return d
