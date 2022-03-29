newtype State s a = State (s -> (a, s))

runState :: State s a -> s -> (a, s)
runState (State f) state = f state

addOneToState :: State Int ()
addOneToState = State f
  where
    f state = ((), state + 1)

stateExample = runState addOneToState 5

statePlusFive :: State Int Int 
statePlusFive = State (\s -> (s+5,s+5))
