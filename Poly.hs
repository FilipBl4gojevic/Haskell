import System.Win32 (COORD(x))
-- Patterns

data IntList = Empty | Cons Int IntList
  deriving (Show)

-- 1. Perform an operation on each element of a list.

-- Applies absolute function on all elements of IntList.
absAll :: IntList -> IntList
absAll Empty = Empty
absAll (Cons x xs) = Cons (abs x) (absAll xs)

-- Square all numbers of an IntList
squareAll :: IntList -> IntList
squareAll Empty = Empty
squareAll (Cons x xs) = Cons (x * x) (squareAll xs)

-- Common points
-- The signatures are the same
-- Both have same Empty pattern (i.e. same base case)
-- Recursive steps are similar
--   i) They all change the current head of the list using an (Int -> Int) function
--   ii) Just call the function recursively on the remaining list.

mapIntList :: (Int -> Int) -> IntList -> IntList
mapIntList _ Empty = Empty
mapIntList f (Cons x xs) = Cons (f x) (mapIntList f xs)

absAll' :: IntList -> IntList
absAll' list = mapIntList abs list

squareAll' :: IntList -> IntList
squareAll' list = mapIntList square list
  where
    square :: Int -> Int
    square x = x * x

-- 2. Keep an element of a list only if it satisfies a property.

keepEvens :: IntList -> IntList
keepEvens Empty = Empty
keepEvens (Cons x xs)
  | even x = Cons x (keepEvens xs)
  | otherwise = keepEvens xs

lessThanTen :: IntList -> IntList
lessThanTen Empty = Empty
lessThanTen (Cons x xs)
  | x < 10 = Cons x (lessThanTen xs)
  | otherwise = lessThanTen xs

-- Common points
-- Same signature
-- Same base case (Empty case)
-- Similar recursive step:
--    i) We check the head for some condition
--    ii) Same recursion on the remaining list

filterIntList :: (Int -> Bool) -> IntList -> IntList
filterIntList _ Empty = Empty
filterIntList predicate (Cons x xs) -- predicate is just the argument name i.e. pattern matching. Can rename to anything i like.
  | predicate x = Cons x (filterIntList predicate xs)
  | otherwise = filterIntList predicate xs

keepEvens' :: IntList -> IntList
keepEvens' list = filterIntList even list

lessThanTen' :: IntList -> IntList
lessThanTen' list = filterIntList less10 list
  where
    less10 :: Int -> Bool
    less10 x = x < 10

-- 3. Combine values e.g. sum, product, etc. Will be covered later.

-- Polymorphism

-- [1, 33] -> ["one", "thirty three"]

-- data IntList = Empty | Cons Int IntList
-- List type is "parameterized" by a type t
data List t = E | C t (List t)
  deriving (Show)

list1 :: List Int
list1 = C 3 (C 5 (C 0 E))

list2 :: List Char
list2 = C 'a' (C 'r' (C 'm' E))

list3 :: List Bool
list3 = C True (C False E)

-- filterIntList :: (Int -> Bool) -> IntList -> IntList
-- filterIntList _ Empty = Empty
-- filterIntList predicate (Cons x xs) -- predicate is just the argument name i.e. pattern matching. Can rename to anything i like.
--   | predicate x = Cons x (filterIntList predicate xs)
--   | otherwise = filterIntList predicate xs

-- REMEMBER THESE TWO THINGS ABOUT POLYMORPHISM:
-- polymorphic type (t)
-- 1. Your function should work for any type t.
-- 2. The caller decide the value of t.

filterList :: (t -> Bool) -> List t -> List t
filterList _ E = E
filterList predicate (C x xs) -- predicate is just the argument name i.e. pattern matching. Can rename to anything i like.
  | predicate x = C x (filterList predicate xs)
  | otherwise = filterList predicate xs

stringsOfLengthMoreThanTwo :: List String -> List String
stringsOfLengthMoreThanTwo list = filterList f list
  where
    f :: String -> Bool
    f str = length str > 2

filterNonEmpty :: List (List a) -> List (List a)
filterNonEmpty list = filterList isNonEmpty list
  where
    isNonEmpty :: List a -> Bool
    isNonEmpty E = False
    isNonEmpty (C _ _) = True

-- list :: List (List a)
-- f ::
-- filterList :: (t -> Bool) -> List t -> List t      (from the definition)

filterNonEmptyStrings :: List String -> List String
filterNonEmptyStrings list = filterList f list
  where
    f :: String -> Bool
    f str = length str > 0

-- list :: List String
-- filterList :: (t -> Bool) -> List t -> List t      (from the definition)
-- t = String

-- mapIntList :: (Int -> Int) -> IntList -> IntList
-- mapIntList _ Empty = Empty
-- mapIntList f (Cons x xs) = Cons (f x) (mapIntList f xs)
mapList :: (a -> b) -> List a -> List b
mapList _ E = E
mapList f (C x xs) = C (f x) (mapList f xs)

-- C "hello" (C "world" (C "!" E))
-- -> C 'h' (C 'w' (C '!' E))
firstCharacters :: List String -> List Char
firstCharacters list = mapList head list
-- list :: List String
-- head :: String -> Char
-- mapList :: (String -> Char) -> List String -> List Char

-- Homework: Reimplement all functions above for Haskell's List ([a])
-- e.g. firstCharacters :: [String] -> [Char]
        -- filterNonEmptyStrings :: [String] -> [String]
        -- filterNonEmpty :: [[a]] -> [[a]]
        -- stringsOfLengthMoreThanTwo :: [String] -> [String]
-- assume that map and filter are already defined, no need to implement those.

tList1 = [1,2,3,4,5,5,6,7,8,9,12]
tList2 = ['a','b','c','d']
tList3 = ["woo", "", "", "sasd", "hoo", "kumbaya"]
firstCharacters' :: [String] -> [Char]
firstCharacters' list = map head list

filterNonEmptyStrings' :: [String] -> [String]
filterNonEmptyStrings' list = filter fun list
    where
        fun :: String -> Bool
        fun str = length str > 0 

filterNonEmpty' :: [[a]] -> [[a]]
filterNonEmpty' list = filter fun list
    where
        fun :: [a] -> Bool
        fun str = length str > 0 


myHead :: [t] -> t
myHead (x:xs) = x
myHead _ = error "error"

parseBool :: String -> Maybe Bool
parseBool s
    | s == "True" = Just True 
    | s == "true" = Just True
    | s == "False" = Just False
    | s == "false" = Just False
    | otherwise = Nothing 

myLast :: [a] -> Maybe a
myLast (x:[]) = Just x
myLast (x:xs) = myLast xs
myLast _ = Nothing

myTail :: [a] -> Maybe [a]
myTail [] = Nothing 
myTail (x:xs) = Just xs
