# Lab 2. Performance Measurement and Analysis

Лабораторна робота №2 з системного програмування. Автор: Dmytro Vitonichenko, ТТП-32.

`src/sigproc.c` — програма для дослідження: конвеєр із п'яти етапів обробки даних
(генерація сигналу, КІХ-фільтр, дифузія тепла, гістограма, контрольна сума).
Вона збирається з різними рівнями оптимізації (`-O0`, `-O2`, `-O3 -march=x86-64-v3`,
`-O3 … -ffast-math`), а скрипти знімають статистику, FlameGraph, енерговитрати й асемблер.

Відео із захистом: [Google Drive](https://drive.google.com/file/d/1a6IXIb-7Oe1XrhAgqs1yQ9G5dKlxte4p/view?usp=sharing)

## Структура

```
src/sigproc.c     програма
Makefile          make — збірка всіх варіантів у build/, make asm — лістинги в asm/
scripts/          скрипти вимірювань (номер у назві = пункт завдання), run_all.sh — усе підряд
asm/              асемблерні лістинги і звіти векторизатора
results/          результати: time, perf stat, perf report, FlameGraph (*.svg), енергія
```

## Запуск (Ubuntu / WSL2)

```bash
sudo apt install build-essential git time linux-tools-generic valgrind
make && make asm
./scripts/run_all.sh
```
