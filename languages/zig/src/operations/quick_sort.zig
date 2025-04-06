// Contains the implementation of QuickSort.

const std = @import("std");

inline fn swap(comptime T: type, i: usize, j: usize, arr: [][]T) void {
    const temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

inline fn partition(comptime T: type, arr: [][]T) usize {
    const len = arr.len;
    const pivot = len - 1;
    var store_index: usize = 0;

    for (arr[0 .. len - 1], 0..len - 1) |item, i| {
        if (std.mem.lessThan(T, item, arr[pivot])) {
            // Swap arr[i] and arr[store_index]
            swap(T, i, store_index, arr);
            store_index += 1;
        }
    }
    // Swap arr[store_index] and arr[pivot]
    swap(T, pivot, store_index, arr);

    return store_index;
}

pub fn quickSort(comptime T: type, arr: [][]T) [][]T {
    if (arr.len > 1) {
        const pivot = partition(T, arr);
        _ = quickSort(T, arr[0..pivot]);
        _ = quickSort(T, arr[pivot + 1 ..]);
    }
    return arr;
}
