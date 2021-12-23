{-# LANGUAGE FlexibleContexts #-}
import Data.List
-- Exercise 1: Wholemeal programming
-- Reimplement each of the following functions in a more idiomatic
-- Haskell style. Use wholemeal programming practices, breaking each
-- function into a pipeline of incremental transformations to an entire
-- data structure. Name your functions fun1’ and fun2’ respectively.
fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs)
    |even x = (x - 2) * fun1 xs
    |otherwise = fun1 xs

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n 
    | even n = n + fun2 (n `div` 2)
    | otherwise = fun2 (3 * n + 1)

-- Hint: For this problem you may wish to use the functions iterate
-- and takeWhile. Look them up in the Prelude documentation to see
-- what they do.

fun1' :: [Integer] -> Integer
fun1' xs = product (map (\x -> x-2) (filter even xs))

-- ----------------------------------------------------------

fun2' :: Integer -> Integer
fun2' 1 = 0
fun2' x = sum (takeWhile (/= 2) (filtered x)) + 2
    where
        filtered :: Integer -> [Integer]
        filtered x = filter even (iterate helper x)

        helper :: Integer -> Integer
        helper a
            | even a = a `div` 2
            | otherwise = 3 * a + 1

-- 1. Implement a function
-- xor :: [Bool] -> Bool
-- which returns True if and only if there are an odd number of True
-- values contained in the input list. It does not matter how many
-- False values the input list contains. For example,
-- xor [False, True, False] == True
-- xor [False, True, False, False, True] == False
-- Your solution must be implemented using a fold.

xor :: [Bool] -> Bool 
xor = foldr (\x acc -> (x && not acc) || (not x && acc)) False