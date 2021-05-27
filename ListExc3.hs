-- Create a function isAsc that returns True
-- if a list given to it is a list of ascending order

isAsc :: [Int] -> Bool
isAsc [] = False
isAsc (x:xs)
    |length (x:xs) == 1 = True                     -- to avoid Prelude.head: empty list exception when one-element list is checked
    |(x <= head xs) && (length xs > 1) = isAsc xs
    |(x <= head xs) && (length xs == 1) = True
    |otherwise = False
