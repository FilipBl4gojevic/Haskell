data X = Even | Odd

type A = X

instance Show X where
    show Even = "_Even_"
    show Odd = "_Odd_"

instance Num X where
    Even + Even = Even
    Odd + Odd = Even
    _ + _ = Odd
    Even * _ = Even
    _ * _ = Odd
    abs n = n
    negate n = n
    signum _ = Odd
    fromInteger n | even n = Even
                  | otherwise = Odd

-- Point of typeclasses is to have less details, to abstract them away
-- Less details is good! Num doesn't have a lot of details, but
-- Int, Float, Integer do!

getLineLength :: IO Int
getLineLength = fmap length getLine 