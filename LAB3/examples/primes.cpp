#include <iostream>
using namespace std;

int count = 0;

bool isPrime(int n) {
    if (n < 2) return false;
    for (int d = 2; d * d <= n; d++)
        if (n % d == 0) return false;
    return true;
}

int main() {
    for (int n = 1; n < 50; n++) {
        if (!isPrime(n)) continue;
        cout << n << " ";
        count += 1;
    }
    cout << endl << "total: " << count << endl;

    // dangling else: belongs to the inner if
    int x = 5;
    if (x > 0)
        if (x > 10) cout << "big" << endl;
        else cout << "small" << endl;

    // int vs double division
    cout << 7 / 2 << " " << -7 / 2 << " " << -7 % 3 << " " << 7 / 2.0 << endl;
    return 0;
}
