kth :: Int -> [a] -> a
kth 0 x = head x
kth k (x:xs)
    | k > 0 = kth (k-1) xs 
