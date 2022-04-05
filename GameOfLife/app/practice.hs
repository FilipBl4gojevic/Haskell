import System.Random

randomList :: StdGen -> Int -> [Int] 
randomList gen size =
    take size $ randomRs (0, 1) gen

randomMatrix :: StdGen -> Int -> Int -> [[Int]]
randomMatrix gen sizeX sizeY =
    take sizeY $ repeat $ randomList gen sizeX

rand = do
    gen <- getStdGen
    putStr $ take 20 (randomRs ('a','z') gen)
    --print $ randomList gen 10
    print $ randomMatrix gen 3 3