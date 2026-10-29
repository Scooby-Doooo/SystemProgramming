# runs every example with the interpreter and as generated python, outputs must match
import glob
import io
import os
import subprocess
import sys
from grammar import parse
from interp import Interpreter
from codegen import generate
from tree import CompileError

ROOT = os.path.join(os.path.dirname(__file__), '..')
failed = 0

for path in sorted(glob.glob(os.path.join(ROOT, 'examples', '*.cpp'))):
    name = os.path.basename(path)
    src = open(path, encoding='utf-8').read()
    if name == 'error.cpp':
        try:
            parse(src)
            ok = False
        except CompileError:
            ok = True
    else:
        prog = parse(src)
        buf = io.StringIO()
        Interpreter(prog, buf).main()
        res = subprocess.run([sys.executable, '-c', generate(prog)], capture_output=True, text=True)
        ok = res.returncode == 0 and res.stdout == buf.getvalue()
    print('ok  ' if ok else 'FAIL', name)
    failed += not ok

sys.exit(failed)
