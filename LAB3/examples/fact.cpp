#include <iostream>
using namespace std;

int fact(int n) {
    if (n <= 1)
        return 1;
    return n * fact(n - 1);
}

int fib(int n) {
    int a = 0, b = 1;
    for (int i = 0; i < n; i++) {
        int t = a + b;
        a = b;
        b = t;
    }
    return a;
}

int main() {
    for (int i = 0; i <= 10; i++)
        cout << i << "! = " << fact(i) << endl;
    cout << "fib(30) = " << fib(30) << endl;
    return 0;
}
