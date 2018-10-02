data Bool = False | True

seven x = 7


sign :: Integer -> Integer

-- if then else
sign 0 = 0
sign x = if x > 0 then 1 else -1

-- sin guardas (sin abs)
sign 0 = 0
sign x = x / sqrt(x^2)

-- sin guardas
sign 0 = 0
sign x = x / abs x -- usar otra por el ejercicio de 'absolute'

-- con guardas
sign x
  | x = 0 = 0
  | x > 0 = 1
  | x < 0 = -1


absolute :: Integer -> Integer

-- sin guardas
absolute x
  | x >= 0 = x
  | x < 0 = -x

-- con guardas
absolute x = if x >= 0 then x else -x

-- usando sign
absolute x = x * sign x

-- sin llamado
absolute x = sqrt(x^2)

and' :: Bool -> Bool -> Bool
or' :: Bool -> Bool -> Bool
not' :: Bool -> Bool
xor' :: Bool -> Bool -> Bool

--and'
and' x y = if x then y else False

-- con guardas
and' x y
  | x         = y
  | otherwise = False

or' x y = if x the True else y

-- con guardas
or' x y
  | x         = True
  | otherwise = y

not' x = if x then False else True

--con guardas
not' x
  | x         = False
  | otherwise = true

xor' x y = if x == y then True else False

-- con guardas
xor' x y
  | x == y = True
  | x /= y = False

isZero :: Integer -> Bool
isZero x = x == 0

dividesTo :: Integer -> Integer -> Bool
dividesTo x y = isZero $ mod y x

isMultiple :: Integer -> Integer -> Bool
isMultiple x y
  | y == 0    = True
  | x > y     = dividesTo y x
  | otherwise = dividesTo x y

isCommonDivisor :: Integer -> (Integer, Integer) -> Bool
isCommonDivisor n (x, y)
  | dividesTo n x = dividesTo n y
  | otherwise     = False

isCommonMult :: Integer -> (Integer, Integer) -> Bool
isCommonMult x (w,q)
  | isMultiplo x w    = isMultiplo x q
  | otherwise         = False

swap (x,y) = (y,x)
