fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

ns :: [Integer]
ns = [0..]
fibs1 :: [Integer]
fibs1 = map fib ns

fibs2 :: [Integer]
fibs2 = map (\k -> if k == 0 then 0 else if k == 1 then 1 else (fibs2 !! (k-1) + fibs2 !! (k-2))) [0..]
