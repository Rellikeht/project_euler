{.experimental: "strictDefs".}
import strutils, std/cmdline, math

type
  ut = uint
  ft = float

let n = block:
  if paramCount() > 0: ut(parseUint(paramStr(1)))
  else: ut(100)

func sieve(n: ut): seq[ut] =
  let maxp = ut(sqrt(ft(n)))

  var
    primes = newSeqOfCap[ut](maxp+1)
    sieve = newSeq[bool](n)
    i = ut(3)

  add(primes, ut(2))
  for i in countup(ut(2), n, ut(2)):
    sieve[i] = true

  while i <= maxp:
    if not sieve[i]:
      add(primes, i)
      for j in countup(ut(i*i), n, ut(i)):
        sieve[j] = true
    i += 2

  for i in countup(i, n, 2):
    if not sieve[i]: add(primes, i)

  return primes

let primes = sieve(ut(log2(float(n)))*2+1)

var
  mult = primes[0]
  i = 1

while mult < n:
  mult *= primes[i]
  i += 1

i -= 1
mult = mult div primes[i]

echo mult
