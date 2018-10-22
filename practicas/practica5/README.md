# Practica 5

> Indicar cuáles de los siguientes son patterns válidos. Justificar.

**a**. `(x, y)`: válido

**b**. `(1, 2)`: válido

**c**. `(n+1)`: inválido

**d**. `(10)`: válido

**e**. `('a', ('a', b))`: válido

**f**. `(a, (a, b))`: inválido: aparece dos veces la variable `a`

**g**. `(x, (x, y))`: inválido: aparece dos veces la variable `x`

**h**. `([]:[4])`: no es válido el tipo para un elemento de la forma [[],4]. Por lo que
el patron correcto sería correcto sería de la forma `([]:[[4]])` ó `(4:[])`

**i**. `(x:y:[])`: válido: matchean las listas con dos elementos

**j**. `[xs]`: válido: listas con un elemento

**k**. `([]:[])`: válido: `[[]]`

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
moreThan [] _ = []
moreThan (xs:xss) n = if length xs > n
                        then xs : moreThan xss n
	                    else moreThan xss n
```

## Ejercicio 3

> Puede asegurar que las funciones que definió en el ejercicio anterior terminan? ¿Por qué? ¿Qué diferencia encuentra con las demostraciones de la práctica 4?

Se puede asegurar que las funciones definidas en el ejercicio anterior terminan dado que la recursión se efectúa sobre conjuntos construidos mediante inducción estructural. Esto produce que cualquier **elemento inductivo** del conjunto se pueda descomponer hasta alcanzar algún **elemento correspondiente a las reglas base**, y al ser esta descomposición un procedimiento finito, se puede demostrar que las funciones terminan.

Luego, en cuanto a como estan programandas las funciones, siempre terminan ya que en las definiciones no recursivas devuelve un resultado concreto y en las recursivas se le quita un elemento a la estructura hasta que en algún momento se hace `pattern matching` con las definiciones no recursivas correspondiente a los casos base.


## Ejercicio 4

> Indicar bajo qu ́e suposiciones pueden evaluarse las siguientes ecuaciones y determinar
cuáles de ellas resultan ser verdaderas y cuáles falsas. Justificar las respuestas. Para las
que sean falsas, indicar cuál debería ser el resultado de cada expresión.

**a**. `[[]] ++ xs = xs`: falsa (xs debe ser una lista de listas) el resultado sería [[],*el contenido de xs*]

**b**. `[[]] ++ [xs] = [[],xs]`: verdadero si xs es una lista

**c**. `[[]] ++ xs = [xs]`: falso, igual que inciso **a**. `xs` es de tipo `[a]`. Falsa: `[]:xs`

**d**. `[]:xs = xs`: xs debería ser una lista vacía, y sería falsa, el resultado sería []:[]

**e**. `[[]] ++ [xs] = [xs]`: falso, se explicó en **b**

**f**. `[[]] ++ xs = []:xs`: verdadero, pues xs es de tipo `[a]` 

**g**. `[xs] ++ [xs] = [xs,xs]`: Verdadero en cualquier caso

**h**. `[] ++ xs = []:xs`: `xs` es de tipo `[a]`. Falsa: `xs`

**i**. `[[]] ++ xs = [[],xs]`: `xs` es de tipo `[a]`. Verdadera

**j**. `[xs] ++ [] = [xs]`: verdadero

## Ejercicio 5

> Demostrar:

**a**. `pairs . squares = squares . pairs`

**b**. ```((`mod` n) . sum) (remainders n xs) = (sum xs) `mod` n```, ∀n>0

## Ejercicio 6

> Demostrar que `sum xs ≤ len xs * maxl xs`, siendo `maxl` la función

```haskell
maxl [] = 0
maxl (x:xs) = x `max` maxl xs
```

y considerando que `xs` es una lista finita de números naturales.

* * *

Se demuestra mediante el método de inducción estructural.

```haskell
{-
    Primero evaluamos el caso base. Dada una lista xs vacia, es decir, xs = [],
    tenemos que,
-}

sum xs = 0 -- por definicion de `sum`

len xs * maxl xs = 0 * 0 = 0

{-
    Luego, se cumple el caso base para `sum xs ≤ len xs * maxl xs`
-}

-- Evaluamos entonces el caso inductivo, dadas las siguientes h.i. y t.i.,

-- h.i.
sum xs ≤ len xs * maxl xs
-- t.i
sum (x:xs) ≤ len (x:xs) * maxl (x:xs)

{-
    Por definicion sabemos que `sum (x:xs) ≤ len (x:xs) * maxl (x:xs)`
    es igual a,
-}

x + sum xs ≤ (1 + len xs) * (x `max` maxl xs) -- def. sum.2, len.2, maxl.2

-- posibilidad 1
x + sum xs ≤ (1 + len xs) * (x `max` maxl xs)
```

## Ejercicio 9

**b**.

```haskell
listOdds :: [[Int]] -> [Int]
listOdds [] = []
listOdds (x:xs) = odds x ++ listOdds xs

odds :: [Int] -> [Int]
odds [] = []
odds (x:xs) = if odd x
				then x : odds xs
				else odds xs
```

## Ejercicio 10

**HACER!**