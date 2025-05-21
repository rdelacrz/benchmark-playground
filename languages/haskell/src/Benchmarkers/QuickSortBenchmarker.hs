module Benchmarkers.QuickSortBenchmarker where

import Operations.QuickSort (quickSort)
import Utils.Time (convertToMilliseconds)

import Control.DeepSeq (deepseq)
import Control.Monad (replicateM)
import Data.Time.Clock (diffUTCTime, getCurrentTime)

-- Function to benchmark quickSort
benchmarkQuickSort :: [String] -> Int -> IO Double
benchmarkQuickSort jsonList executionCount = do
    start <- getCurrentTime
    -- Uses replicateM instead of replicateM_ to ensure the result is evaluated
    _ <- replicateM executionCount (deepseq (quickSort jsonList) (return ()))
    end <- getCurrentTime
    let elapsed = diffUTCTime end start
    return $ convertToMilliseconds elapsed