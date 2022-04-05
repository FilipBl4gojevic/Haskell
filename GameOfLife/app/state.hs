{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
import Control.Monad.Trans.State.Strict
import Control.Monad.Trans.Reader
import Debug.Trace
import Control.Monad.Trans.Writer.Strict
import System.Random

main = do
  g <- newStdGen
  print . take 10 $ (randomRs ('a', 'z') g)
tick :: State Int Int
tick = do n <- get
          put (n+1)
          return n

plusOne :: Int -> Int
plusOne n = execState tick n

action :: State [Int] ()
action = do
  put [0]
  modify (1:)
  modify (2:)
  get >>= traceShowM
  modify (3:)
  modify (4:)
  get >>= traceShowM

factorial :: Int -> Int
factorial 1 = 1
factorial n = n * factorial (n-1)

factorialWithLogging :: Int -> Writer String Int
factorialWithLogging 1 = do
  tell "We got a 1, the recursion is done.\n"
  return 1
factorialWithLogging n = do
  tell ("n=" ++ show n ++ ", we will recursively call factorial\n")
  result <- factorialWithLogging (n - 1)
  tell ("n=" ++ show n ++ ", we got the result of recursive call\n")
  return (n * result)
