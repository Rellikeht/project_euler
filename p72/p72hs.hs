import System.Environment

amount :: [String] -> Int
amount [] = 1000
amount (x:_) = read x

phi :: Int -> Int
phi n = loop (n-1) 0
 where
  loop 1 a = a+1
  loop m a = loop (m-1) na
   where
    na = if gcd n m == 1 then a+1 else a

main = do
 args <- getArgs
 print $ sum $ map phi [2..amount args]
 -- print $ fracs $ amount args
