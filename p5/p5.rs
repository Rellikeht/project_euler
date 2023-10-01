// type Numt = i32;
type Numt = u64;
type Rest = u64;

// This should be iterator
pub fn primes(n: usize) -> Vec<Numt> {

    // This probably up to sqrt of n
    // And should be in main loop
    let mut prs = Vec::with_capacity((Numt::ilog2(n as Numt)*2+1) as usize);

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
    let mut mults = Vec::with_capacity(prs.len());

    // This definitely up to sqrt of n
    mults.resize(prs.len(), 1);

    // Something gere up to sqrt of n probably
    for mut i in 4..(num+1) as Numt {
        // let mut p = 0;
        while i > 1 {
            for j in 0..prs.len() {
                let mut m = 0;
                while i % prs[j] == 0 {
                    i /= prs[j];
                    m += 1;
                }
                mults[j] = Numt::max(mults[j], m);
            }
        }
    }

    // println!("{:?}", prs);
    // println!("{:?}", mults);
    let mut result = 1 as Rest;
    // This multiplication alone is probably not that great
    for m in 0..mults.len() { result *= prs[m].pow(mults[m] as u32) as Rest; }

    println!("{}", result);
    // println!("{:?}", prs);
}
