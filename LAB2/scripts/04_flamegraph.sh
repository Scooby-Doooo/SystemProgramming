#!/usr/bin/env bash
# tasks 1, 4.3: FlameGraph (SYSTEM=1 for the whole system)
source "$(dirname "$0")/common.sh"
FG="$TOOLS/FlameGraph"
[[ -d "$FG" ]] || git clone --depth 1 https://github.com/brendangregg/FlameGraph "$FG"

variants=(${@:-O0 O3avx})
for v in "${variants[@]}"; do
    tag="$v"; rec=(perf record -e "$PERF_EV" -F 999 --call-graph dwarf)
    if [[ "${SYSTEM:-0}" == 1 ]]; then tag="${v}_system"; rec+=(-a); fi
    data="$RES/fg_$tag.data"
    "${rec[@]}" -o "$data" -- $PIN "$(bin_for "$v")" $ARGS > /dev/null
    perf script -i "$data" > "$RES/fg_$tag.perf"
    "$FG/stackcollapse-perf.pl" "$RES/fg_$tag.perf" > "$RES/fg_$tag.folded"
    "$FG/flamegraph.pl" --title "sigproc $tag" "$RES/fg_$tag.folded" > "$RES/flame_$tag.svg"
    echo "done: results/flame_$tag.svg"
done

# diff of the first two variants
if (( ${#variants[@]} >= 2 )) && [[ "${SYSTEM:-0}" != 1 ]]; then
    a="${variants[0]}"; b="${variants[1]}"
    # drop the process name, otherwise the stacks don't match
    "$FG/difffolded.pl" -n <(cut -d';' -f2- "$RES/fg_$a.folded") <(cut -d';' -f2- "$RES/fg_$b.folded") \
        | "$FG/flamegraph.pl" --title "diff $a -> $b" > "$RES/flame_diff_${a}_${b}.svg"
    echo "done: results/flame_diff_${a}_${b}.svg"
fi
