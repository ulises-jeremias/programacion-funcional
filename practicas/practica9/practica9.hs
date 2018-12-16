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
nodes = foldTipTree (const 0) ((+) . (+1))

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



data BinTree a = Empty | Bin a (BinTree a) (BinTree a) deriving Show

bT1 = Empty
bT2 = Bin 1 (Bin 2 Empty (Bin 3 Empty Empty)) Empty
bT3 = Bin 1 Empty Empty

nodesBin :: BinTree a -> Int
nodesBin Empty = 0
nodesBin (Bin _ t1 t2) = 1 + nodesBin t1 + nodesBin t2

heightBin :: BinTree a -> Int
heightBin Empty = 1
heightBin (Bin _ t1 t2) = 1 + max (heightBin t1) (heightBin t2)

mapBin :: (a -> b) -> BinTree a -> BinTree b
mapBin _ Empty = Empty
mapBin f (Bin a t1 t2) = Bin (f a) (mapBin f t1) (mapBin f t2)

mirrorBin :: BinTree a -> BinTree a
mirrorBin Empty = Empty
mirrorBin (Bin a t1 t2) = Bin a (mirrorBin t2) (mirrorBin t1)

foldBin :: (a -> b -> b -> b) -> b -> BinTree a -> b
foldBin _ z Empty = z
foldBin f z (Bin a t1 t2) = f a (foldBin f z t1) (foldBin f z t2)

{- -}

nodesBin' :: BinTree a -> Int
nodesBin' = foldBin (\x t1 t2 -> 1 + t1 + t2) 0

heightBin' :: BinTree a -> Int
heightBin' = foldBin (\x t1 t2 -> 1 + max t1 t2) 0

mapBin' :: (a -> b) -> BinTree a -> BinTree b
mapBin' f = foldBin (Bin . f) Empty

mirrorBin' :: BinTree a -> BinTree a
mirrorBin' = foldBin (flip . Bin) Empty

{- -}

data GenTree a = Gen a [GenTree a]

foldGen :: (a -> [b] -> b) -> GenTree a -> b
foldGen f (Gen x ts) = f x (map (foldGen f) ts)

foldGen' :: (a -> c -> b) -> ([b] -> c) -> GenTree a -> b
foldGen' f g (Gen x ts) = f x (g (map (foldGen' f g) ts))

foldGen'' :: (a -> c -> b) -> ([b] -> c) -> GenTree a -> b
foldGen'' f g = foldGen (\a ts -> f a (g ts))

{- -}

mapGen :: (a -> b) -> GenTree a -> GenTree b
mapGen f = foldGen (Gen . f)

mapGen' :: (a -> b) -> GenTree a -> GenTree b
mapGen' f = foldGen' (Gen . f) id

-- maximum with Empty list case
maximum' :: [Int] -> Int
maximum' [] = 0
maximum' xs = maximum xs

heightGen :: GenTree a -> Int
-- heightGen = foldGen (\_ ts -> 1 + maximum' ts)
heightGen = foldGen (const ((+1) . maximum'))

heightGen' :: GenTree a -> Int
heightGen' = foldGen' (const (+1)) maximum'

mirrorGen :: GenTree a -> GenTree a
mirrorGen = foldGen (\x ts -> Gen x (reverse ts))

mirrorGen' :: GenTree a -> GenTree a
mirrorGen' = foldGen' Gen reverse

{- -}

data GenExp a = Leaf a | Un (GenExp a) | BinG (GenExp a) (GenExp a) deriving Show

foldGenExp :: (a -> b) -> (b -> b) -> (b -> b -> b) -> GenExp a -> b
foldGenExp f _ _ (Leaf a) = f a
foldGenExp f g h (Un ge) = g (foldGenExp f g h ge)
foldGenExp f g h (BinG ge1 ge2) = h (foldGenExp f g h ge1) (foldGenExp f g h ge2)

data NExp = Num Int | Sum NExp NExp | Sub NExp NExp | Neg NExp deriving Show

foldNExp :: (Int -> a) -> (a -> a -> a) -> (a -> a -> a) -> (a -> a) -> NExp -> a
foldNExp f _ _ _ (Num x) = f x
foldNExp f g h l (Sum ne1 ne2) = g (foldNExp f g h l ne1) (foldNExp f g h l ne2)
foldNExp f g h l (Sub ne1 ne2) = g (foldNExp f g h l ne1) (foldNExp f g h l ne2)
foldNExp f g h l (Neg ne) = l (foldNExp f g h l ne)

data Nat = Zero | Succ Nat deriving Show

foldNat :: (a -> a) -> a -> Nat -> a
foldNat _ z Zero = z
foldNat f z (Succ n) = f (foldNat f z n)

zero = Zero
one = Succ (Zero)
seven = Succ (Succ (Succ (Succ (Succ (Succ (Succ (Zero)))))))

