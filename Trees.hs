data Tree a
    = Empty
    | Node (Tree a) a (Tree a)

flatten :: Tree a -> [a]
flatten Empty = []
flatten (Node l x r) = flatten l ++ [x] ++ flatten r

treeSum :: Tree Int -> Int
treeSum Empty = 0
treeSum (Node l x r) = treeSum l + x + treeSum r
