import argparse
import json
import os
import sys
from tree import CompileError
from lexer import make_lexer
from grammar import parse
from interp import Interpreter
from codegen import generate

ROOT = os.path.join(os.path.dirname(__file__), '..')


def main():
    ap = argparse.ArgumentParser(description='C++ subset translator')
    ap.add_argument('file', help='.cpp source')
    ap.add_argument('--tokens', action='store_true', help='print tokens and exit')
    args = ap.parse_args()

    with open(args.file, encoding='utf-8') as f:
        src = f.read()
    name = os.path.splitext(os.path.basename(args.file))[0]

    try:
        if args.tokens:
            lx = make_lexer()
            lx.input(src)
            for t in lx:
                print(f'{t.lineno:3}  {t.type:10} {t.value!r}')
            return

        prog = parse(src)

        # web/ast.js is loaded by web/index.html
        data = {'file': os.path.basename(args.file), 'src': src, 'tree': prog.to_dict()}
        with open(os.path.join(ROOT, 'web', 'ast.js'), 'w', encoding='utf-8') as f:
            f.write('const AST = ' + json.dumps(data, indent=1) + ';\n')
        print('ast:  web/ast.js')

        os.makedirs(os.path.join(ROOT, 'out'), exist_ok=True)
        with open(os.path.join(ROOT, 'out', name + '.py'), 'w', encoding='utf-8') as f:
            f.write(generate(prog))
        print(f'code: out/{name}.py')

        print('--- run ---')
        Interpreter(prog).main()
    except CompileError as e:
        print('error:', e)
        sys.exit(1)


if __name__ == '__main__':
    main()
