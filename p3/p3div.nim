import strutils

var
  n = parseUint(readline(stdin))
  cmax = uint(0)
  i = uint(3)

func divs(n, cmax: var uint, i: uint) {.inline.} =
  if n mod i == 0:
    cmax = i
    n = n div i
  while n mod i == 0: n = n div i

template ext(a: uint) =
  if n == 1: break
  i += a

divs(n, cmax, 2)
divs(n, cmax, 5)

if n != 1:
  while true:
    divs(n, cmax, i)
    ext(4)
    divs(n, cmax, i)
    ext(2)
    divs(n, cmax, i)
    ext(2)
    divs(n, cmax, i)
    ext(2)

echo cmax
