import strutils, std/cmdline, strformat
import math

type
  # ut = uint32
  # ft = float32

  ut = uint
  ft = float

let n = block:
  if paramCount() > 0: ut(parseUint(paramStr(1)))
  else: ut(100)

# Slower !!!
# func isgcd(a, b, k: ut): ut =
#   # debugEcho a, ' ', b
#   if a == 0 or a == b: return b*(ut(2)^k)
#   if a mod 2 == 0:
#     if b mod 2 == 0: return isgcd(a div 2, b div 2, k+1)
#     return isgcd(a div 2, b, k)
#   if b mod 2 == 0: return isgcd(a, b div 2, k)
#   return isgcd(ut(abs(int(a)-int(b))) div 2, min(a, b), k)

# func sgcd(a, b: ut): ut =
#   if a == 0: return b
#   if b == 0: return a
#   return isgcd(a, b, 0)

# func phi(n: ut): ut {.inline.} =
#   var val = ut(1)
#   for i in 2..(n-1) div 2:
#     if sgcd(n, i) == 1:
#       val += 1
#   return val*2

func phi(n: ut): ut {.inline.} =
  var val = ut(1)
  for i in 2..(n-1) div 2:
    if gcd(n, i) == 1:
      val += 1

  # return val
  return val*2

var
  maxq = ft(2)
  maxi = ut(2)
  minp = ut(1)

for i in ut(3)..n:
  # echo i
  let
    p = phi(i)
    q = ft(i)/ft(p)
  if q > maxq:
    echo &"{i} {p} {i div maxi} {p div minp} {q}"
    maxq = q
    maxi = i
    minp = p

echo maxi
