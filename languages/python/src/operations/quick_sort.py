"""
Contains implementation of QuickSort.
"""

def quick_sort(arr: list[int], low: int, high: int):
    if low < high:
        pivot_index = partition(arr, low, high)
        quick_sort(arr, low, pivot_index - 1)
        quick_sort(arr, pivot_index + 1, high)

    return arr

def partition(arr: list[int], low: int, high: int) -> int:
    pivot_value = arr[high]     # Last element is pivot
    i = low - 1     # Index of smaller element

    for j in range(low, high):
        if arr[j] < pivot_value:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]

    i += 1      
    arr[i], arr[high] = pivot_value, arr[i]
    return i