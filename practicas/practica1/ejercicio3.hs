--power4 x = let sqr y = y * y in sqr (sqr x)

power4_a :: Integer -> Integer
power4_a x = x * x * x * x

power4_b :: Integer -> Integer
power4_b x = sqr (sqr x) where sqr y = y * y
