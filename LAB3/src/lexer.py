import ply.lex as lex
from tree import CompileError

reserved = {
    'int': 'INT', 'double': 'DOUBLE', 'bool': 'BOOL', 'void': 'VOID',
    'if': 'IF', 'else': 'ELSE', 'while': 'WHILE', 'for': 'FOR',
    'return': 'RETURN', 'break': 'BREAK', 'continue': 'CONTINUE',
    'true': 'TRUE', 'false': 'FALSE',
    'cout': 'COUT', 'endl': 'ENDL',
    'using': 'USING', 'namespace': 'NAMESPACE',
}

tokens = [
    'ID', 'NUMBER', 'FNUMBER', 'STRING',
    'PLUS', 'MINUS', 'TIMES', 'DIVIDE', 'MOD',
    'ASSIGN', 'PLUSEQ', 'MINUSEQ', 'TIMESEQ', 'DIVEQ', 'INC', 'DEC',
    'EQ', 'NE', 'LT', 'LE', 'GT', 'GE', 'AND', 'OR', 'NOT', 'SHL',
    'LPAREN', 'RPAREN', 'LBRACE', 'RBRACE', 'LBRACKET', 'RBRACKET',
    'SEMI', 'COMMA',
] + list(reserved.values())

# string rules are sorted by regex length, so '<<' wins over '<'
t_PLUS = r'\+'
t_MINUS = r'-'
t_TIMES = r'\*'
t_DIVIDE = r'/'
t_MOD = r'%'
t_ASSIGN = r'='
t_PLUSEQ = r'\+='
t_MINUSEQ = r'-='
t_TIMESEQ = r'\*='
t_DIVEQ = r'/='
t_INC = r'\+\+'
t_DEC = r'--'
t_EQ = r'=='
t_NE = r'!='
t_LT = r'<'
t_LE = r'<='
t_GT = r'>'
t_GE = r'>='
t_AND = r'&&'
t_OR = r'\|\|'
t_NOT = r'!'
t_SHL = r'<<'
t_LPAREN = r'\('
t_RPAREN = r'\)'
t_LBRACE = r'\{'
t_RBRACE = r'\}'
t_LBRACKET = r'\['
t_RBRACKET = r'\]'
t_SEMI = r';'
t_COMMA = r','

t_ignore = ' \t\r'
t_ignore_COMMENT = r'//.*'
t_ignore_PREPROC = r'\#.*'   # #include is skipped


def t_BLOCKCOMMENT(t):
    r'/\*(.|\n)*?\*/'
    t.lexer.lineno += t.value.count('\n')


def t_FNUMBER(t):
    r'\d+\.\d*|\.\d+'
    t.value = float(t.value)
    return t


def t_NUMBER(t):
    r'\d+'
    t.value = int(t.value)
    return t


def t_STRING(t):
    r'"([^"\\\n]|\\.)*"'
    t.value = t.value[1:-1].encode().decode('unicode_escape')
    return t


def t_ID(t):
    r'[A-Za-z_]\w*'
    t.type = reserved.get(t.value, 'ID')
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


def t_error(t):
    raise CompileError(f'line {t.lineno}: bad char {t.value[0]!r}')


def make_lexer():
    return lex.lex()
