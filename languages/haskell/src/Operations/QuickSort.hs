module Operations.QuickSort where

-- Partition function: splits list into elements less than pivot and greater or equal to pivot
partition' :: (Ord a) => a -> [a] -> ([a], [a])
partition' pivot [] = ([], [])
partition' pivot (x:xs)
        | x < pivot  = (x : less, greater)
        | otherwise  = (less, x : greater)
    where
        (less, greater) = partition' pivot xs

-- QuickSort function using the partition function
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (pivot:xs) =
    let (less, greater) = partition' pivot xs
    in quickSort less ++ [pivot] ++ quickSort greater