/**
 * Contains the implementation of QuickSort.
 */

pub fn partition<T: Ord>(arr: &mut [T]) -> usize {
    let len = arr.len();
    let pivot = len - 1;
    let mut store_index = 0;

    for i in 0..len - 1 {
        if arr[i] < arr[pivot] {
            arr.swap(i, store_index);
            store_index += 1;
        }
    }
    arr.swap(store_index, pivot);
    store_index
}

pub fn quick_sort<T: Ord>(arr: &mut [T]) -> &mut [T] {
    if arr.len() > 1 {
        let pivot = partition(arr);
        quick_sort(&mut arr[0..pivot]);
        quick_sort(&mut arr[pivot + 1..]);
    }
    arr
}
