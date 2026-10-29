// tricky cases for the python codegen
#include <iostream>
using namespace std;

int g;

int sq(int x) { return x * x; }

int main() {
    int i = 0, s = 0;
    double d = 7;

    // continue in for must still run the step
    for (;;) {
        i++;
        if (i % 2 == 0) continue;
        if (i > 9) break;
        s += i;
    }
    while (i > 0) {
        i -= 3;
        if (i == 4) continue;
        g++;
    }

    int k = d / 2;      // 3.5 -> 3
    bool b = sq(3);     // 9 -> true
    cout << s << " " << g << " " << k << " " << b << " " << d / 4 << " " << !b << endl;

    int lambda = 3;     // python keyword
    lambda *= 2.5;
    cout << lambda << " " << (1 < 2 && 3 > 4 || true) << endl;

    // block scope
    {
        int i = 100;
        cout << i << endl;
    }
    cout << i << endl;
    return 0;
}
