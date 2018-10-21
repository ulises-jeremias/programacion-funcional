# Practica 5

> Indicar cu ́ales de los siguientes son patterns v ́alidos. Justificar.

**a**) `(x,y)`: válido

**b**) `(1,2)`: válido

**c**) `(n+1)`: inválido

**d**) `(10)`: válido

**e**) `('a',('a',b))`: válido

**f**) `(a,(a,b))`: inválido: aparece dos veces la variable `a`

**g**) `(x,(x,y))`: inválido: aparece dos veces la variable `x`

**h**) `([]:[4])`: no es válido el tipo para un elemento de la forma [[],4]. Por lo que
el patron correcto sería correcto sería de la forma `([]:[[4]])` ó `(4:[])`

**i**) `(x:y:[])`: válido: matchean las listas con dos elementos

**j**) `[xs]`: válido: listas con un elemento

**k**) `([]:[])`: válido: `[[]]`

## Ejercicio 2

> Definir recursivamente las funciones y dar los tipos

**¿Qué significa decir "*por recursión sobre la lista*"?**

Significa que las listas en cuestion son un conjunto de valores que se construyen por inducción estructural,y entonces se puede aprovechar esta propiedad para resolver los siguientes problemas de la siguiente forma:

Por ejemplo, para el caso del primer inciso, la función `sum`, tiene la siguiente estructura.

```haskell
-- por recursión sobre la lista
sum :: [Int] -> Int
sum x = ...
sum (x:xs) = ... x ... sum xs ...
```

**`sum`**

```haskell
sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + sum xs
```

**`any`**

```haskell
any :: [Bool] -> Bool
any [] = False
any (x:xs) = x || any xs
```

**`all`**

```haskell
all :: [Bool] -> Bool
all [] = True
all (x:xs) = x && all xs
```

**`codes`**

```haskell
codes :: [Char] -> [Int]
codes [] = []
codes (x:xs) = ord x : codes xs
```

**`remainders`**

```haskell
remainders :: [Int] -> Int -> [Int]
remainders [] y = []
remainders (x:xs) y = x `mod` y : remainders xs y
```

**`squares`**

```haskell
squares :: [Int] -> [Int]
squares [] = []
squares (x:xs) = x*x : squares xs
```

**`lengths`**

```haskell
lengths :: [[a]] -> [Int]
lengths [] = []
lengths (xs:xss) = length xs : lengths xss
```

**`order`**

```haskell
order :: [(Int,Int)] -> [(Int,Int)]
order [] = []
order ((x,y):xys) = if x < 3*y
                        then (x,y) : order xys
	                    else order xys
```

**`pairs`**

```haskell
pairs :: [Int] -> [Int]
pairs [] = []
pairs (x:xs) = if even x
                    then x : pairs xs
	                else pairs xs
```

**`chars`**

```haskell
chars :: [Char] -> [Char]
chars [] = []
chars (x:xs) = if not (isDigit x)
                    then x : chars xs
	                else chars xs
```

**`moreThan`**

```haskell
moreThan :: [[a]] -> Int -> [[a]]
moreThan [] n = []
moreThan (xs:xss) n = if length xs > n
                        then xs : moreThan xss n
	                    else moreThan xss n
```

## Ejercicio 3

> Puede asegurar que las funciones que definió en el ejercicio anterior terminan? ¿Por qué? ¿Qué diferencia encuentra con las demostraciones de la práctica 4?
