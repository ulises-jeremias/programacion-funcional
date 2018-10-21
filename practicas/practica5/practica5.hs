import Data.Char (ord, isDigit)

-- 2

sum' :: [Int] -> Int
sum' [] = 0
sum' (x:xs) = x + sum' xs

any' :: [Bool] -> Bool
any' [] = False
any' (x:xs) = x || any' xs

all' :: [Bool] -> Bool
all' [] = True
all' (x:xs) = x && all' xs

codes :: [Char] -> [Int]
codes [] = []
codes (x:xs) = ord x : codes xs

remainders :: [Int] -> Int -> [Int]
remainders [] y = []
remainders (x:xs) y = x `mod` y : remainders xs y

squares :: [Int] -> [Int]
squares [] = []
squares (x:xs) = x*x : squares xs

lengths :: [[a]] -> [Int]
lengths [] = []
lengths (xs:xss) = length xs : lengths xss

order :: [(Int,Int)] -> [(Int,Int)]
order [] = []
order ((x,y):xys) = if x < 3*y
                        then (x,y) : order xys
                        else order xys

pairs :: [Int] -> [Int]
pairs [] = []
pairs (x:xs) = if even x
                    then x : pairs xs
                    else pairs xs

chars :: [Char] -> [Char]
chars [] = []
chars (x:xs) = if not (isDigit x)
                then x : chars xs
                else chars xs

moreThan :: [[a]] -> Int -> [[a]]
moreThan [] n = []
moreThan (xs:xss) n = if length xs > n
                        then xs : moreThan xss n
                        else moreThan xss n