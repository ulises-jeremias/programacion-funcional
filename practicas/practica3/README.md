# Practica 2

## Ejercicio 1

- **a)**

```haskell
myand :: Bool -> Bool -> Bool
myand x y = x && y -- total function

and' x = and x -- partial function
```

- **b)**

```haskell
firstOne :: a -> b -> a
firstOne x y = x

primary :: a -> b -> a
primary x = firstOne x
```

- **c)**

```haskell
func :: (a -> b) -> (a -> c) -> a -> (b, c)
func x y z = (x z, y z) --total
```

- **d)**

```haskell
func :: Int -> Int -> Int
func x y = x + y
```

- **e)**

```haskell
func :: (Int -> Int) -> Int -> Int
func f x = f x + x -- total
```

- **f)**

```haskell
func :: (a -> b -> c) -> b -> a -> c
func x y z = y x z
```

## Ejercicio 2

-   _funo_ está currificada.

-   _fdos_ está currificada.

-   _ftres_ no está currificada.

## Ejercicio 3

f_operador## y = y##x