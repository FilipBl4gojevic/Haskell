{-

1. Print "Enter input\n"
2. Wait for user input and whatever input string I get from the
user, I'll treat it as a number and let's call it num.
3. Print "The output is "
4. Add 1 to num and print it.

-}
-- r :: Recipe Cake
myRecipe1 :: IO ()
myRecipe1 = do
  putStr "Enter input\n" -- IO ()
  num <- readLn :: IO Int -- IO Int
  putStr "The output is " -- IO ()
  putStr (show (num + 1)) -- IO ()

myRecipe2 :: IO Int
myRecipe2 = do
  putStrLn "Enter input" -- IO ()
  num <- readLn :: IO Int -- IO Int
  putStr "The output is " -- IO ()
  putStrLn (show (num + 1)) -- IO ()
  return (num + 1) -- IO Int

myRecipe3 :: IO Int
myRecipe3 = do
  putStrLn "Enter input"
  num <- readLn :: IO Int
  return num -- this makes no difference
  putStr "The output is "
  putStrLn (show (num + 1))
  return (num + 1)

myRecipe4 :: IO Int
myRecipe4 = do
  putStrLn "Enter input"
  getLine -- IO String
  num <- readLn :: IO Int
  putStr "The output is "
  putStrLn (show (num + 1))
  return (num + 1)

myRecipe5 :: IO Int
myRecipe5 = do
  putStrLn "Enter input"
  ignored <- getLine -- IO String
  num <- readLn :: IO Int
  putStrLn ("We ignored: " ++ ignored)
  putStr "The output is "
  putStrLn (show (num + 1))
  return (num + 1)

myRecipe2Added :: IO Int
myRecipe2Added = do
  num1 <- myRecipe2
  num2 <- myRecipe2
  let sum = num1 + num2
  if num1 < 5
    then do
      putStr "num1 is too small"
    else do
      putStr ("The output is: " ++ show sum)
  return sum

getLargeNumber :: IO Int
getLargeNumber = do
  putStr "Enter input: "
  num <- readLn :: IO Int
  if num < 5
    then do -- The do chains recipes.
      putStr "The number is too small, try again"
      getLargeNumber
    else do -- when you have 1 recipe, the do becomes optional.
      return num

-- Exercise: Take two numbers from the user. If the sum is >= 10, print the sum.
--             If it is less than 10, take a third number, add it and then print the sum.
-- Example1
-- > Enter number1
-- 4
-- > Enter number2
-- 3
-- > Oh no the sum is < 10, please enter number3
-- 2
-- > The sum of the 3 numbers is 9
-- Example2
-- > Enter number1
-- 5
-- > Enter number2
-- 7
-- > The sum of the 2 numbers is 12

-- a function that doesn't return anything
-- no such concept in haskell
aFunctionThatDoesNotReturnAnything :: Int -> Bool -> ()
aFunctionThatDoesNotReturnAnything _ _ = ()

takeNumbers :: IO Int
takeNumbers = do
  putStr "Enter number1: "
  number1 <- readLn :: IO Int
  putStr "Enter number2: "
  number2 <- readLn :: IO Int
  if (number1 + number2 >= 10) then do
    putStr "The sum of the 2 numbers is "
    return (number1 + number2)
  else do
    putStr "Oh no the sum is < 10, please enter number3: "
    number3 <- readLn :: IO Int
    putStr "The sum of the 3 numbers is "
    return (number1 + number2 + number3)
