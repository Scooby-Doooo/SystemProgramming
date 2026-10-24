#!/usr/bin/env bash
# environment check
source "$(dirname "$0")/common.sh"
set +e
echo "== System";      uname -sr; grep -m1 "model name" /proc/cpuinfo
echo "Virtualization: $(systemd-detect-virt 2>/dev/null || echo unknown)"
grep -qi microsoft /proc/version && echo "!! Looks like WSL"
echo "AVX2: $(grep -qw avx2 /proc/cpuinfo && echo yes || echo no)   AVX-512F: $(grep -qw avx512f /proc/cpuinfo && echo yes || echo no)"
echo; echo "== Tools"
for t in gcc perf /usr/bin/time git perl; do printf "%-14s %s\n" "$t" "$(command -v $t || echo 'MISSING')"; done
echo; echo "== perf"
echo "perf_event_paranoid = $(cat /proc/sys/kernel/perf_event_paranoid)   (perf record -a needs <=0 or sudo)"
perf stat -e cycles,instructions true 2>&1 | grep -E "cycles|instructions|not supported" | sed 's/^/  /'
echo; echo "== Energy (Windows \"Energy Meter\" counters)"
powershell.exe -NoProfile -Command '(Get-Counter -ListSet "Energy Meter").PathsWithInstances' 2>/dev/null \
    | grep -i energy | sed 's/^/  /' || echo "  not available"
