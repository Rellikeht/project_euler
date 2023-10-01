import math, strutils, std/cmdline

let n = block:
  if paramCount() > 0:
    parseUint(paramStr(1))
  else:
    100

func phi(n: uint): uint =
  var val = uint(2)
  for i in 2..n-2:
    if gcd(n, i) == 1:
      val += 1
  return val

var
  maxq = float(2)
  maxi = uint(2)

for i in uint(3)..n:
  let q = float(i)/float(phi(i))
  if q > maxq:
    maxq = q
    maxi = i

echo maxi
