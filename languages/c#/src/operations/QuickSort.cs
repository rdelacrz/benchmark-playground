namespace Operations
{
    public static class QuickSortOperation
    {
        private static int Partition(IComparable[] arr, int low, int high)
        {
            int pivot = high;   // Last element is pivot
            int i = low - 1;    // Index of smaller element

            for (int j = low; j < high; j++)
            {
                if (arr[j].CompareTo(arr[pivot]) < 0)
                {
                    i++;
                    (arr[i], arr[j]) = (arr[j], arr[i]);
                }
            }

            i++;
            (arr[i], arr[pivot]) = (arr[pivot], arr[i]);
            return i;
        }

        private static IComparable[] QuickSort(IComparable[] arr, int low, int high)
        {
            if (low < high)
            {
                int pivotIndex = Partition(arr, low, high);
                QuickSort(arr, low, pivotIndex - 1);
                QuickSort(arr, pivotIndex + 1, high);
            }
            return arr;
        }
        
        public static IComparable[] QuickSort(IComparable[] arr)
        {
            return QuickSort(arr, 0, arr.Length - 1);
        }
    }
}
