{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use replicateM_" #-}
module Main where

import Benchmarkers.QuickSortBenchmarker (benchmarkQuickSort, readJsonStringList)

import Data.Maybe (fromMaybe)
import Options.Applicative
import System.Exit (exitFailure)
import Text.Printf (printf)

-- Define the Options data type
data Options = Options
    { operation  :: String
    , inputFile  :: String
    , count      :: Maybe Int
    }

-- Function to parse command line options
parseOptions :: Parser Options
parseOptions = Options
    <$> strOption
        ( long "operation"
        <> short 'o'
        <> metavar "OPERATION"
        <> help "The operation to be benchmarked" )
    <*> strOption
        ( long "inputfile"
        <> short 'i'
        <> metavar "INPUTFILE"
        <> help "The path to a file containing the input data for the benchmarked operation" )
    <*> optional (option auto
        ( long "count"
        <> short 'c'
        <> metavar "COUNT"
        <> help "The number of times an operation will be executed over the course of being benchmarked"
        <> value 1000 ))

-- Main function
main :: IO ()
main = do
  opts <- execParser optsParser
  runOptionsAndReturnExitCode opts
  where
    optsParser = info (parseOptions <**> helper)
      ( fullDesc
     <> progDesc "Benchmark operations"
     <> header "Benchmark CLI - a simple benchmarking tool" )

-- Function to run the benchmark options
runOptionsAndReturnExitCode :: Options -> IO ()
runOptionsAndReturnExitCode opts = do
    let op = operation opts
    let input = inputFile opts
    let countVal = fromMaybe 1000 (count opts)

    timeTaken <- case op of
        "QuickSort" -> do
            stringList <- readJsonStringList input
            benchmarkQuickSort stringList countVal
        _ -> do
            putStrLn "Unsupported operation. Please use 'QuickSort'."
            exitFailure

    putStrLn $ printf "Haskell's %s execution time (over %d loops): %.6f ms" op countVal timeTaken