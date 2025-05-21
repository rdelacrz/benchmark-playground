module Utils.File where

import Data.Aeson (decode)
import qualified Data.ByteString.Lazy as B
import System.Exit (exitFailure)

-- Function to read list of strings from a JSON file
readJsonStringList :: FilePath -> IO [String]
readJsonStringList filePath = do
    jsonData <- B.readFile filePath
    let parsedData = decode jsonData :: Maybe [String]
    case parsedData of
        Just jsonStrings -> return jsonStrings
        Nothing -> do
            putStrLn "Error: Could not parse JSON data."
            exitFailure