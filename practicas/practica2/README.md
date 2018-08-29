# Practica 2

## Ejercicio 1

-   a

```haskell
True
```

-   b

```haskell
(5, 7)
```

-   c

```haskell
e1c :: Char -> Integer
e1c x
  | x == 'h' = 1
  | otherwise = 0
```

-   d

```haskell
e1d :: (Integer, Char) -> Bool
e1d (x, y) = 'a' > y || x < 1
```

-   e

```haskell
e1e :: (Integer -> Integer) -> Integer
e1e f = 1 + (f 1)
```

-   f

```haskell
((True&&), 6)
```

-   g

```haskell
e1g :: a -> Bool
e1g x = True
```

-   h

```haskell
e1h :: c -> c
e1h x = x
```

## Ejercicio 4

-   a

```haskell
first :: (a, b) -> a
first (x, y) = x
```

-   b

```haskell
second :: (a, b) -> b
second (x, y) = y
```

-   c

```haskell
const :: a -> b -> a
consT x y = x
```

-   d

```haskell
compose :: (b -> c) -> (a -> b) -> (a -> c)
compose f g = (\x  ->  f (g x))
```

-   e

```haskell
apply :: (a -> b) -> a -> b
apply f x = f x
```

-   f

```haskell
subst :: (a -> b -> c) -> (a -> b) -> a -> c
subst f g x = f x (g x)
```

-   g

```haskell
pairFunc :: (a -> b, b -> a) -> b -> a -> (b, a)
pairFunc (f1, f2) x y = (f1 (f2 x), f2 (f1 y))
```

## Ejercicio 6

-   **a)** Correcto
-   **b)** Incorrecto, todo if debe tener else
-   **c)** Incorrecto, := es sintacticamente incorrecto
-   **d)** Incorrecto, error de tipos
-   **e)** Correcta
-   **f)** incorrecta, las funciones de mayor, menor, etc son binarias

## Ejercicio 7

In programming languages and type theory, _polymorphism_ is the provision of a single interface to entities of different types or the use of a single symbol to represent multiple different types.

The most commonly recognised major classes of polymorphism are:

-   Ad hoc polymorphism: defines a common interface for an arbitrary set of individually specified types.
-   Parametric polymorphism: when one or more types are not specified by name but by abstract symbols that can represent any type.
-   Subtyping (also called subtype polymorphism or inclusion polymorphism): when a name denotes instances of many different classes related by some common superclass.

## Ejercicio 8

Ya lo voy a hacer, pero otro día. Ahora a dormir jeje.

## Ejercicio 9

-   a

```haskell
undefined
```

-   b

```haskell
e9b x = if (x + 1) < 0 then undefined else undefined
```

-   c

```haskell
e9c x = undefined
```

## Ejercicio 10

La funcion `tom x = x x` no es correcta dado que al definir el tipo podemos
ver que entra en un loop recursivo sin corte.

## Ejercicio 11

-   a

```haskell
smaller :: Int -> Int -> Int -> Int
smaller = \x -> \y -> \z ->
  if (x < y) && (x < z)
    then x
    else if (y < x) && (y < z)
      then y
      else z
```

-   b

```haskell
second_2 :: a -> b -> b
second_2 = \x -> \x -> x
```

-   c

```haskell
andThen :: Bool -> Bool -> Bool
andThen = \x -> \z -> if x then z else x
```

## Ejercicio 12

-   a

```haskell
iff x y
  | x = not y
  | not x = y
```

-   b

```haskell
alpha x y = y
```

## Ejercicio 13

```haskell
bhaskara :: Float -> Float -> Float -> (Maybe Float, Maybe Float)
bhaskara a b c
  | (b*b - 4*a*c) >= 0 = let solved_root = sqrt (b*b - 4*a*c) in (Just ((-b + solved_root)/2*a), Just ((-b + solved_root)/2*a))
  | otherwise = (Nothing,Nothing)
```
