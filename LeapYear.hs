module LeapYear (isLeapYear) where

--    Given a year, report if it is a leap year.

--        The tricky thing here is that a leap year in the Gregorian calendar occurs:
        
--        on every year that is evenly divisible by 4
--          except every year that is evenly divisible by 100
--            unless the year is also evenly divisible by 400

isLeapYear :: Integer -> Bool
isLeapYear year = year `mod` 4 == 0 && (year `mod` 100 /= 0 || year `mod` 400 == 0)

--Comment by mentor was that using `rem` instead of `mod` is more performant
