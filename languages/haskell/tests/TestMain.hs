-- TestMain.hs
module Main where

import Test.HUnit
import TestQuickSort (testQuickSort)

main :: IO ()
main = do
    _ <- runTestTT $ TestList [testQuickSort]
    return ()