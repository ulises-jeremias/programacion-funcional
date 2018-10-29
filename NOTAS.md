# Ejercicios recomendados

* * *

## Ejercicios propuestos en la Teoría

> Definir las funciones `map` y `filter` utilizando `foldr`.

Lo primero a tener en cuenta es que las funciones `map` y `filter` se definen
por recursión sobre una lista. Esto nos indica que se cuenta con dos casos,
un caso base y un caso recursivo, _ó inductivo_.

Teniendo en cuenta esto podemos definir las funciones de la siguiente forma:

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' p []     = []
filter' p (x:xs) = if p x 
                      then x : filter p xs
                      else filter p xs 
```

Luego, dada la definición de `foldr` buscamos definir las funciones utilizando su
definición.

**foldr**

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)
```

Y las funciones quedan como a continuación.

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f xs = foldr (\x xs -> (f x):xs) [] xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p xs = foldr (\x xs -> if p x then x:xs else xs) [] xs
```

Si miramos las definiciones anteriores, podemos observar que los casos definidos para
cuando la lista es vacía, `[ ]`, son redundantes, pues `foldr` ya contempla esos casos
y no es necesario redefinirlo. Entonces las definiciones pasan a ser las siguientes:

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x xs -> (f x):xs) [] xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' p xs = foldr (\x xs -> if p x then x:xs else xs) [] xs
```

Además, podemos observar que la lista recibida como "último parámetro", `xs`, no se altera
en ninguno de los dos casos, quedando como sigue:

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x xs -> (f x):xs) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x xs -> if p x then x:xs else xs) []
```

Estas podrían ser tranquilamente dos definiciones válidas de las funciones `map` y `filter`,
y lo son, pero `map` puede reducirse aún más.

Vamos a pensar ahora en la función que recibe `foldr` para definir `map`, `\x xs -> (f x):xs`.
A esta función la podemos interpretar como una función que, dados dos parámetros devuelve una lista.
Sin embargo, si vemos lo que realmente significa esto, tenemos una función que dado un elemento, _x_, de tipo `a`, devuelve una función que recibe un elemento, _xs_, de tipo `[a]` y retorna una lista de tipo `[a]`, donde esta lista tendrá como cola la lista _xs_ sin modificaciones. Esto de acá tiene toda la pinta de composición entre dos funciones y puede plantearse de la siguiente forma:

`\x xs -> (f x):xs` es equivalente a `(:).f`, y de ahí tenemos la siguiente definición de la función `map`,

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f = foldr ((:).f) []
```
