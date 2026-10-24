#!/usr/bin/env bash
# everything in order: sudo ./scripts/run_all.sh
source "$(dirname "$0")/common.sh"
D="$(dirname "$0")"
make -C "$ROOT" all asm
"$D/env_check.sh"            | tee "$RES/env.txt"
"$D/01_time.sh"       O0 O2 O3avx O3fast
"$D/02_perf_stat.sh"  O0 O2 O3avx O3fast
command -v valgrind >/dev/null && "$D/02b_cachegrind.sh" O0 O3avx
"$D/03_perf_record.sh" O0 O3avx
"$D/04_flamegraph.sh"  O0 O3avx
SYSTEM=1 "$D/04_flamegraph.sh" O3avx
"$D/06_asm.sh" fir_filter O0 O2 O3avx
"$D/06_asm.sh" checksum O3avx O3fast
"$D/05_energy_emi.sh" O0 O3avx O3fast
"$D/07_summary.sh"
