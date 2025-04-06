// Contains the implementation of QuickSort.

const std = @import("std");

fn partition(comptime T: type, arr: [][]T) usize {
    const len = arr.len;
    const pivot = len - 1;
    var store_index: usize = 0;

    for (arr[0 .. len - 1], 0..len - 1) |item, i| {
        if (std.mem.lessThan(T, item, arr[pivot])) {
            // Swap arr[i] and arr[store_index]
            const temp = arr[i];
            arr[i] = arr[store_index];
            arr[store_index] = temp;
            store_index += 1;
        }
    }
    // Swap arr[store_index] and arr[pivot]
    const temp = arr[store_index];
    arr[store_index] = arr[pivot];
    arr[pivot] = temp;

    return store_index;
}

pub fn quick_sort(comptime T: type, arr: [][]T) [][]T {
    if (arr.len > 1) {
        const pivot = partition(T, arr);
        _ = quick_sort(T, arr[0..pivot]);
        _ = quick_sort(T, arr[pivot + 1 ..]);
    }
    return arr;
}
