#!/usr/bin/env bash
# task 2.3: perf record, report, annotate
source "$(dirname "$0")/common.sh"
for v in ${@:-O0 O3avx}; do
    data="$RES/perf_$v.data"
    echo ">> perf record $v"
    perf record -e "$PERF_EV" -F 999 --call-graph dwarf -o "$data" $PIN "$(bin_for "$v")" $ARGS > /dev/null
    perf report -i "$data" --stdio --no-children --sort symbol        > "$RES/report_$v.txt"   2>/dev/null
    perf report -i "$data" --stdio --children    --sort symbol -g none > "$RES/report_children_$v.txt" 2>/dev/null
    perf annotate -i "$data" --stdio -s fir_filter                    > "$RES/annotate_fir_$v.txt" 2>/dev/null || true
    head -40 "$RES/report_$v.txt"
done
echo "Interactive: perf report -i results/perf_O3avx.data"
