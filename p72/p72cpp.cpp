#include <iostream>
#include <algorithm>
#include <numeric>
using namespace std;

inline long long phi(int n) {
    int a = 1;
    for (int i = 2; i < n; i++)
    {
        if (gcd(i, n) == 1) a += 1;
    }
    return a;
}

int main(int argc, char **argv) {
    int n = 1000;
    if (argc > 1) n = atoi(argv[1]);
    long long sum = 0;

    for (int i = 2; i <= n; i++) {
        /* cout << phi(i) << endl; */
        sum += phi(i);
    }
    cout << sum << endl;

    return 0;
}
