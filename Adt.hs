data IntList = Empty -- equivalent to []
             | Cons Int IntList -- equivalent to (:)
  deriving Show

-- [] and : are also labels (and functions) just like any constructor.

list0 :: IntList
list0 = Empty
list1 :: IntList
list1 = Cons 1 list0 -- Cons 1 Empty
list2 :: IntList
list2 = Cons 2 list1 -- Cons 2 (Cons 1 Empty)

lengthIntList :: IntList -> Int
lengthIntList Empty = 0
lengthIntList (Cons x xs) = 1 + lengthIntList xs

-- Exercise: define a function to product all the elements of an IntList
prodIntList :: IntList -> Int
prodIntList Empty = 1
prodIntList (Cons x y) = x * prodIntList y 

data Tree = Leaf
          | Node Tree Int Tree
  deriving Show

dummyTree :: Tree
dummyTree = Node (Node Leaf 2 Leaf) 50 (Node Leaf 3 (Node Leaf 42 Leaf))
dummyTree2 = Node (Node Leaf 1 Leaf) 1 (Node Leaf 1 (Node Leaf 0 Leaf))

existsInTree :: Int -> Tree -> Bool
existsInTree x Leaf = False
existsInTree x (Node left y right) = x == y || existsInTree x left || existsInTree x right

-- EXERCISE: Find the largest number in a tree with only positive integers (1,2,...)
-- If the tree is a leaf, return 0.
largestInTree :: Tree -> Int
largestInTree Leaf = 0
largestInTree (Node left x right) 
                                | (x >= largestInTree left) && (x >= largestInTree right) = x
                                | largestInTree left >= largestInTree right = largestInTree left
                                | largestInTree right > largestInTree left = largestInTree right
                                | otherwise = error "Unexpected case"

-- EXERCISE: multiply all numbers in a tree
prodTree :: Tree -> Int
prodTree Leaf = 1
prodTree (Node left x right) = x * prodTree left * prodTree right