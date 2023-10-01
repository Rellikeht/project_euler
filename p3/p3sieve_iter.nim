import strutils, math

var
  n = parseUint(readline(stdin))
  cmax = uint(0)

iterator sieve(n: uint): uint =
  let
    maxp = uint(sqrt(float64(n)))
    maxc = uint(sqrt(float64(maxp)))

  var
    sieve = newSeq[bool](maxp)
    i = uint(3)

  yield 2
  for i in countup(uint(2), maxp-1, uint(2)):
    sieve[i] = true

  while i < maxc:
    if not sieve[i]:
      yield i
      for j in countup(uint(i*i), maxp-1, uint(i)):
        sieve[j] = true
    i += 2

  for i in countup(i, maxp-1, 2):
    if not sieve[i]: yield i

func divs(n, cmax: var uint, i: uint) {.inline.} =
  if n mod i == 0:
    cmax = i
    n = n div i
  while n mod i == 0: n = n div i

for i in sieve(n):
  divs(n, cmax, i)
  # if n < i: break

if n > cmax: echo n
else: echo cmax
