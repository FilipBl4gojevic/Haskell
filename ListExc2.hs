-- Exercise 2: Create a function nub that removes all duplicates
-- from a given list
nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (z:zs)
    |z `elem` zs = nub zs
    |otherwise = z : nub zs 