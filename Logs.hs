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
parseLog = undefined

-- to this parseLog, parseLog testString == testLogMessages

-- Assume that MessageTree is always binary search tree.
-- meaning all values on left will have timestamp less than the current node's timestamp
-- and all the values on the right will have timestamp greater than the current.
-- Assume upto 1 log message at a given timestamp.
data MessageTree = Leaf
                 | Node MessageTree LogMessage MessageTree
    deriving (Show, Eq)

testMessageTree = Leaf

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
insert (LogMessage mtype stamp text) (Node leftTree (LogMessage _ currStamp _) rightTree)
    | currStamp >= stamp = insert (LogMessage mtype stamp text) leftTree
    | currStamp < stamp = insert (LogMessage mtype stamp text) rightTree

-- returns all the logs in increasing timestamp order
-- Hint: Notice that the tree is a binary search tree, use the properties you know about them!
inOrder :: MessageTree -> [LogMessage]
inOrder = undefined

-- prints the String from all Log messages that are of type Error and have severity > 50 (in increasing order of timestamp)
-- Hint: This will use insert and inOrder
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = undefined