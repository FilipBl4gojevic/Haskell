{-1. How do you represent the ball and the walls?
    > Using | and _ for the walls
    > Use o for the ball
2. The time interval between two frames i.e. refresh rate
    > We'll keep it as a parameter
3. Angle of the bounce
    > Elastic bounce i.e. like light
    > Change velocity after bounce in one direction only
    > magnitude stays the same
4. 2D array/coordinate system
    > left to right increasing x
    > down to up increasing y
    > No need for array for the walls
    > We can represent using a function 
5. Ball position and velocity vectors
     > use a pair (Int, Int)
6. How do you make it animation like?
     > Clear the terminal, then draw
7. Parameters
     > size of the frame, velocity, initial position
-}

-- Types
data Vector = Vector Int Int
    deriving Show

vectorX :: Vector -> Int
vectorX (Vector x _) = x

vectorY :: Vector -> Int
vectorY (Vector _ y) = y

mapX :: (Int -> Int) -> Vector -> VerNTDomainControler
mapX f (Vector )

data BallState = BallState Vector Vector
    deriving Show

positionState :: BallState -> Vector
positionState (BallState pos _) = pos

velocityState :: BallState -> Vector
velocityState (BallState _ vel) = vel

data Env = Env Int Int

frameWidthEnv :: Env -> Int
frameWidthEnv (Env width _) = width

frameHeightEnv :: Env -> Int
frameHeightEnv (Env _ height) = height

data Edge = U | D | L | R
-- State transition
transition :: Env -> BallState -> BallState
transition (Env frameWidth frameHeight) (BallState position velocity) = BallState newPosition newVelocity
    where
        nextPositionIfNoFrame :: Vector
        nextPositionIfNoFrame = addVector position velocity
        bounceResult :: Maybe Edge
        bounceResult
            | vectorY nextPositionIfNoFrame >= frameHeight = Just U
            | vectorY nextPositionIfNoFrame <= 0 = Just D
            | vectorX nextPositionIfNoFrame >= frameWidth = Just R
            | vectorX nextPositionIfNoFrame <= 0 = Just L
            | otherwise Nothing

        newVelocity = case bounceResult of
            Nothing  -> velocity
            Just U -> mapY (* (-1)) velocity
            Just D -> mapY (* (-1)) velocity
            Just L -> mapX (* (-1)) velocity
            Just R -> mapX (* (-1)) velocity
        newPosition = case bounceResult of
            Nothing  -> nextPositionIfNoFrame
            Just U -> mapY (\y 2 * frameHeight - y) nextPositionIfNoFrame
            Just D -> mapY (* (-1)) nextPositionIfNoFrame
            Just R -> mapX (\x 2 * frameWidth - x) nextPositionIfNoFrame
            Just L -> mapX (* (-1)) nextPositionIfNoFrame

-- Draw
draw :: Env -> BallState -> String
draw (Env frameWidth frameHeight) (BallState position _) = unlines $ reverse $ map drawRow [-1 .. frameHeight + 1]
    where
        charAt :: Int -> Int -> Char
        charAt x y 
            | (y > frameHeight || y < 0) && (x > frameWidth || x < 0) = ' '