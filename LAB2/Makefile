# make: all variants into build/, make asm: listings into asm/
# -g is needed for perf --call-graph dwarf

CC      ?= gcc
SRC     := src/sigproc.c
COMMON  := -std=gnu11 -Wall -Wextra -g -fno-omit-frame-pointer
# no AVX2: make ARCH=x86-64
ARCH    ?= x86-64-v3

FLAGS_O0      := -O0
FLAGS_O2      := -O2
FLAGS_O3avx   := -O3 -march=$(ARCH)
FLAGS_O3fast  := -O3 -march=$(ARCH) -ffast-math

VARIANTS := O0 O2 O3avx O3fast
BINS     := $(VARIANTS:%=build/sigproc_%)

.PHONY: all asm clean
all: $(BINS)

build/sigproc_%: $(SRC) | build
	$(CC) $(COMMON) $(FLAGS_$*) -o $@ $<

asm: $(VARIANTS:%=asm/sigproc_%.s)

asm/sigproc_%.s: $(SRC) | asmdir
	$(CC) $(COMMON:-g=) $(FLAGS_$*) -S -masm=intel -fno-asynchronous-unwind-tables \
	      -fopt-info-vec-all=asm/vecinfo_$*.txt -o $@ $<

build asmdir:
	@mkdir -p build asm

clean:
	rm -rf build asm/*.s asm/*.txt
