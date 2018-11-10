# Practica 7

* * *

## Ejercicio 3

> Sea la función `f = foldr (:) []`

**Qué tipo tiene?**

```haskell
f :: [a] -> [a]
f = foldr (:) []

```

**Reducir la función aplicada a una lista cualquiera. Escribir una definición equivalente, pero más simple.**

```
f [a,b,c] 
    <-> foldr (:) [] [a,b,c] 
    <-> a foldr (:) [] [b,c] 
    <-> a : (b : foldr (:) [] []) 
    <-> a : (b : (c : foldr (:) [] [] )) 
    <-> a : (b : (c : [])) 
    <-> a:b:c:[]
    <-> [a, b, c]
```

## Ejercicio 6

> Demostrar por inducción en la estructura de las listas.

1. `map f (xs ++ ys) = map f xs ++ map f ys`

Se demuestra que `map f (xs ++ ys) == map f xs ++ map f ys`
mediante inducción estructural sobre la estructura de listas.

-   Caso base `xs = ys = []`

```
map f ([] ++ [])
=   por definicion de ++
map f []
=   por definicion de map
[]
=   por definicion de ++
[] ++ []
=   por definicion de map
map f [] ++ map f []
```

-   Caso inductivo `xs = x:xs'`, `ys = y:ys'`

Dada la siguiente hipótesis inductiva,

```
map f (xs' ++ ys') == map f xs' ++ map f ys'
```

Se demuestra como sigue:

```
map f (x:xs' ++ ys)
=	por def de append
map f x:(xs' ++ ys)
=	por def de map
f x: map f (xs' ++ ys)
=	por H.I.
f x : (map f xs' ++ map f ys)
=	por def de append
f x: (map f xs') ++ (map f ys)
=	por def de map
map f x:xs' ++ map f ys
```

2. `map f . concat = concat . map (map f)`

Se demuestra que `map f . concat = concat . map (map f)`
mediante inducción en la estructura de las listas.

```
concat [] = []
concat x:xs = x ++ (concat xs)
```

por extensionalidad, 

```
map f . concat = concat . map (map f)
    <-> (map f . concat) xs = (concat . map (mapf)) xs
```

-   Caso base `xs = []`

```
(map f . concat) []
=   por definicion de .
map f (concat [])
=   por definicion de concat
map f []
=   por definicion de map
[]
=   por definicion de concat
concat []
=   por definicion de map
concat (map f [])
=   por definicion de map
concat (map f (map f []))
=   por definicion de map
concat (map (map f) [])
=   por definicion de .
(concat . map (map f)) []
```

-   Caso inductivo `xs = x:xs'`

HI `(map f . concat) xs' = (concat . map (map f)) xs'`

Tesis inductiva `(map f . concat) x:xs' = (concat . map (map f)) x:xs'`

```
(map f . concat) x:xs'
=   por definicion de .
map f (concat x:xs')
=   por definicion de concat
map f (x ++ concat xs')
=   por definicion de .
(map f x) ++ map f (concat xs')
=   por H.I.
(map f x) ++ (concat . map (map f)) xs'
=   por definicion de .
(map f x) ++ concat(map (map f x) xs')
=   por definicion de concat
concat (map f x : map (map f) xs')
=	por def de map
concat (map (map f) x:xs')
=	por def de .
(concat . map (map f )) x:xs'
```