-- TestQuickSort.hs
module TestQuickSort where

import Test.HUnit
import qualified Data.List as List
import Operations.QuickSort (quickSort)

-- Define a test case for quick_sort
testQuickSort :: Test
testQuickSort = TestList [
    TestCase (assertEqual "Test case 1: empty list" ([] :: [String]) (quickSort [])),
    TestCase (assertEqual "Test case 2: single element" ["badger"] (quickSort ["badger"])),
    TestCase (assertEqual "Test case 3: odd number element list" 
        ["apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo"] 
        (quickSort ["zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo"])),
    TestCase (assertEqual "Test case 4: even number element list" 
        ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"] 
        (quickSort ["trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack"])),
    TestCase (assertEqual "Test case 5: already sorted list" 
        ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"] 
        (quickSort ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"])),
    TestCase (assertEqual "Test case 6: list of integers" 
        ([-54, -7, 0, 1, 2, 4, 4, 40, 400] :: [Int]) 
        (quickSort [4, -54, 40, 400, 2, -7, 0, 1, 4]))
    ]

-- Main function to run the tests
main :: IO Counts
main = runTestTT testQuickSort