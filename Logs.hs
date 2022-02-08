---------------------------------------------------------
-- HOMEWORK

data MessageType = Info
                 | Warning
                 | Error Int
  deriving (Show, Eq)

type Timestamp = Int

data LogMessage = LogMessage MessageType Timestamp String
                | Unknown String
  deriving (Show, Eq)

testString :: String
testString = unlines [
  "I 100 just an info",
  "W 20 just a warning",
  "E 45 150 an error!",
  "E 60 10 another error!",
  "I 200 wow what an info",
  "blah blah blah",
  "E 55 250 yet another error"
   ]

testString2 = unlines ["I 100 just an info"]
-- Fill these in by hand.
testLogMessages :: [LogMessage]
testLogMessages = [
    (LogMessage Info 100 "just an info"),
    (LogMessage Warning 20 "just a warning"),
    (LogMessage (Error 45) 150 "an error!"),
    (LogMessage (Error 60) 10 "another error!"),
    (LogMessage Info 200 "wow what an info"),
    (Unknown "blah blah blah"),
    (LogMessage (Error 55) 250 "yet another error")
     ]

-- parse an entire log file line by line to a list of log messages.
-- hint: Use the lines function and create helper function to parse a single line.
-- also look at the functions words and unwords.
-- search on hoogle.haskell.org
-- Use read to convert a string to an Int
-- Doesn't have to be perfect, it's fine to make assumptions
parseLog :: String -> [LogMessage]
parseLog x = singleLine (singleLineList x) : []
singleLineList :: String -> [String]
singleLineList a = lines a
singleLine :: [String] -> LogMessage
singleLine (x:y:z:zs) = LogMessage mtype stamp text
      where
        mtype
          | x == "I" = Info
          | x == "W" = Warning
          | x == "E" = Error (read y)
--          | otherwise = Unknown
        stamp
          | x == "I" = read y
          | x == "W" = read y
          | x == "E" = read z
        text
          | x == "I" = unwords (z:zs)
          | x == "W" = unwords (z:zs)
          | x == "E" = unwords (zs)

singleLine zs = Unknown (unwords zs)

-- to this parseLog, parseLog testString == testLogMessages

-- Assume that MessageTree is always binary search tree.
-- meaning all values on left will have timestamp less than the current node's timestamp
-- and all the values on the right will have timestamp greater than the current.
-- Assume upto 1 log message at a given timestamp.
data MessageTree = Leaf
                 | Node MessageTree LogMessage MessageTree
    deriving (Show, Eq)

testMessageTree = Leaf
testMessageTree2 = Node Leaf (LogMessage (Error 12) 20 "test") (Node Leaf (LogMessage (Error 12) 151 "test") Leaf)
testMessageTree3 = Node (Node Leaf (LogMessage (Error 12) 8 "test8") Leaf) (LogMessage (Error 12) 20 "test") (Node Leaf (LogMessage (Error 12) 151 "test") Leaf)
testMessageTree4 = Node (Node Leaf (LogMessage (Error 12) 8 "test8") Leaf) (LogMessage (Error 12) 20 "test") Leaf

-- insert inserts a logMessage into a tree and returns the new tree
-- if the log message is of unknown type, return the tree as it is.
-- While inserting, make sure that the new tree is also a binary search tree.
-- Read more about binary search tree on wikipedia or the web.
insert :: LogMessage -> MessageTree -> MessageTree
-- if the log message is of unknown type, return the tree as it is
insert (Unknown _) a = a 
-- if the tree is empty, return the tree with one node
insert (LogMessage mtype stamp text) Leaf = Node Leaf (LogMessage mtype stamp text) Leaf
-- general case: when a new log message is entered, select left or right and recursively call until the bottom of the tree
insert (LogMessage mtype stamp text) (Node leftTree (LogMessage a currStamp b) rightTree)
    | addLeft == True = Node (newNode (LogMessage mtype stamp text)) (LogMessage a currStamp b) rightTree
    | addRight == True = Node leftTree (LogMessage a currStamp b) (newNode (LogMessage mtype stamp text))
  where 
    newNode :: LogMessage -> MessageTree
    newNode (LogMessage mtype stamp text) = Node Leaf (LogMessage mtype stamp text) Leaf
    addLeft = (currStamp >= stamp) && (leftTree == Leaf)
    addRight = (currStamp < stamp) && (rightTree == Leaf)
-- returns all the logs in increasing timestamp order
-- Hint: Notice that the tree is a binary search tree, use the properties you know about them!
inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node Leaf message Leaf) = [message]
inOrder (Node Leaf message rightTree) = message : inOrder rightTree
inOrder (Node leftTree message Leaf) = inOrder leftTree ++ [message]
inOrder (Node leftTree message rightTree) = inOrder leftTree ++ [message] ++ inOrder rightTree

-- prints the String from all Log messages that are of type Error and have severity > 50 (in increasing order of timestamp)
-- Hint: This will use insert and inOrder
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong []= []
whatWentWrong (Unknown _:xs) = whatWentWrong xs
whatWentWrong (LogMessage (Error sev) time text :xs)
  |sev > 50 = text : whatWentWrong xs
  |otherwise = whatWentWrong xs
whatWentWrong (LogMessage _ _ _ :xs) = whatWentWrong xs
--whatWentWrong (LogMessage Warning _ _ :xs) = whatWentWrong xs
--whatWentWrong (LogMessage (Error sev) time text :xs)
--  |sev > 50 = text : whatWentWrong xs
--  |otherwise = whatWentWrong xs

--2. Write a function that replaces all leaves of a tree with (Node Leaf 1 Leaf)
data Tree = Leaf2
          | Node2 Tree Int Tree
  deriving Show

replaceLeaves :: Tree -> Tree
replaceLeaves Leaf2 = Node2 Leaf2 1 Leaf2
--replaceLeaves (Node2 lTree c rTree) = Node2 (newLTree (Node2 lTree c rTree)) c (newRTree (Node2 lTree c rTree))
--replaceLeaves (Node2 lTree c rTree) = let newLeft = newLTree (Node2 lTree c rTree)
--                                          newRight = newRTree (Node2 lTree c rTree)
--                                      in Node2 newLeft c newRight
--  where
--    newLTree :: Tree -> Tree
--    newLTree (Node2 lTree c rTree) = replaceLeaves lTree
--    newRTree :: Tree -> Tree
--    newRTree (Node2 lTree c rTree) = replaceLeaves rTree

replaceLeaves (Node2 lTree c rTree) = Node2 (replaceLeaves lTree) c (replaceLeaves rTree)

--1. Write a function that takes a tree and returns a new Tree with all the values in old tree increased by 1
incTree :: Tree -> Tree
incTree Leaf2 = Leaf2
incTree (Node2 Leaf2 n Leaf2) = Node2 Leaf2 (n+1) Leaf2
incTree (Node2 leftTree n rightTree) = Node2 (incTree leftTree) (n+1) (incTree rightTree)

data Color = Color String