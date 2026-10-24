# shared settings
set -euo pipefail
export LC_ALL=C
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"
RES="$ROOT/results"
TOOLS="$ROOT/tools"
mkdir -p "$RES"

# rounds log2n grid
ARGS="${ARGS:-30 22 1536}"

bin_for() {
    local b="$BUILD/sigproc_$1"
    [[ -x "$b" ]] || { echo "$b not found, run make first" >&2; exit 1; }
    echo "$b"
}

# pin to a P-core on hybrid CPUs, disable with PIN=
if [[ -z "${PIN+x}" ]]; then
    if [[ -r /sys/devices/cpu_core/cpus ]]; then
        PIN="taskset -c $(cut -d- -f1 < /sys/devices/cpu_core/cpus | cut -d, -f1)"
    else
        PIN=""
    fi
fi

# WSL2 has no cycles event, fall back to cpu-clock
if [[ -z "${PERF_EV+x}" ]]; then
    if perf stat -x, -e cycles true 2>&1 | grep -q "not supported"; then PERF_EV="cpu-clock"; else PERF_EV="cycles"; fi
fi
