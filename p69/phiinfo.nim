import math, strutils, std/cmdline, strformat

type
  ut* = uint32
  ft* = float32

let n* = block:
  if paramCount() > 0: ut(parseUint(paramStr(1)))
  else: ut(100)

proc phi*(n: ut): ut {.inline.} =
  var val = ut(1)

  for i in 2..(n-1):
    if gcd(n, i) == 1:
      stdout.write ", "
      stdout.write i
      val += 1

  echo ""
  return val

echo &"Num: n"
stdout.write &"Relatively prime: 1"
let p = phi(n)
echo &"Phi: {p}, quotient: {ft(n)/ft(p)}"
