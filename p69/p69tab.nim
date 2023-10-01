{.experimental: "strictDefs".}
import strutils, std/cmdline, math

type
  ut = uint
  ft = float

#   ut = uint32
#   ft = float32

let n = block:
  if paramCount() > 0: ut(parseUint(paramStr(1)))
  else: ut(100)

# func sieve(n: ut): seq[ut] =
#   let maxp = ut(sqrt(ft(n)))

#   var
#     primes = newSeqOfCap[ut](maxp+1)
#     sieve = newSeq[bool](n)
#     i = ut(3)

#   add(primes, ut(2))
#   for i in countup(ut(2), n, ut(2)):
#     sieve[i] = true

#   while i <= maxp:
#     if not sieve[i]:
#       add(primes, i)
#       for j in countup(ut(i*i), n, ut(i)):
#         sieve[j] = true
#     i += 2

#   for i in countup(i, n, 2):
#     if not sieve[i]: add(primes, i)

#   return primes

# let primes = sieve(n)

var
  scores = newSeq[ut](n+1)
  maxi = ut(2)
  maxq = ft(2)

for i in 3..n:
  scores[i] = i-1

# for i in 2..n:
#   let lf = block:
#     var v = ut(1)
#     for p in primes:
#       if i mod p == 0:
#         v = p
#         break
#     v

#   echo i, ' ', lf
#   for j in countup(2*i, n, lf):
#     scores[j] -= 1

# echo scores

# for i in 3..n:
#   let q = ft(i)/ft(scores[i])
#   if q > maxq:
#     maxq = q
#     maxi = i

echo maxi
