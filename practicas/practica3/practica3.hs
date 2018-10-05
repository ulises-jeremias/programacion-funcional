-- | ejercicio1

--  1
myand x y = x && y -- total
partialAnd x = and x -- parcial

-- 2 
firstOne x y = x
primary x = firstOne x

-- 3
ej3_1a3 x y z=(x z, y z)

-- 4
ej3_1a4 x y = x + y

-- 5
ej3_1a5 x y = x y  +  y

-- 6
ej3_1a6 x y z= x z y

-- | ejercicio2

-- a funo está currificada
-- b fdos está currificada
-- c ftres no está currificada

-- | ejercicio3
-- f_operador## y = y##x

-- | ejercicio5
-- a
twice = \f -> \x -> f (f x)
-- b
flip = \f -> \x -> \y -> f y x
-- c
inc2 = (+2)
inc = \x -> x + 1

-- | ejercicio6
-- a
-- fix :: ((a->b)->a->b)->a->b
fix f x = f (fix f) x

-- b
-- fork (fork, fork) (fork, fork) :: ((t1 -> t2, t1 -> t3) -> (t1 -> (t2, t3), t1 -> (t2, t3)), (t1 -> t2, t1 -> t3) -> (t1 -> (t2, t3), t1 -> (t2, t3))) 
-- fork :: (a -> b, a -> c) -> a -> (b, c)
fork (f, g) x = (f x, g x)

-- c
-- apply apply apply :: (t1 -> t2) -> t1 -> t2
-- apply :: (a -> b) -> a -> b
apply f x = f x

-- | ejercicio8
--  -2

-- | ejercicio9
non_defined x = x + x + sqrt (-1)

-- | ejercicio10
-- a falsa
-- b verdadera
-- c falsa

-- | ejercicio11
sumdigit :: Char -> Int -> Int
sumdigit x y = y