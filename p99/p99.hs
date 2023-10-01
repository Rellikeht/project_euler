base = 2

main = do
 nums <- readFile "p099_base_exp.txt"
 print (getB nums)

getB :: [Char] -> [Int]
getB str = bg [1,1] (map pr (split '\n' str))

pr :: [Char] -> [Int]
pr str = [read n1,read n2]
 where
  n1 = head sp
  n2 = head (tail sp)
  sp = split ',' str

split :: Char -> [Char] -> [[Char]]
split c [] = []
split c str = [tc]++(split c ac)
 where
  tc = takeWhile (/=c) str
  dc = dropWhile (/=c) str
  ac
   | (dc==[]) = []
   | otherwise = tail dc

bg :: [Int] -> [[Int]] -> [Int]
bg n [] = n
bg n (p:l)
 | (pn>mn) = bg p l
 | otherwise = bg n l
 where
  pn = makeNum p
  mn = makeNum n

makeNum :: [Int] -> Double
makeNum [0,0] = 0
makeNum [1,1] = 1
makeNum n = b*e
 where
  b = logBase base (fromIntegral (head n))
  e = fromIntegral (head (tail n))
