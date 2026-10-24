#!/usr/bin/env bash
# tasks 3, 4.4: energy from Windows "Energy Meter" counters (no RAPL in WSL2)
source "$(dirname "$0")/common.sh"
REPS="${REPS:-3}"; IDLE_SEC="${IDLE_SEC:-15}"; COOL="${COOL:-5}"
LOG="$RES/emi_log.csv"; MARKS="$RES/emi_marks.csv"; STOP="$RES/.emi_stop"
busy_jiffies() { awk '/^cpu /{print $2+$3+$4+$7+$8}' /proc/stat; }
now() { date +%s.%N; }

rm -f "$STOP" "$LOG"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w "$ROOT/scripts/emi_sampler.ps1")" \
    -Out "$(wslpath -w "$LOG")" -Stop "$(wslpath -w "$STOP")" &
SAMPLER=$!
trap 'touch "$STOP"; wait $SAMPLER 2>/dev/null' EXIT
until [[ -s "$LOG" ]]; do sleep 0.2; done

echo "label,rep,start,end,cpu_prog_s,cpu_busy_s" > "$MARKS"
echo ">> Idle ${IDLE_SEC} s, do not touch anything..."
sleep 3; t0=$(now); sleep "$IDLE_SEC"; t1=$(now)
echo "idle,0,$t0,$t1,0,0" >> "$MARKS"

for v in ${@:-O0 O3avx}; do
    bin=$(bin_for "$v")
    for r in $(seq 1 "$REPS"); do
        sleep "$COOL"
        j0=$(busy_jiffies); t0=$(now)
        /usr/bin/time -f "%U %S" -o "$RES/.cpu" $PIN "$bin" $ARGS > /dev/null
        t1=$(now); j1=$(busy_jiffies)
        cpu=$(awk '{print $1+$2}' "$RES/.cpu")
        busy=$(awk -v j="$(( j1 - j0 ))" -v hz="$(getconf CLK_TCK)" 'BEGIN{print j/hz}')
        echo "$v,$r,$t0,$t1,$cpu,$busy" | tee -a "$MARKS"
    done
done
rm -f "$RES/.cpu"
sleep 2
python3 "$ROOT/scripts/energy_emi.py" "$LOG" "$MARKS" | tee "$RES/energy_emi.txt"
