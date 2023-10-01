#include <cstdint>
#include <iostream>

#include <algorithm>
/* #include <numeric> */

typedef std::uint64_t intT;
using namespace std;

/* intT lcm(intT a, intT b) { */
/*     /1* return (a*b)/std::__gcd(a, b); *1/ */

/* /1*     intT res = a*b; *1/ */
/* /1*     return res/std::__gcd(a, b); *1/ */

/*     intT res = b/std::__gcd(a, b); */
/*     return a*res; */
/* } */

intT getHugeLcm(intT n) {
    intT lcmm = 1;
    for(intT i=2; i<=n; i++) {
        /* lcmm = lcm(i, lcmm); */

        // gcd is up to 30% slower than __gcd
        /* lcmm = (i*lcmm)/std::gcd(i, lcmm); */
        /* lcmm = (i*lcmm)/std::__gcd(i, lcmm); */
        lcmm = i*(lcmm/std::__gcd(i, lcmm));
    }
    return lcmm;
}

int main(int argc, char **argv) {
    int n = 20;

    if (argc > 1) {
        int av = atoi(argv[1]);
        if (av > 0) n = av;
    }

    cout << getHugeLcm(n) << endl;
}
