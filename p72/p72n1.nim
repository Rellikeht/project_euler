import std/cmdline, strutils, sugar

# const start = 3

let n =
  if paramCount() > 0: parseInt(paramStr(1))
  else: 1000

var
  phis = collect(newSeq):
    for i in 2..n: i-1
  sum = 0

for i in 2..n:
  for j in countup(2*i, n, i):
    phis[j-2] -= j-2

echo phis
for i in phis: sum += i
echo sum
