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
    <-> : a foldr (:) [] [b,c] 
    <-> : a (: b foldr (:) [] []) 
    <-> : a (: b (: c foldr (:) [] [] )) 
    <-> : a (: b (: c [])) 
    <-> a:b:c:[]
    <-> [a,b,c]
```