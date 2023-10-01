import Data.List

-- genFracs 1 = [[]]
-- genFracs n = map (genFrac n) [1..n]

-- genFrac n x = [(x,y) | y <- [1..n], chk x y]

-- chk 1 1 = False
-- chk 1 x = True
-- chk x y
--  | x>y = False
--  | gcd x y /= 1 = False
--  | otherwise = True

-- main = print (genFracs 8)


-- genFracs 1 [] = []
-- genFracs n [] = (genFracs (n-1) []) ++ (map (genFrac n) [1..n-1])
-- 
-- genFrac n x = [(x,y) | y <- [1..n], chk x y]
-- 
-- chk 1 1 = False
-- chk 1 x = True
-- chk x y
--  | (x>y) = False
--  | ((gcd x y) /= 1) = False
--  | otherwise = True
-- 
-- main = print (genFracs 8 [])

-- main = print ""
