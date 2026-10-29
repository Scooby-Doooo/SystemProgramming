import os
import ply.yacc as yacc
from lexer import tokens, make_lexer
from tree import Node, CompileError

# lowest to highest
precedence = (
    ('nonassoc', 'IFX'),     # dangling else: shift ELSE
    ('nonassoc', 'ELSE'),
    ('right', 'ASSIGN', 'PLUSEQ', 'MINUSEQ', 'TIMESEQ', 'DIVEQ'),
    ('left', 'OR'),
    ('left', 'AND'),
    ('left', 'EQ', 'NE'),
    ('left', 'LT', 'LE', 'GT', 'GE'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE', 'MOD'),
    ('right', 'NOT', 'UMINUS'),
    ('left', 'INC', 'DEC'),
)


def p_program(p):
    'program : items'
    p[0] = Node('Program', kids=p[1])


def p_items(p):
    '''items : items item
             | empty'''
    p[0] = [] if len(p) == 2 else p[1] + ([p[2]] if p[2] else [])


def p_item(p):
    '''item : func
            | decl SEMI
            | USING NAMESPACE ID SEMI'''
    p[0] = None if p[1] == 'using' else p[1]


def p_func(p):
    'func : type ID LPAREN params RPAREN block'
    p[0] = Node('Func', (p[1], p[2]), [Node('Params', kids=p[4]), p[6]], p.lineno(2))


def p_type(p):
    '''type : INT
            | DOUBLE
            | BOOL
            | VOID'''
    p[0] = p[1]


def p_params(p):
    '''params : param_list
              | empty'''
    p[0] = p[1] or []


def p_param_list(p):
    '''param_list : param_list COMMA param
                  | param'''
    p[0] = [p[1]] if len(p) == 2 else p[1] + [p[3]]


def p_param(p):
    'param : type ID'
    p[0] = Node('Param', (p[1], p[2]))


# int a, b = 1, c[10];
def p_decl(p):
    'decl : type init_list'
    nodes = []
    for name, size, init, line in p[2]:
        if size is not None:
            nodes.append(Node('ArrDecl', (p[1], name, size), line=line))
        else:
            nodes.append(Node('Decl', (p[1], name), [init] if init else [], line))
    p[0] = nodes[0] if len(nodes) == 1 else Node('Decls', kids=nodes)


def p_init_list(p):
    '''init_list : init_list COMMA init
                 | init'''
    p[0] = [p[1]] if len(p) == 2 else p[1] + [p[3]]


def p_init(p):
    '''init : ID
            | ID ASSIGN expr
            | ID LBRACKET NUMBER RBRACKET'''
    if len(p) == 2:
        p[0] = (p[1], None, None, p.lineno(1))
    elif len(p) == 4:
        p[0] = (p[1], None, p[3], p.lineno(1))
    else:
        p[0] = (p[1], p[3], None, p.lineno(1))


def p_block(p):
    'block : LBRACE stmts RBRACE'
    p[0] = Node('Block', kids=p[2])


def p_stmts(p):
    '''stmts : stmts stmt
             | empty'''
    p[0] = [] if len(p) == 2 else p[1] + ([p[2]] if p[2] else [])


def p_stmt_simple(p):
    '''stmt : decl SEMI
            | expr SEMI
            | block
            | SEMI'''
    p[0] = None if p[1] == ';' else p[1]


def p_stmt_if(p):
    'stmt : IF LPAREN expr RPAREN stmt %prec IFX'
    p[0] = Node('If', kids=[p[3], p[5]], line=p.lineno(1))


def p_stmt_if_else(p):
    'stmt : IF LPAREN expr RPAREN stmt ELSE stmt'
    p[0] = Node('If', kids=[p[3], p[5], p[7]], line=p.lineno(1))


def p_stmt_while(p):
    'stmt : WHILE LPAREN expr RPAREN stmt'
    p[0] = Node('While', kids=[p[3], p[5]], line=p.lineno(1))


def p_stmt_for(p):
    'stmt : FOR LPAREN for_init SEMI opt_expr SEMI opt_expr RPAREN stmt'
    p[0] = Node('For', kids=[p[3], p[5], p[7], p[9]], line=p.lineno(1))


def p_for_init(p):
    '''for_init : decl
                | opt_expr'''
    p[0] = p[1]


def p_opt_expr(p):
    '''opt_expr : expr
                | empty'''
    p[0] = p[1]


def p_stmt_return(p):
    'stmt : RETURN opt_expr SEMI'
    p[0] = Node('Return', kids=[p[2]] if p[2] else [], line=p.lineno(1))


def p_stmt_jump(p):
    '''stmt : BREAK SEMI
            | CONTINUE SEMI'''
    p[0] = Node(p[1].capitalize(), line=p.lineno(1))


# cout << a << "text" << endl;
def p_stmt_cout(p):
    'stmt : COUT out_list SEMI'
    p[0] = Node('Cout', kids=p[2], line=p.lineno(1))


def p_out_list(p):
    '''out_list : out_list SHL out_item
                | SHL out_item'''
    p[0] = [p[2]] if len(p) == 3 else p[1] + [p[3]]


def p_out_item(p):
    '''out_item : expr
                | ENDL'''
    p[0] = Node('Endl') if p[1] == 'endl' else p[1]


def p_expr_assign(p):
    '''expr : expr ASSIGN expr
            | expr PLUSEQ expr
            | expr MINUSEQ expr
            | expr TIMESEQ expr
            | expr DIVEQ expr'''
    if p[1].kind not in ('Id', 'Index'):
        raise CompileError(f'line {p.lineno(2)}: lvalue required')
    p[0] = Node('Assign', p[2], [p[1], p[3]], p.lineno(2))


def p_expr_binop(p):
    '''expr : expr OR expr
            | expr AND expr
            | expr EQ expr
            | expr NE expr
            | expr LT expr
            | expr LE expr
            | expr GT expr
            | expr GE expr
            | expr PLUS expr
            | expr MINUS expr
            | expr TIMES expr
            | expr DIVIDE expr
            | expr MOD expr'''
    p[0] = Node('BinOp', p[2], [p[1], p[3]], p.lineno(2))


def p_expr_unary(p):
    '''expr : MINUS expr %prec UMINUS
            | NOT expr'''
    p[0] = Node('UnOp', p[1], [p[2]], p.lineno(1))


def p_expr_incdec(p):
    '''expr : INC expr
            | DEC expr
            | expr INC
            | expr DEC'''
    if isinstance(p[1], str):
        kind, op, target = 'PreOp', p[1], p[2]
    else:
        kind, op, target = 'PostOp', p[2], p[1]
    if target.kind not in ('Id', 'Index'):
        raise CompileError(f'line {p.lineno(1)}: lvalue required')
    p[0] = Node(kind, op, [target], p.lineno(1))


def p_expr_group(p):
    'expr : LPAREN expr RPAREN'
    p[0] = p[2]


def p_expr_number(p):
    '''expr : NUMBER
            | FNUMBER'''
    p[0] = Node('Num', p[1])


def p_expr_bool(p):
    '''expr : TRUE
            | FALSE'''
    p[0] = Node('Bool', p[1] == 'true')


def p_expr_string(p):
    'expr : STRING'
    p[0] = Node('Str', p[1])


def p_expr_id(p):
    'expr : ID'
    p[0] = Node('Id', p[1], line=p.lineno(1))


def p_expr_index(p):
    'expr : ID LBRACKET expr RBRACKET'
    p[0] = Node('Index', p[1], [p[3]], p.lineno(1))


def p_expr_call(p):
    '''expr : ID LPAREN args RPAREN'''
    p[0] = Node('Call', p[1], p[3], p.lineno(1))


def p_args(p):
    '''args : arg_list
            | empty'''
    p[0] = p[1] or []


def p_arg_list(p):
    '''arg_list : arg_list COMMA expr
                | expr'''
    p[0] = [p[1]] if len(p) == 2 else p[1] + [p[3]]


def p_empty(p):
    'empty :'
    p[0] = None


def p_error(t):
    if t is None:
        raise CompileError('unexpected end of file')
    raise CompileError(f'line {t.lineno}: syntax error near {t.value!r}')


# parser.out (LALR states and conflicts) goes to build/
BUILD = os.path.join(os.path.dirname(__file__), '..', 'build')
os.makedirs(BUILD, exist_ok=True)
parser = yacc.yacc(debug=True, outputdir=BUILD, write_tables=False)


def parse(src):
    return parser.parse(src, lexer=make_lexer())
