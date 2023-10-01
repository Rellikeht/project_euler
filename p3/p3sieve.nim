import strutils, math

var
  n = parseUint(readline(stdin))
  cmax = uint(0)

proc sieve(n: uint): seq[uint] =
  let
    maxp = uint(sqrt(float64(n)))
    maxc = uint(sqrt(float64(maxp)))

  var
    primes = newSeqOfCap[uint](maxp)
    sieve = newSeq[bool](maxp)
    i = uint(3)

  add(primes, uint(2))
  for i in countup(uint(2), maxp-1, uint(2)):
    sieve[i] = true

  while i < maxc:
    if not sieve[i]:
      add(primes, i)
      for j in countup(uint(i*i), maxp-1, uint(i)):
        sieve[j] = true
    i += 2

  for i in countup(i, maxp-1, 2):
    if not sieve[i]: add(primes, i)

  return primes

func divs(n, cmax: var uint, i: uint) {.inline.} =
  if n mod i == 0:
    cmax = i
    n = n div i
  while n mod i == 0: n = n div i

let primes = sieve(n)
# echo primes[^1]
# quit 0

for i in primes:
  divs(n, cmax, i)
  # if n < i: break

if n > cmax: echo n
else: echo cmax
