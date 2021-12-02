squareSum :: Integer -> Integer -> Integer
squareSum x y = (x + y) * (x + y)

-- >>> next (-4)
---3
-- ♫ NOTE: The current function body is defined using a special function called
--  "error". Don't panic, it is not broken. 'error' is like a placeholder, that
--  evaluates to an exception if you try evaluating it. And it also magically fits
--  every type ｡.☆.*｡. No need to worry much about "error" here, just replace the
--  function body with the proper implementation.
-- -}
next :: Int -> Int
next x = x + 1

-- =⚔️= Task 5
-- Implement a function that returns the last digit of a given number.
-- >>> lastDigit 42
-- 2
-- 🕯 HINT: use the `mod` function
-- ♫ NOTE: You can discover possible functions to use via Hoogle:
--     https://hoogle.haskell.org/
--   Hoogle lets you search Haskell functions either by name or by type. You can
--   enter the type you expect a function to have, and Hoogle will output relevant
--   results. Or you can try to guess the function name, search for it and check
--   whether it works for you!
-- -}
-- DON'T FORGET TO SPECIFY THE TYPE IN HERE
lastDigit :: Int -> Int
lastDigit n = n `mod` 10