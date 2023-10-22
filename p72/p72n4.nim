import std/cmdline, strutils, math

type itype = int

when not defined bl:
  static:
    echo "Not bool"
else:
  static:
    echo "Bool"

iterator sieve(n: itype): itype =
  let
    maxp = itype(sqrt(float64(n)))

  var
    sieve = newSeq[bool](n)
    i = itype(3)

  yield itype(2)
  for i in countup(2, n, 2):
    sieve[i] = true

  # Important <= for optimization, weird
  while i <= maxp:
    if not sieve[i]:
      yield i
      for j in countup(i*i, n, 2*i):
        sieve[j] = true
    i += 2

  for i in countup(i, n, 2):
    if not sieve[i]: yield i

let
  n =
    if paramCount() > 0: parseInt(paramStr(1))
    else: 1000

when not defined bl:
  var used = newSeq[itype](n+1)
else:
  var used = newSeq[bool](n+1)

var
  sum = n*(n+1) div 2 - n
  factors = newSeq[seq[itype]](n+1)

for p in sieve(n):
  for i in countup(p, itype(n), p):
    add(factors[int(i)], p)

for i in 2..n:
  for f in factors[i]:
    for j in countup(i+f, n, f):

      when not defined bl:
        if used[j] != i:
          used[j] = itype(i)
          sum -= 1

      else:
        if not used[j]:
          used[j] = true
          sum -= 1

  when defined bl:
    for i in i..<len(used): used[i] = false

echo sum
