-- Exercise 1: Create a function elem that returns true if an element
-- is in a given list and returns false otherwise
element :: (Eq a) => a -> [a] -> Bool
element _ [] = False
element x (y:ys)
    |x == y     = True
    |otherwise = element x ys