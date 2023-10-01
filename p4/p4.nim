{.experimental: "strictDefs".}

type
  atype = int32
  itype = int32

func isPalindrome(n: itype): bool {.inline.} =
  var
    digs: array[6, atype] = default(array[6, atype])
    i = itype(0)
    j = itype(0)
    n = n

  while n > 0:
    digs[i] = atype(n mod 10)
    n = n div 10
    i += itype(1)

# Slower !?
#   i -= itype(1)
#   while i > j:
#     if digs[i] != digs[j]: return false
#     i -= itype(1)
#     j += itype(1)

  while i > j:
    i -= itype(1)
    if digs[i] != digs[j]: return false
    j += itype(1)

  return true

var maxp = itype(0)

for i in countdown(itype(999), 100, 1):
  # Gives nothing
  # if i*1024 <= maxp: break

  let m = i * i
  if m <= maxp: break
  if isPalindrome(m):
    maxp = m
    continue

  for j in countdown(i-1, 100, 1):
    let m = i * j
    if m <= maxp: break
    if isPalindrome(m):
      maxp = m
      break

echo maxp
