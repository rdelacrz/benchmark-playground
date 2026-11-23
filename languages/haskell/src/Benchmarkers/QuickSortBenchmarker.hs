module Benchmarkers.QuickSortBenchmarker where

import Operations.QuickSort (quickSort)
import Utils.Time (convertToMilliseconds)

import Control.DeepSeq (force)
import Control.Exception (evaluate)
import Control.Monad (replicateM_, void)
import Data.IORef (newIORef, readIORef)
import Data.Time.Clock (diffUTCTime, getCurrentTime)

-- Function to benchmark quickSort
benchmarkQuickSort :: [String] -> Int -> IO Double
benchmarkQuickSort jsonList executionCount = do
    inputRef <- evaluate (force jsonList) >>= newIORef
    start <- getCurrentTime
    replicateM_ executionCount $ do
        -- Read inside the loop so GHC cannot share a pure sort across iterations.
        input <- readIORef inputRef
        void $ evaluate (force (quickSort input))
    end <- getCurrentTime
    let elapsed = diffUTCTime end start
    return $ convertToMilliseconds elapsed