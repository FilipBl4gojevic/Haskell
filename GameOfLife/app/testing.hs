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
import Control.Monad.Trans.State.Strict
 
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

------------------------------------------------------------------------------------------------

initialState :: Board
initialState = [((x, y), Dead)| x<- [1..500], y<-[1..500]]

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
nextStep board = map pointState board

boardAsMonad :: State Board ()
boardAsMonad = do
  currBoard <- get
  counter <- get
  put (nextStep currBoard)

run = runState boardAsMonad board1


