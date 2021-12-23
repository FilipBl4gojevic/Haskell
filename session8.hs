--Local Maxima
-- From the input list create an output list which contains local maxima - only the elements bigger than both predecessor and successor
{-localMaxima :: [Int] -> [Int]
localMaxima [] = []
localMaxima [a] = []
localMaxima [a, b] = []
localMaxima (x:y:z:zs) = filter cond (x:y:z:zs)
    where
        cond y = (y > x) && (y > z)-}
localMaxima :: [Int] -> [Int]
localMaxima [] = []
localMaxima [a] = []
localMaxima [a, b] = []
localMaxima (x:y:z:xs)
    | (y > x) && (y > z) = y : localMaxima (y:z:xs)
    | otherwise = localMaxima (y:z:xs)