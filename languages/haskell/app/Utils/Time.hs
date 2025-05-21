module Utils.Time where

import Data.Time.Clock (NominalDiffTime)

-- Function to convert NominalDiffTime to milliseconds
convertToMilliseconds :: NominalDiffTime -> Double
convertToMilliseconds ndt = realToFrac ndt * 1000