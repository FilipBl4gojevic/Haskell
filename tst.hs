kth :: Int -> [a] -> a
kth 0 x = head x
kth k (x:xs)
    | k > 0 = kth (k-1) xs 
    |otherwise = head xs

-- kth 0 [1,2,3,5,6,7,8]
-- 1
-- kth 1 [1,2,3,4,5,7,9]
-- k = 1 x = 1 xs = [2,3,4,5,7,9]
--      kth 0 [2,3,4,5,7,9]
--      2