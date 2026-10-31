# Lab 3. Parser for a C++ subset (Lex/YACC)

Лабораторна робота №3 з системного програмування. Автор: Dmytro Vitonichenko, ТТП-32.

Відео із захистом: https://drive.google.com/file/d/1CZV4D9SuG_tkgJ3BR9GHuFWvURStWIn9/view?usp=sharing

Синтаксичний аналізатор підмножини C++ на PLY (реалізація Lex/YACC на Python).
Програма будує AST, виконує його (інтерпретатор), транслює в Python
і показує дерево в браузері через d3.js.

## Структура

```
src/lexer.py     лексер (lex): токени, коментарі, #include пропускається
src/grammar.py   граматика (yacc), пріоритети операторів, побудова AST
src/tree.py      вузол AST і помилка компіляції
src/interp.py    інтерпретатор AST
src/codegen.py   генерація коду на Python
src/main.py      запуск: AST -> web/ast.js, код -> out/<name>.py, виконання
src/test.py      порівнює вивід інтерпретатора і згенерованого коду на всіх прикладах
examples/        приклади програм (error.cpp — із синтаксичною помилкою)
web/index.html   візуалізація AST (d3.js)
build/parser.out LALR-автомат: правила, стани, таблиці переходів
```

## Запуск

```bash
pip install -r requirements.txt
python src/main.py examples/fact.cpp
python src/main.py examples/fact.cpp --tokens
python src/test.py
```

Після `main.py` відкрити `web/index.html` у браузері. Клік по вузлу згортає піддерево,
колесо миші — масштаб.

## Що підтримується

- типи `int`, `double`, `bool`, `void`, одновимірні масиви `int a[10]`;
- функції з параметрами, рекурсія, глобальні змінні;
- `if`/`else`, `while`, `for`, `break`, `continue`, `return`;
- вирази з пріоритетами C++: `= += -= *= /=`, `|| &&`, `== != < <= > >=`, `+ - * / %`,
  унарні `- !`, `++ --` (префіксні й постфіксні);
- `cout << ... << endl`, `#include` і `using namespace std;`.

Ділення цілих і `%` працюють як у C++ (округлення до нуля). У згенерованому Python
`i++` і присвоєння всередині іншого виразу не підтримуються, лише окремою інструкцією.

## Конфлікти

PLY, як і yacc, будує LALR(1)-таблиці. Неоднозначні правила для виразів
(`expr : expr PLUS expr` тощо) дають shift/reduce конфлікти, які розв'язуються
таблицею `precedence` у `grammar.py` (аналог `%left`/`%right`).
«Висячий else» розв'язується через `%prec IFX`: у конфлікті перемагає shift, тож `else`
належить найближчому `if`. Якщо прибрати `precedence`, PLY виведе попередження про конфлікти,
а в `build/parser.out` буде видно, в яких станах вони виникли.
