#!/usr/bin/env bash
# task 2.2: perf stat -d, 3 runs
source "$(dirname "$0")/common.sh"
for v in ${@:-O0 O3avx}; do
    echo ">> perf stat -d $v"
    perf stat -d -r 3 -o "$RES/perfstat_$v.txt" $PIN "$(bin_for "$v")" $ARGS > /dev/null
    cat "$RES/perfstat_$v.txt"
done
