module Benchmarkers.QuickSortBenchmarker where

import Operations.QuickSort (quickSort)
import Utils.Time (convertToMilliseconds)

import Control.DeepSeq (deepseq)
import Control.Monad (replicateM)
import Data.Aeson (decode)
import qualified Data.ByteString.Lazy as B
import Data.Time.Clock (diffUTCTime, getCurrentTime)
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

-- Function to benchmark quickSort
benchmarkQuickSort :: [String] -> Int -> IO Double
benchmarkQuickSort jsonList executionCount = do
    start <- getCurrentTime
    -- Uses replicateM instead of replicateM_ to ensure the result is evaluated
    _ <- replicateM executionCount (deepseq (quickSort jsonList) (return ()))
    end <- getCurrentTime
    let elapsed = diffUTCTime end start
    return $ convertToMilliseconds elapsed