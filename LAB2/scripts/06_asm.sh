#!/usr/bin/env bash
# task 4.1: one function's asm across variants
#   ./scripts/06_asm.sh fir_filter O0 O3avx
source "$(dirname "$0")/common.sh"
fn="${1:-fir_filter}"; shift || true
make -C "$ROOT" asm > /dev/null
for v in ${@:-O0 O2 O3avx}; do
    out="$ROOT/asm/${fn}_$v.s"
    awk -v f="$fn" '$0 ~ "^"f":" {p=1} p {print} p && $0 ~ "\\.size\t"f {exit}' "$ROOT/asm/sigproc_$v.s" > "$out"
    printf "%-8s %4d lines; SIMD ymm: %3d, xmm-packed(ps/pd): %3d, FMA: %3d  -> %s\n" "$v" \
        "$(wc -l < "$out")" "$(grep -c ymm "$out")" "$(grep -cE '\s(v?(mul|add|sub)p[sd])' "$out")" \
        "$(grep -c vfmadd "$out")" "asm/${fn}_$v.s"
done
echo "Vectorizer report: asm/vecinfo_<variant>.txt"
