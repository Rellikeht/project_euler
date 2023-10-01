import math, strutils, std/cmdline

type
  ut = uint32
  ft = float32

let n = block:
  if paramCount() > 0: ut(parseUint(paramStr(1)))
  else: ut(100)

func phi(n: ut): ut {.inline.} =
  var val = ut(1)
  for i in 2..(n-1) div 2:
    if gcd(n, i) == 1:
      val += 1
  return val*2

var
  # No gain
  maxv = (ut(2), ft(2))

#   maxq = ft(2)
#   maxi = ut(2)

for i in ut(3)..n:
  let q = ft(i)/ft(phi(i))
  if q > maxv[1]:
    maxv = (i, q)

#   if q > maxq:
#     maxq = q
#     maxi = i

echo maxv[0]
# echo maxi
