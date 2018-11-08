import Data.Char (ord, isAlpha)

recr f z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

----------------------------------------------------------------

sum' :: [Int] -> Int
sum' = foldr (+) 0

any' :: [Bool] -> Bool
any' = foldr (||) False

all' :: [Bool] -> Bool
all' = foldr (&&) True

codes :: [Char] -> [Int]
-- codes = map ord
codes = foldr ((:) . ord) []

remainders :: [Int] -> Int -> [Int]
remainders = flip (\r -> foldr ((:) . \x -> (x `mod` r)) [])

squares :: [Int] -> [Int]
-- squares = map (^2)
squares = foldr ((:) . (^2)) []

lengths :: [[a]] -> [Int]
-- lengths = map length
lengths = foldr ((:) . length) []

order :: [(Int,Int)] -> [(Int,Int)]
-- order = filter (\(x,y) -> x < (3 * y))
order = foldr (\(x,y) n -> if x < (3*y) then (x,y):n else n) []

pairs :: [Int] -> [Int]
-- pairs = filter even
pairs = foldr (\x xs -> if even x then x : xs else xs) []

chars :: [Char] -> [Char]
-- chars = filter isAlpha
chars = foldr (\x xs -> if isAlpha x then x : xs else xs) []

moreThan :: [[a]] -> Int -> [[a]]
moreThan = flip (\n -> foldr (\xs xss -> if length xs > n then xs : xss else xss) [])

----------------------------------------------------------------

pal :: [Char] -> Bool
pal x = x == reverse x

hs :: [[Char]] -> Int
-- hs = foldr (\x n -> if head x == 'h' then n + 1 else n) 0
hs = length . (filter (\x -> head x == 'h'))

avgLength :: [[Char]] -> Int
-- avgLength xss = div (sum (map length xss)) (length xss)
avgLength xss = 
    let 
        xssLengths = lengths xss
    in 
        sum xssLengths `div` length xssLengths

avgLength' :: [[Char]] -> Int
avgLength' xss =
    let
        a = foldr (\x (s, c) -> (s + length x, c + 1)) (0, 0) xss
    in
        fst a `div` snd a

adjacents :: [a] -> [(a,a)]
adjacents (x:[]) = []
adjacents (x:xs) = (x, head xs) : adjacents xs

adjacents' :: [a] -> [(a,a)]
adjacents' xs = recr f [] xs
    where f x xs recXs = if length xs /= 0
                            then (x, head xs) : recXs
                            else recXs

remDups [] = []
remDups (x:xs) = x:remDups (filter (not . (== x )) xs)

primes::Int -> [Int]
primes 0 = []
primes n = if (isPrime (abs n)) 
            then n:(primes ((abs n) - 1)) 
            else primes ((abs n) - 1)

isPrime:: Int -> Bool
isPrime n = dividesAny n (n - 1)

dividesAny:: Int -> Int -> Bool
dividesAny 1 n = False
dividesAny n 1 = True
dividesAny n s = (not (mod n s == 0)) && (dividesAny n (s - 1))