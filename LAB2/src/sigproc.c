/* Lab 2: five-stage signal processing pipeline.
 * Usage: ./sigproc [rounds] [log2n] [grid] */
#define _POSIX_C_SOURCE 200809L
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* noinline keeps the stages separate on the FlameGraph */
#ifdef ALLOW_INLINE
#define STAGE
#else
#define STAGE __attribute__((noinline))
#endif

#define FIR_TAPS 48
#define HIST_BINS 4096

static double now_sec(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

static void *xalloc(size_t bytes)
{
    /* aligned for AVX */
    void *p = aligned_alloc(64, (bytes + 63) & ~(size_t)63);
    if (!p) {
        perror("aligned_alloc");
        exit(1);
    }
    return p;
}

/* 1. signal generation (xorshift, not vectorizable) */
STAGE void synth_signal(float *x, int n, uint32_t *state)
{
    uint32_t s = *state;
    for (int i = 0; i < n; i++) {
        s ^= s << 13;
        s ^= s >> 17;
        s ^= s << 5;
        float noise = (float)(s & 0xFFFF) / 65536.0f - 0.5f;
        float trend = (float)(i & 1023) / 1024.0f;
        x[i] = trend + 0.25f * noise;
    }
    *state = s;
}

/* 2. FIR filter; loops swapped so the inner one vectorizes (FMA) */
STAGE void fir_filter(float *restrict y, const float *restrict x,
                      const float *restrict h, int n)
{
    memset(y, 0, (size_t)n * sizeof(float));
    for (int k = 0; k < FIR_TAPS; k++) {
        const float c = h[k];
        const float *xs = x + k;
        for (int i = 0; i < n; i++)
            y[i] += c * xs[i];
    }
}

/* 3. heat diffusion, 5-point stencil */
STAGE void heat_step(float *restrict dst, const float *restrict src, int g, float a)
{
    for (int r = 1; r < g - 1; r++) {
        const float *up = src + (size_t)(r - 1) * g;
        const float *mid = src + (size_t)r * g;
        const float *dn = src + (size_t)(r + 1) * g;
        float *out = dst + (size_t)r * g;
        for (int c = 1; c < g - 1; c++)
            out[c] = mid[c] + a * (up[c] + dn[c] + mid[c - 1] + mid[c + 1] - 4.0f * mid[c]);
    }
}

/* 4. histogram (not vectorizable) */
STAGE void quantize_hist(const float *x, int n, uint32_t *hist, float lo, float hi)
{
    const float scale = (float)HIST_BINS / (hi - lo);
    for (int i = 0; i < n; i++) {
        int b = (int)((x[i] - lo) * scale);
        if (b < 0)
            b = 0;
        if (b >= HIST_BINS)
            b = HIST_BINS - 1;
        hist[b]++;
    }
}

/* 5. checksum; vectorized only with -ffast-math */
STAGE double checksum(const float *x, int n)
{
    double s = 0.0;
    for (int i = 0; i < n; i++)
        s += x[i];
    return s;
}

int main(int argc, char **argv)
{
    int rounds = argc > 1 ? atoi(argv[1]) : 30;
    int log2n = argc > 2 ? atoi(argv[2]) : 22;
    int grid = argc > 3 ? atoi(argv[3]) : 1536;
    if (rounds < 1 || log2n < 10 || log2n > 28 || grid < 16) {
        fprintf(stderr, "usage: %s [rounds>=1] [log2n 10..28] [grid>=16]\n", argv[0]);
        return 2;
    }
    const int n = 1 << log2n;

    float *sig = xalloc(((size_t)n + FIR_TAPS) * sizeof(float));
    float *flt = xalloc((size_t)n * sizeof(float));
    float *h = xalloc(FIR_TAPS * sizeof(float));
    float *ga = xalloc((size_t)grid * grid * sizeof(float));
    float *gb = xalloc((size_t)grid * grid * sizeof(float));
    uint32_t *hist = xalloc(HIST_BINS * sizeof(uint32_t));

    /* triangular window, sums to 1 */
    float hs = 0.0f;
    for (int k = 0; k < FIR_TAPS; k++) {
        h[k] = (float)(k < FIR_TAPS / 2 ? k + 1 : FIR_TAPS - k);
        hs += h[k];
    }
    for (int k = 0; k < FIR_TAPS; k++)
        h[k] /= hs;

    /* hot square in the middle */
    memset(ga, 0, (size_t)grid * grid * sizeof(float));
    for (int r = grid / 3; r < 2 * grid / 3; r++)
        for (int c = grid / 3; c < 2 * grid / 3; c++)
            ga[(size_t)r * grid + c] = 100.0f;
    memcpy(gb, ga, (size_t)grid * grid * sizeof(float));

    double t_syn = 0, t_fir = 0, t_heat = 0, t_hist = 0, t_sum = 0;
    double acc = 0.0;
    uint32_t seed = 0x9E3779B9u;
    const int heat_iters = 8;

    for (int r = 0; r < rounds; r++) {
        double t0 = now_sec();
        synth_signal(sig, n + FIR_TAPS, &seed);
        double t1 = now_sec();
        fir_filter(flt, sig, h, n);
        double t2 = now_sec();
        for (int it = 0; it < heat_iters; it++) {
            heat_step(gb, ga, grid, 0.2f);
            float *tmp = ga;
            ga = gb;
            gb = tmp;
        }
        double t3 = now_sec();
        memset(hist, 0, HIST_BINS * sizeof(uint32_t));
        quantize_hist(flt, n, hist, -0.2f, 1.2f);
        double t4 = now_sec();
        acc += checksum(flt, n) + checksum(ga, grid * grid) * 1e-6;
        double t5 = now_sec();

        t_syn += t1 - t0;
        t_fir += t2 - t1;
        t_heat += t3 - t2;
        t_hist += t4 - t3;
        t_sum += t5 - t4;
    }

    /* so the compiler can't drop the work */
    uint64_t hsig = 0;
    for (int b = 0; b < HIST_BINS; b++)
        hsig = hsig * 31 + hist[b];

    double total = t_syn + t_fir + t_heat + t_hist + t_sum;
    printf("rounds=%d  n=2^%d  grid=%dx%d  taps=%d\n", rounds, log2n, grid, grid, FIR_TAPS);
    printf("%-14s %9s %7s\n", "stage", "time, s", "share");
    printf("%-14s %9.3f %6.1f%%\n", "synth_signal", t_syn, 100 * t_syn / total);
    printf("%-14s %9.3f %6.1f%%\n", "fir_filter", t_fir, 100 * t_fir / total);
    printf("%-14s %9.3f %6.1f%%\n", "heat_step", t_heat, 100 * t_heat / total);
    printf("%-14s %9.3f %6.1f%%\n", "quantize_hist", t_hist, 100 * t_hist / total);
    printf("%-14s %9.3f %6.1f%%\n", "checksum", t_sum, 100 * t_sum / total);
    printf("%-14s %9.3f\n", "TOTAL", total);
    printf("result: acc=%.6e  hist=%016llx\n", acc, (unsigned long long)hsig);

    free(sig);
    free(flt);
    free(h);
    free(ga);
    free(gb);
    free(hist);
    return 0;
}
