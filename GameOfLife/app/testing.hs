{-Rules
For a space that is populated:
Each cell with one or no neighbors dies, as if by solitude.
Each cell with four or more neighbors dies, as if by overpopulation.
Each cell with two or three neighbors survives.

For a space that is empty or unpopulated:
Each cell with three neighbors becomes populated.
-}
module Testing where
  
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Interact

-- Cell can be alive or dead
data Life = Dead
          | Alive
        deriving (Eq, Show)

-- Location of the cell as (x,y)
type Loc = (Int, Int)

-- Definition of the point on the grid as cell state on a certain location
type Cell = (Loc, Life)

-- Definition of the whole board
type Board = [Cell]

--Some test boards
board1 :: Board
board1 = [((1,1), Alive), ((2,1), Dead), ((3,1), Dead), ((4,1), Dead), ((5,1), Dead),
          ((1,2), Dead), ((2,2), Alive), ((3,2), Dead), ((4,2), Dead), ((5,2), Dead),
          ((1,3), Dead), ((2,3), Dead), ((3,3), Alive), ((4,3), Dead), ((5,3), Dead),
          ((1,4), Dead), ((2,4), Dead), ((3,4), Alive), ((4,4), Alive), ((5,4), Dead),
          ((1,5), Dead), ((2,5), Dead), ((3,5), Dead), ((4,5), Dead), ((5,5), Alive)]

initialState :: Int -> Int -> Board
initialState x y = [((x, y), Dead)| x<- [1..x], y<-[1..y]]

pointState :: Cell -> Cell
pointState (loc, state)
  | (state == Dead) && (neighboursAlive (loc,state) board1 0 == 3) = (loc, Alive)
  | (state == Alive) && ((neighboursAlive (loc,state) board1 0 >= 2) && (neighboursAlive (loc,state) board1 0 <= 3)) = (loc, Alive)
  | otherwise = (loc, Dead)

neighboursAlive :: Cell -> Board -> Int -> Int
neighboursAlive ((x,y), state) (((xb,yb), boardState) : board) counter
  | ((abs (x-xb) < 2) && (abs (y-yb) < 2) && not ((x == xb) && (y == yb))) && (boardState == Alive) && null board = counter + 1
  | ((abs (x-xb) < 2) && (abs (y-yb) < 2) && not ((x == xb) && (y == yb))) && (boardState == Alive) = neighboursAlive ((x,y), state) board (counter + 1)
  | null board = counter
  | otherwise = neighboursAlive ((x,y), state) board counter

nextStep :: Board -> Board
nextStep board = map pointState board -- ????
 
---------------------------------------------------------------------------------------------------------------------------------------
--Drawing
width, height, offset :: Int
width = 1000
height = 1000
offset = 500

window :: Display
window = InWindow "Conway's Game Of Life" (width, height) (offset, offset)

backgroundColor :: Color
backgroundColor = greyN 0.8

drawing :: Picture
--drawing = translate (-490) (490) (rectangleWire 10 10)
drawing = Pictures [(translate (-490) (490) (rectangleWire 10 10)), (translate (-480) (490) (rectangleWire 10 10)) ]
test :: IO ()
test = display window backgroundColor drawing
  {-
  ((1,5), Dead), ((2,5), Dead), ((3,5), Dead), ((4,5), Dead), ((5,5), Alive)
  ((1,4), Dead), ((2,4), Dead), ((3,4), Alive), ((4,4), Alive), ((5,4), Dead)
  ((1,3), Dead), ((2,3), Dead), ((3,3), Alive), ((4,3), Dead), ((5,3), Dead)
  ((1,2), Dead), ((2,2), Alive), ((3,2), Dead), ((4,2), Dead), ((5,2), Dead)
  ((1,1), Alive), ((2,1), Dead), ((3,1), Dead), ((4,1), Dead), ((5,1), Dead)-}

{-}:: Display	
Display mode.

-> Color	= backgroundColor
Background color.

-> Int	= fps
Number of simulation steps to take for each second of real time.

-> world	= initialBoard
The initial world.

-> (world -> Picture)	= boardAsPicture
A function to convert the world a picture.

-> (Event -> world -> world)	= inputEvent
A function to handle input events.

-> (Float -> world -> world)	= nextState
A function to step the world one iteration. It is passed the period of time (in seconds) needing to be advanced.

-> IO ()-}
fps :: Int
fps = 30

initialBoard :: Board
initialBoard = initialState 100 100

currentBoard :: Board
currentBoard = undefined

boardAsPicture :: Board -> Picture
boardAsPicture = undefined

inputEvent :: Event -> Board -> Board
inputEvent (EventKey (SpecialKey KeySpace) Up _ currentBoard) = undefined

nextState :: Float -> Board -> Board
nextState = undefined

playGame = play window backgroundColor fps initialBoard boardAsPicture inputEvent nextState