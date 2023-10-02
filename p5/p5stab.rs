// type Numt = i32;
type Numt = u64;
type Rest = u64;

// Now this must be iterator !!
pub fn primes(n: usize) -> Vec<Numt> {

    let cap = (8*n)/(Numt::ilog2(n as Numt)*5) as usize;
    let mut prs = Vec::with_capacity(cap);

    let n = n+1;
    let mut sieve = Vec::with_capacity(n);
    sieve.resize(n, true);
    prs.push(2);

    for i in (4..n).step_by(2) {
        sieve[i] = false;
    }

    let mut i = 3;
    let stop = f64::ceil(f64::sqrt(n as f64)) as usize;

    while i < stop {
        if sieve[i] {
            prs.push(i as Numt);
            for j in (i*i..n).step_by(i) {
                sieve[j] = false;
            }
        }
        i += 2;
    }

    for i in (i..n).step_by(2) {
        if sieve[i] { prs.push(i as Numt); }
    }

    return prs;
}

pub fn main() {
    let nums = std::env::args().nth(1).unwrap_or("20".to_string());
    let num: usize = nums.parse().unwrap_or(20);
    let prs = primes(num);

    let mut result = 1 as Rest;
    let mut log = 2;
    let mut p = 0;

    while log > 1 && p < prs.len() {
        log = (num as Rest).ilog(prs[p]);
        result *= Rest::pow(prs[p], log);
        p += 1;
    }

    while p < prs.len() {
        result *= prs[p];
        p += 1;
    }

    println!("{}", result);
}
