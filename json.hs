import           Data.Aeson
main = do  
        contents <- readFile "C:/Users/blagi/Desktop/Muesli.txt"
        let testing = head contents
        putStrLn "Succesful reading!"
