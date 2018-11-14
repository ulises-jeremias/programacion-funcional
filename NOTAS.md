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

* * *

## Definiciones

> `foldr` utilizando `recr`

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z = recr z (\x xs r -> f x r)
```

> `recr` utilizando `foldr`

Se define `recr` como una función como sigue:

```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
```

Por inducción en la estructura de la lista:

```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z [] = z
recr f z (x:xs) = f x xs (recr f z xs)
```

Ahí podemos ver que la función `f` se aplica sobre el elemento actual de la recursión `x`,
y la cola de la lista `xs`,

```haskell
foldr :: (a-> b -> b) -> b -> [a] -> b

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
```

Mirando los tipos correspondientes, podemos ver que para definir `recr` con `foldr`
se necesita utilizar la estructura de la lista para la definición de la función del
fold, dado que se necesita la cola de la lista, por lo que el foldr deberá retornar
un tipo que vaya de `[a] -> b`, entonces el caso base de la recursión
no será un elemento de `a`, sino una función que `forall a b. a -> b -> a`,
es decir, una función de la forma `\c -> z`, o `const z`.

Luego, dada la función que se envía como parámetro al `foldr` para esto,
tenemos que el primer parámetro será un `x :: a`, el segundo será una función
`h :: [a] -> b` dado que la misma se aplicaría sobre la cola de la recursión.
Y finalmente, la estructura sobre la cual trabajar.

```haskell
:: a -> ([a] -> b) -> [a] -> ([a] -> b)
```

Esto nos va quedando algo así

```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z xs = foldr ? (const z) xs xs
```

Y dada la siguiente definición,

```haskell
:: a -> ([a] -> b) -> [a] -> ([a] -> b)
\x h ys -> f x (tail ys) (h (tail ys))
```

Quedando como sigue,

```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z xs = foldr (\x h ys -> f x (tail ys) (h (tail ys))) (const z) xs xs
```

* * *

**LEER** Algebra of Programming, de R. Pard & O. De Moare.
