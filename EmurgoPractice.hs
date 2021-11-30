myInsertAt :: Integer -> Integer -> [Integer] -> [Integer]
myInsertAt z n [] = [z]
myInsertAt z 0 (x:xs) = (z:x:xs)
myInsertAt z n (x:xs) = x : myInsertAt z (n-1) xs

--2. Write a function that takes a list of char and returns the run length encoding i.e. list of (Char, Int) 
--runLengthEncoding "aaabbac" == [('a',3), ('b',2), ('a',1), ('c', 1)]
runLEnc :: [Char] -> [(Char, Int)]
runLEnc [] = []
runLEnc [a] = [(a,1)]
runLEnc (x:y:zs)
    |x /= y = (x,1) : runLEnc (y:zs)
runLEnc _ = error "Something wrong"
