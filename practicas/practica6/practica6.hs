-- 2 Dado el siguiente tipo, definir las siguientes funciones:

data TipTree a = Tip a | Join (TipTree a) (TipTree a) deriving Show

testTipTree = Join (Join (Join (Join (Tip 1) (Tip 2)) (Tip 3)) (Tip 4)) (Tip 5)

-- heightTip, longitud del camino más largo desde la raíz hasta una hoja.
heightTip :: TipTree a -> Int
heightTip (Tip a) = 0
heightTip (Join x y) = 1 + (max (heightTip x) (heightTip y))

-- leaves, número de hojas.
leaves :: TipTree a -> Int
leaves (Tip a) = 1
leaves (Join x y) = leaves x + leaves y

-- nodes, número de nodos que no son hojas.
nodes :: TipTree a -> Int
nodes (Tip a) = 0
nodes (Join x y) = 1 + nodes x + nodes y

-- walkover, que devuelve la lista de las hojas de un  árbol, leídas de izquierda a derecha.
walkover :: TipTree a -> [a]
walkover (Tip a) = [a]
walkover (Join x y) = walkover x ++ walkover y

-- mirrorTip, que calcula la imagen especular del árbol, o sea, el árbol obtenido 
-- intercambiando los subárboles izquierdo y derecho de cada nodo.
mirrorTip :: TipTree a -> TipTree a
mirrorTip (Tip a) = Tip a
mirrorTip (Join x y) = Join (mirrorTip y) (mirrorTip x)

-- mapTip, que toma una función y un árbol, y devuelve el árbol que se obtiene del
-- dado al aplicar la función a cada nodo.
mapTip :: (a -> b) -> TipTree a -> TipTree b
mapTip f (Tip a) = Tip (f a)
mapTip f (Join x y) = Join (mapTip f x) (mapTip f y)

-- 4

data Seq a = Nil | Unit a | Cat (Seq a) (Seq a) deriving (Show, Eq)

seq1 = Cat (Cat (Cat Nil Nil) Nil) (Unit 3)
seq2 = Cat (Cat (Cat (Unit 2) (Unit 3)) (Unit 4)) (Unit 5)
seq3 = Cat (Cat (Cat Nil Nil) Nil) (Cat (Cat Nil Nil) Nil)
seq4 = Cat (Cat (Cat Nil Nil) Nil) (Cat (Cat Nil (Unit 2)) (Cat (Unit 4) (Unit 5)))
seq5 = Cat (Cat Nil (Unit 2)) (Unit 3)