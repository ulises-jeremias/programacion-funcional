# Practica 9

## Ejercicio 2

> Dado el tipo `data BinTree a = Empty | Bin a (BinTree a) (BinTree a)`

Dadas las siguientes funciones definidas por inducción en la estructura de `BinTree`,

```haskell
mapBin :: (a -> b) -> BinTree a -> BinTree b
mapBin _ Empty = Empty
mapBin f (Bin a t1 t2) = Bin (f a) (mapBin f t1) (mapBin f t2)

mirrorBin :: BinTree a -> BinTree a
mirrorBin Empty = Empty
mirrorBin (Bin a t1 t2) = Bin a (mirrorBin t2) (mirrorBin t1)

foldBin :: (a -> b -> b -> b) -> b -> BinTree a -> b
foldBin _ z Empty = z
foldBin f z (Bin a t1 t2) = f a (foldBin f z t1) (foldBin f z t2)

mapBin' :: (a -> b) -> BinTree a -> BinTree b
mapBin' f = foldBin (Bin . f) Empty

mirrorBin' :: BinTree a -> BinTree a
mirrorBin' = foldBin (flip . Bin) Empty
```

Se demuestran las siguientes equivalencias

-   `mapBin' = mapBin`,

Se demuestra mediante método de inducción en la estructura del Arbol Binario t.

**Caso base. t = Empty**

```
mapBin' f t = mapBin f Empty
=   {por def. de mapBin'}
foldBin (Bin . f) Empty Empty
=   {por def. de foldBin}
Empty
=   {por def. de mapBin}
mapBin f Empty
```

**Caso inductivo. t = (Bin x t1 t2)**

Si `mapBin' f t1 = mapBin f t1` y `mapBin' f t2 = mapBin f t2`

entonces `mapBin' f (Bin x t1 t2) = mapBin f (Bin x t1 t2)`

```
mapBin' f t = mapBin' f (Bin x t1 t2)
=   {por def. de mapBin'}
foldBin (Bin . f) Empty (Bin x t1 t2)
=   {por def. de foldBin}
(Bin . f) x (foldBin (Bin . f) Empty t1) (foldBin (Bin . f) Empty t2)
=   {por def. de mapBin'}
(Bin . f) x (mapBin' f t1) (mapBin' f t2)
=   {por hipotesis inductiva}
(Bin . f) x (mapBin f t1) (mapBin f t2)
=   {por def. de mapBin}
mapBin f (Bin x t1 t2)
```

-   `mirrorBin' = mirrorBin`

Se demuestra mediante método de inducción en la estructura del Arbol Binario t.

**Caso base. t = Empty**

```
mirrorBin' t = mirrorBin' Empty
=   {por def. de mirrorBin'}
foldBin (flip . Bin) Empty Empty
=   {por def. de foldBin}
Empty
=   {por def. de mirrorBin}
mirrorBin Empty
```

**Caso inductivo. t = (Bin x t1 t2)**

Si `mirrorBin' t1 = mirrorBin t1` y `mirrorBin' t2 = mirrorBin t2`

entonces `mirrorBin' (Bin x t1 t2) = mirrorBin (Bin x t1 t2)`

```
mirrorBin' t = mirrorBin' (Bin x t1 t2)
=   {por def. de mirrorBin'}
foldBin (flip . Bin) Empty (Bin x t1 t2)
=   {por def. de foldBin}
(flip . Bin) x (foldBin (flip . Bin) Empty t2) (foldBin (flip . Bin) Empty t1)
=   {por def. de mirrorBin'}
(flip . Bin) x (mirrorBin' t2) (mirrorBin' t1)
=   {por hipotesis inductiva}
(flip . Bin) x (mirrorBin t2) (mirrorBin t1)
=   {por def. de mirrorBin}
mirrorBin (Bin x t1 t2)
```

-   `mirrorBin . mirrorBin = idBin`

Sea `idBin` como sigue,

```haskell
idBin :: BinTree a -> BinTree a
idBin bt = bt
```

**Caso base. t = Empty**

```
(mirrorBin . mirrorBin) t = (mirrorBin . mirrorBin) Empty
=   {por def. de .}
mirrorBin (mirrorBin Empty)
=   {por def. de mirrorBin}
mirrorBin Empty
=   {por def. de mirrorBin}
Empty
=   {por def. de idBin}
idBin Empty
```

**Caso inductivo. t = (Bin x t1 t2)**

Si `(mirrorBin . mirrorBin) t1 = idBin t1` y `(mirrorBin . mirrorBin) t2 = idBin t2`

entonces `(mirrorBin . mirrorBin) (Bin x t1 t2) = idBin (Bin x t1 t2)`

```
(mirrorBin . mirrorBin) t = (mirrorBin . mirrorBin) (Bin x t1 t2)
=   {por def. de .}
mirrorBin (mirrorBin (Bin x t1 t2))
=   {por def. de mirrorBin}
mirrorBin (Bin x (mirrorBin t2) (mirrorBin t1))
=   {por def. de mirrorBin}
Bin x (mirrorBin (mirrorBin t1)) (mirrorBin (mirrorBin t2))
=   {por def. de .}
Bin x ((mirrorBin . mirrorBin) t1) ((mirrorBin . mirrorBin) t2)
=   {por hipotesis inductiva}
Bin x (idBin t1) (idBin t2)
=   {por def. de idBin}
Bin x t1 t2
=   {por def. de idBin}
idBin (Bin x t1 t2)
```

## Ejercicio 7

> Demostrar que para todo arbol binario t , de tipo `BinTree a` se cumple `nodesBin t <= 2^(heightBin t) - 1`

`nodesBin t <= 2^(heightBin t) - 1 ??`

Se demuestra mediante método de inducción en la estructura del Arbol Binario t.

**Para esto se toma el siguiente caso base:**

Si t = Empty,

```
nodesBin t = nodesBin Empty
=   {por definicion de nodesBin}
0
<=
1 - 1
<=
2^0 - 1
<=  {por definicion de heightBin}
2^(heightBin Empty) - 1
<=  {por definicion de t}
2^(heightBin t) - 1
```

**Ahora evaluamos el caso inductivo**

Para este caso evaluamos que, sea t = (Bin x t1 t2),

Si `nodesBin t1 <= 2^(heightBin t1) - 1` y `nodesBin t2 <= 2^(heightBin t2) - 1`

entonces `nodesBin t <= 2^(heightBin t) - 1`


```
nodesBin t = nodesBin (Bin x t1 t2)
=   {por definicion de nodesBin}
1 + nodesBin t1 + nodesBin t2
<=  {por hipotesis inductiva}
1 + (2^(heightBin t1) - 1) + (2^(heightBin t2) - 1)
<=
2^(heightBin t1) + 2^(heightBin t2) - 1
<=  {aritmetica, escribiendo h = max (heightBin t1) (heightBin t2)}
2^h + 2^h - 1
<=  {aritmetica}
2^(1 + h) - 1
<=  {por definicion de h y heightBin}
2^(heightBin (Bin x t1 t2)) - 1
<=
2^(heightBin t) - 1
```