// type Numt = i32;
type Numt = u64;

pub fn main() {

    let nums = std::env::args().nth(1).unwrap_or("20".to_string());
    let num = nums.parse().unwrap_or(20);
    let num1 = (num+1) as usize;

    let mut sieve = Vec::with_capacity(num1);
    sieve.resize(num1, true);
    for i in (4..num).step_by(2) { sieve[i as usize] = false; }

    let stop = f64::ceil(f64::sqrt(num as f64)) as usize;
    let mut i = 3 as usize;
    let mut result = Numt::pow(2, (num as Numt).ilog(2));
    let mut log = 0;

    while i < stop {
        if sieve[i] {
            for j in (i*i..num).step_by(i) { sieve[j] = false; }
            log = (num as Numt).ilog(i as Numt);
            result *= Numt::pow(i as Numt, log);
        }
        i += 2;
    }

    while log > 1 && i < num {
        if sieve[i] {
            log = (num as Numt).ilog(i as Numt);
            result *= Numt::pow(i as Numt, log);
        }
        i += 2;
    }

    for i in (i..num).step_by(2) { if sieve[i] { result *= i as Numt; } }
    println!("{}", result);
}
