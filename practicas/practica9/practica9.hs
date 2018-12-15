data TipTree a = Tip a | Join (TipTree a) (TipTree a) deriving Show

testTipTree = Join (Join (Join (Join (Tip 1) (Tip 2)) (Tip 3)) (Tip 4)) (Tip 5)

foldTipTree :: (a -> b) -> (b -> b -> b) -> TipTree a -> b
foldTipTree f g (Tip a) = f a
foldTipTree f g (Join t1 t2) = g (foldTipTree f g t1) (foldTipTree f g t2)

-- heightTip, longitud del camino más largo desde la raíz hasta una hoja.
-- heightTip :: TipTree a -> Int
-- heightTip (Tip a) = 0
-- heightTip (Join t1 t2) = 1 + (max (heightTip t1) (heightTip t2))

heightTip :: TipTree a -> Int
heightTip = foldTipTree (const 0) (\t1 t2 -> 1 + max t1 t2)

-- leaves, número de hojas.
-- leaves :: TipTree a -> Int
-- leaves (Tip a) = 1
-- leaves (Join t1 t2) = leaves t1 + leaves t2

leaves :: TipTree a -> Int
leaves = foldTipTree (const 1) (+)

-- nodes, número de nodos que no son hojas.
-- nodes :: TipTree a -> Int
-- nodes (Tip a) = 0
-- nodes (Join t1 t2) = 1 + nodes t1 + nodes t2

nodes :: TipTree a -> Int
nodes = foldTipTree (const 0) (\t1 t2 -> 1 + t1 + t2)

-- walkover, que devuelve la lista de las hojas de un  árbol, leídas de izquierda a derecha.
-- walkover :: TipTree a -> [a]
-- walkover (Tip a) = [a]
-- walkover (Join t1 t2) = walkover t1 ++ walkover t2

walkover :: TipTree a -> [a]
walkover = foldTipTree (:[]) (++)

-- mirrorTip, que calcula la imagen especular del árbol, o sea, el árbol obtenido 
-- intercambiando los subárboles izquierdo y derecho de cada nodo.
-- mirrorTip :: TipTree a -> TipTree a
-- mirrorTip (Tip a) = Tip a
-- mirrorTip (Join t1 t2) = Join (mirrorTip t2) (mirrorTip t1)

mirrorTip :: TipTree a -> TipTree a
mirrorTip = foldTipTree Tip (flip Join)

-- mapTip, que toma una función y un árbol, y devuelve el árbol que se obtiene del
-- dado al aplicar la función a cada nodo.
-- mapTip :: (a -> b) -> TipTree a -> TipTree b
-- mapTip f (Tip a) = Tip (f a)
-- mapTip f (Join t1 t2) = Join (mapTip f t1) (mapTip f t2)

mapTip :: (a -> b) -> TipTree a -> TipTree b
mapTip f = foldTipTree (Tip . f) Join
