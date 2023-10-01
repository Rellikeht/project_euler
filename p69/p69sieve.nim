import math, strutils, std/cmdline

type
  # ut* = uint32
  # ft* = float32

  ut* = uint
  ft* = float

let n = block:
  if paramCount() > 0: ut(parseUint(paramStr(1)))
  else: ut(100)

proc sieve(n: ut): seq[ut] =
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

let primes = sieve(n)
echo primes

# for i in 2..<n:
#   var divs = uint(0)
#   for j in primes:
#     discard # TODO

#   if divs > maxv:
#     maxv = divs

# echo maxv
