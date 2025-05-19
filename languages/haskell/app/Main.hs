{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use replicateM_" #-}
module Main where

import Operations.QuickSort (quickSort)

import Control.DeepSeq (deepseq)
import Control.Monad (replicateM)
import Data.Aeson (decode)
import qualified Data.ByteString.Lazy as B
import Data.Time.Clock (diffUTCTime, getCurrentTime, NominalDiffTime)
import System.Exit (exitFailure)
import Text.Printf (printf)

-- Function to read JSON strings from a file
readJsonFile :: FilePath -> IO [String]
readJsonFile filePath = do
    jsonData <- B.readFile filePath
    let parsedData = decode jsonData :: Maybe [String]
    case parsedData of
        Just jsonStrings -> return jsonStrings
        Nothing -> do
            putStrLn "Error: Could not parse JSON data."
            exitFailure

-- Function to convert NominalDiffTime to milliseconds
convertToMilliseconds :: NominalDiffTime -> Double
convertToMilliseconds ndt = realToFrac ndt * 1000

-- Function to benchmark quickSort
benchmarkQuickSort :: [String] -> IO Double
benchmarkQuickSort jsonList = do
    start <- getCurrentTime
    -- Uses replicateM instead of replicateM_ to ensure the result is evaluated
    _ <- replicateM 1000 (deepseq (quickSort jsonList) (return ()))
    end <- getCurrentTime
    let elapsed = diffUTCTime end start
    return $ convertToMilliseconds elapsed

main :: IO ()
main = do
    let filePath = "../../inputs/random_string_list.json"  -- Replace with your JSON file path
    jsonList <- readJsonFile filePath
    timeTaken <- benchmarkQuickSort jsonList
    putStrLn $ printf "Haskell's QuickSort execution time (over 1000 loops): %.6f ms" timeTaken