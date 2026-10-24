#!/usr/bin/env python3
"""Usage: python3 energy_emi.py results/emi_log.csv results/emi_marks.csv"""
import csv
import sys
from bisect import bisect_left

PWH_TO_J = 3.6e-9  # pWh -> J


def load_log(path):
    t, cols = [], {"pkg": [], "pp0": [], "pp1": []}
    for r in csv.DictReader(open(path)):
        t.append(int(r["unix_ms"]) / 1000)
        for k in cols:
            cols[k].append(int(r[k + "_pwh"]) * PWH_TO_J)
    return t, cols


def at(t, e, x):
    # linear interpolation between samples
    i = bisect_left(t, x)
    if i == 0 or i == len(t):
        return None
    return e[i - 1] + (e[i] - e[i - 1]) * (x - t[i - 1]) / (t[i] - t[i - 1])


def energy(t, e, a, b):
    ea, eb = at(t, e, a), at(t, e, b)
    return None if ea is None or eb is None else eb - ea


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    t, cols = load_log(sys.argv[1])
    marks = list(csv.DictReader(open(sys.argv[2])))
    print(f"samples in log: {len(t)}, step ~{(t[-1] - t[0]) / (len(t) - 1) * 1000:.0f} ms")

    idle = next(m for m in marks if m["label"] == "idle")
    ia, ib = float(idle["start"]), float(idle["end"])
    p_idle = {k: energy(t, e, ia, ib) / (ib - ia) for k, e in cols.items()}
    print("P_idle: " + ", ".join(f"{k.upper()} {v:.2f} W" for k, v in p_idle.items()) + "\n")

    hdr = f"{'variant':8} {'rep':>3} {'t,s':>6} {'P_pkg,W':>8} {'E_pkg,J':>8} {'E_pp0,J':>8} " \
          f"{'net_pkg':>8} {'net_pp0':>8} {'share':>7} {'EDP,J*s':>8}"
    print(hdr)
    agg = {}
    for m in marks:
        if m["label"] == "idle":
            continue
        a, b = float(m["start"]), float(m["end"])
        d = b - a
        epkg, epp0 = energy(t, cols["pkg"], a, b), energy(t, cols["pp0"], a, b)
        if epkg is None:
            print(f"{m['label']:8} {m['rep']:>3}  outside log")
            continue
        npkg, npp0 = epkg - p_idle["pkg"] * d, epp0 - p_idle["pp0"] * d
        busy, cpu = float(m["cpu_busy_s"]), float(m["cpu_prog_s"])
        # exclude other WSL processes
        share = npkg * min(1.0, cpu / busy) if busy > 0 else npkg
        row = (d, epkg / d, epkg, epp0, npkg, npp0, share, epkg * d)
        print(f"{m['label']:8} {m['rep']:>3} {d:6.2f} {row[1]:8.2f} {epkg:8.1f} {epp0:8.1f} "
              f"{npkg:8.1f} {npp0:8.1f} {share:7.1f} {row[7]:8.1f}")
        s = agg.setdefault(m["label"], [0] + [0.0] * len(row))
        s[0] += 1
        for i, x in enumerate(row):
            s[i + 1] += x

    print("\nAverage:")
    print(hdr.replace(f" {'rep':>3}", ""))
    for k, (n, *v) in agg.items():
        v = [x / n for x in v]
        print(f"{k:8} {v[0]:6.2f} {v[1]:8.2f} {v[2]:8.1f} {v[3]:8.1f} {v[4]:8.1f} {v[5]:8.1f} "
              f"{v[6]:7.1f} {v[7]:8.1f}")


if __name__ == "__main__":
    main()
