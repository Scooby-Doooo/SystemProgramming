#!/usr/bin/env bash
# task 2.2 on WSL2: no hardware counters, so cachegrind instead
# cache sizes of i7-13620H, smaller input because valgrind is slow
source "$(dirname "$0")/common.sh"
CG_ARGS="${CG_ARGS:-1 20 512}"
for v in ${@:-O0 O3avx}; do
    echo ">> cachegrind $v ($CG_ARGS)"
    valgrind --tool=cachegrind --cache-sim=yes --branch-sim=yes \
        --I1=32768,8,64 --D1=49152,12,64 --LL=25165824,12,64 \
        --cachegrind-out-file="$RES/cachegrind_$v.out" \
        "$(bin_for "$v")" $CG_ARGS 2> "$RES/cachegrind_$v.txt" > /dev/null
    grep -E "I *refs|D *refs|D1 *miss|LLd *miss|Branches|Mispred" "$RES/cachegrind_$v.txt" | sed 's/^==[0-9]*== //'
    cg_annotate "$RES/cachegrind_$v.out" > "$RES/cachegrind_annotate_$v.txt" 2>/dev/null || true
done
