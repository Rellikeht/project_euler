{.experimental: "strictDefs".}
import strutils, std/cmdline, tables

let n = block:
  if paramCount() > 0: parseUint(paramStr(1))
  else: 100

var gcdmem = initTable[(uint, uint), uint](int(n))

proc mgcd(a, b: uint): uint =
  let m = a mod b
  if m == 0: return b
  if hasKey(gcdmem, (a, b)): return gcdmem[(a, b)]
  let mval = mgcd(b, m)
  gcdmem[(a, b)] = mval
  return mval

proc gcd(a, b: uint): uint {.inline.} =
  if a > b: return mgcd(a, b)
  else: return mgcd(b, a)

proc phi(n: uint): uint =
  var val = uint(1)

  for i in 2..n:
    if gcd(n, i) == 1:
      val += 1

  return val

var
  maxq = float(1)
  maxi = uint(1)

for i in uint(2)..n:
  let q = float(i)/float(phi(i))
  if q > maxq:
    maxq = q
    maxi = i

echo maxi
