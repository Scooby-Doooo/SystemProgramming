#!/usr/bin/env bash
# task 4.2: summary table -> results/summary.md
source "$(dirname "$0")/common.sh"
num() { tr -d ',' ; }
tv()  { grep -m1 "$2" "$RES/time_$1.txt" 2>/dev/null | awk -F': ' '{print $2}'; }
pv()  { grep -m1 -E "[0-9] +(cpu_core/)?$2/?( |$)" "$RES/perfstat_$1.txt" 2>/dev/null | awk '{print $1}' | num; }
ipc() { grep -m1 "insn per cycle" "$RES/perfstat_$1.txt" 2>/dev/null | sed -E 's/.*# +([0-9.]+) +insn.*/\1/'; }
vs=(${@:-O0 O2 O3avx O3fast})
out="$RES/summary.md"
{
  printf "| metric |"; for v in "${vs[@]}"; do printf " %s |" "$v"; done; echo
  printf "|---|"; for v in "${vs[@]}"; do printf -- "---:|"; done; echo
  printf "| wall time |";         for v in "${vs[@]}"; do printf " %s |" "$(tv "$v" 'Elapsed (wall clock)')"; done; echo
  printf "| user time, s |";      for v in "${vs[@]}"; do printf " %s |" "$(tv "$v" 'User time')"; done; echo
  printf "| max RSS, KB |";       for v in "${vs[@]}"; do printf " %s |" "$(tv "$v" 'Maximum resident')"; done; echo
  printf "| minor page faults |"; for v in "${vs[@]}"; do printf " %s |" "$(tv "$v" 'Minor')"; done; echo
  printf "| invol. ctx switches |"; for v in "${vs[@]}"; do printf " %s |" "$(tv "$v" 'Involuntary')"; done; echo
  for ev in cycles instructions branch-misses L1-dcache-loads L1-dcache-load-misses LLC-load-misses; do
    printf "| %s |" "$ev"; for v in "${vs[@]}"; do printf " %s |" "$(pv "$v" "$ev")"; done; echo
  done
  printf "| IPC |"; for v in "${vs[@]}"; do printf " %s |" "$(ipc "$v")"; done; echo
} > "$out"
cat "$out"
