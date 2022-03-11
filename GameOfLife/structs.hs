module Structs (
  Cell,
  --Loc,
  Grid
)
where
import Data.Text
{-Rules
For a space that is populated:

Each cell with one or no neighbors dies, as if by solitude.

Each cell with four or more neighbors dies, as if by overpopulation.

Each cell with two or three neighbors survives.

For a space that is empty or unpopulated:

Each cell with three neighbors becomes populated.

-}

-- Cell can be alive or dead
data Cell = Alive
          | Dead
        deriving (Eq, Show)

-- Location of the cell as (x,y)
--type Loc = (Int, Int)

-- Definition of the grid as cell state on a certain location ???
type Grid = [(Int, Int, Cell)]