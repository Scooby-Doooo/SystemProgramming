#include <iostream>
using namespace std;

int a[10];

void fill(int n) {
    int seed = 7;
    for (int i = 0; i < n; i++) {
        seed = (seed * 31 + 11) % 100;
        a[i] = seed;
    }
}

void print(int n) {
    for (int i = 0; i < n; i++)
        cout << a[i] << " ";
    cout << endl;
}

int main() {
    int n = 10;
    fill(n);
    print(n);

    bool swapped = true;
    while (swapped) {
        swapped = false;
        for (int i = 0; i + 1 < n; i++) {
            if (a[i] > a[i + 1]) {
                int t = a[i];
                a[i] = a[i + 1];
                a[i + 1] = t;
                swapped = true;
            }
        }
    }
    print(n);

    double avg = 0;
    for (int i = 0; i < n; i++) avg += a[i];
    avg /= n;
    cout << "avg = " << avg << endl;
    return 0;
}
