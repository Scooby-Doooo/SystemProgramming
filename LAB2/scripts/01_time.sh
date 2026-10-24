#!/usr/bin/env bash
# task 2.1: time -v
source "$(dirname "$0")/common.sh"
for v in ${@:-O0 O3avx}; do
    echo ">> time -v $v"
    /usr/bin/time --verbose -o "$RES/time_$v.txt" $PIN "$(bin_for "$v")" $ARGS
    cat "$RES/time_$v.txt"
done
