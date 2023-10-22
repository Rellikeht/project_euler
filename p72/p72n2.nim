import std/cmdline, strutils, math

# Nothing changed
# type itype = int32
type itype = int

proc sieve(n: itype): seq[itype] =
  let
    maxp = itype(sqrt(float64(n)))
    startAm = itype((8 div 5) * (n div int(ln(float(n)))))

  var
    primes = newSeqOfCap[itype](startAm)
    sieve = newSeq[bool](n)
    i = itype(3)

  add(primes, itype(2))
  for i in countup(2, n, 2):
    sieve[i] = true

  while i <= maxp:
    if not sieve[i]:
      add(primes, i)
      for j in countup(i*i, n, 2*i):
        sieve[j] = true
    i += 2

  for i in countup(i, n, 2):
    if not sieve[i]: add(primes, i)

  return primes

let
  n =
    if paramCount() > 0: parseInt(paramStr(1))
    else: 1000
  primes = sieve(itype(n))

var
  # used = newSeq[bool](n+1)
  used = newSeq[int](n+1)
  sum = n*(n+1) div 2 - n

for i in 2..n:
  var
    num = i
    np = 0

  while num > 1:
    let p = primes[np]

    if num mod p == 0:
      while num mod p == 0: num = num div p
      for j in countup(i+p, n, p):
        # if not used[j]:
        if used[j] != i:
          sum -= 1
          # used[j] = true
          used[j] = i

    np += 1
  # for i in i..<len(used): used[i] = false

echo sum
