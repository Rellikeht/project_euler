import std/cmdline, strutils, sugar, math

proc sieve(n: int): seq[int] =
  let
    maxp = int(sqrt(float64(n)))
    maxc = int(sqrt(float64(maxp)))

  var
    primes = newSeqOfCap[int](maxp)
    sieve = newSeq[bool](maxp)
    i = int(3)

  add(primes, int(2))
  for i in countup(int(2), maxp-1, int(2)):
    sieve[i] = true

  while i < maxc:
    if not sieve[i]:
      add(primes, i)
      for j in countup(int(i*i), maxp-1, int(i)):
        sieve[j] = true
    i += 2

  for i in countup(i, maxp-1, 2):
    if not sieve[i]: add(primes, i)

  return primes


let
  n =
    if paramCount() > 0: parseInt(paramStr(1))
    else: 1000
  primes = sieve(n)

var
  phis = collect(newSeq):
    for i in 0..n: i-1
  sum = 0

for i in primes:
  for j in countup(2*i, n, i):
      phis[j] -= j div i - 1

echo phis
for i in 2..n:
  sum += phis[i]

echo sum
