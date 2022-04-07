module Drawing where
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Interact
import Testing
--------------------------------------------------------------------------------------------------------------------------------------
--Drawing
width, height, offset :: Int
width = 1100
height = 1100
offset = 500

window :: Display
window = InWindow "Conway's Game Of Life" (width, height) (offset, offset)

backgroundColor :: Color
backgroundColor = greyN 0.8

--drawing :: Picture
--drawing = translate (-490) (490) (rectangleWire 10 10)
--drawing = Pictures [(translate (-490) (490) (rectangleWire 10 10)), (translate (-480) (490) (rectangleWire 10 10)) ]
drawing :: Picture
drawing = Pictures [translate x y (rectangleWire 10 10)| x<- [-490, -480..500], y<-[-490, -480..500]]

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
initialBoard = initialState deadBoard randomCell

boardAsPicture :: Board -> Picture
boardAsPicture = undefined

update :: ViewPort -> Float -> Board -> Board 
update _ 1 = nextStep 
--simulateGame = simulate window backgroundColor fps initialBoard boardAsPicture (ViewPort -> Float -> model -> model)
-- Print 10 states 10.to.1 to try

simulateGame = simulate window backgroundColor fps initialBoard boardAsPicture update