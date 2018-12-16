# Practica 9

## Ejercicio 7

> Demostrar que para todo arbol binario t , de tipo `BinTree a` se cumple `nodesBin t <= 2^(heightBin t) - 1`

`nodesBin t <= 2^(heightBin t) - 1 ??`

Se demuestra mediante método de inducción en la estructura del Arbol Binario t.

**Para esto se toma el siguiente caso base:**

```
Si t = Empty,

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
Si `nodesBin t1 <= 2^(heightBin t1) - 1` && `nodesBin t2 <= 2^(heightBin t2) - 1`
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