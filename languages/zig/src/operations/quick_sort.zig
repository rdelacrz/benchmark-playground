// Contains the implementation of QuickSort.

const std = @import("std");
const Order = std.math.Order;

inline fn swap(comptime T: type, i: usize, j: usize, arr: []T) void {
    const temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

inline fn partition(comptime T: type, arr: []T, comparator: *const fn (a: T, b: T) Order) usize {
    const len = arr.len;
    const pivot = len - 1;
    var store_index: usize = 0;

    for (0..len - 1) |i| {
        if (comparator(arr[i], arr[pivot]) == Order.lt) {
            // Swap arr[i] and arr[store_index]
            swap(T, i, store_index, arr);
            store_index += 1;
        }
    }
    // Swap arr[store_index] and arr[pivot]
    swap(T, pivot, store_index, arr);

    return store_index;
}

pub fn quickSort(comptime T: type, arr: []T, comparator: *const fn (a: T, b: T) Order) []T {
    if (arr.len > 1) {
        const pivot = partition(T, arr, comparator);
        _ = quickSort(T, arr[0..pivot], comparator);
        _ = quickSort(T, arr[pivot + 1 ..], comparator);
    }
    return arr;
}

/////////////////////////////////////////////////////////
// Unit Tests
/////////////////////////////////////////////////////////
const testing = std.testing;

const allocator = std.testing.allocator;
const StringList = std.ArrayList([]const u8);

fn compareStrings(a: []const u8, b: []const u8) std.math.Order {
    return std.mem.order(u8, a, b);
}

fn generateMutableStringArray(static_arr: [][]const u8) !StringList {
    var mutArr = StringList.init(allocator);
    errdefer mutArr.deinit();
    for (static_arr[0..]) |elem| {
        _ = try mutArr.append(elem);
    }
    return mutArr;
}

test "QuickSort: zero elements" {
    // Arrange
    var insert_arr = [_][]const u8{};
    var unsorted = try generateMutableStringArray(insert_arr[0..]);
    defer unsorted.deinit();
    const expected_results = try generateMutableStringArray(insert_arr[0..]);
    defer expected_results.deinit();

    // Act
    const actual_results = quickSort([]const u8, unsorted.items, &compareStrings);

    // Assert
    try testing.expectEqualSlices([]const u8, expected_results.items, actual_results);
}

test "QuickSort: one elements" {
    // Arrange
    var unsorted_literal = [_][]const u8{"badger"};
    var unsorted = try generateMutableStringArray(unsorted_literal[0..]);
    defer unsorted.deinit();
    var expected_results_literal = [_][]const u8{"badger"};
    const expected_results = try generateMutableStringArray(expected_results_literal[0..]);
    defer expected_results.deinit();

    // Act
    const actual_results = quickSort([]const u8, unsorted.items, &compareStrings);

    // Assert
    try testing.expectEqualSlices([]const u8, expected_results.items, actual_results);
}

test "QuickSort: odd elements" {
    // Arrange
    var unsorted_literal = [_][]const u8{ "zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo" };
    var unsorted = try generateMutableStringArray(unsorted_literal[0..]);
    defer unsorted.deinit();
    var expected_results_literal = [_][]const u8{ "apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo" };
    const expected_results = try generateMutableStringArray(expected_results_literal[0..]);
    defer expected_results.deinit();

    // Act
    const actual_results = quickSort([]const u8, unsorted.items, &compareStrings);

    // Assert
    try testing.expectEqualSlices([]const u8, expected_results.items, actual_results);
}

test "QuickSort: even elements" {
    // Arrange
    var unsorted_literal = [_][]const u8{ "trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack" };
    var unsorted = try generateMutableStringArray(unsorted_literal[0..]);
    defer unsorted.deinit();
    var expected_results_literal = [_][]const u8{ "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };
    const expected_results = try generateMutableStringArray(expected_results_literal[0..]);
    defer expected_results.deinit();

    // Act
    const actual_results = quickSort([]const u8, unsorted.items, &compareStrings);

    // Assert
    try testing.expectEqualSlices([]const u8, expected_results.items, actual_results);
}

test "QuickSort: same elements" {
    // Arrange
    var unsorted_literal = [_][]const u8{ "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };
    var unsorted = try generateMutableStringArray(unsorted_literal[0..]);
    defer unsorted.deinit();
    var expected_results_literal = [_][]const u8{ "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo" };
    const expected_results = try generateMutableStringArray(expected_results_literal[0..]);
    defer expected_results.deinit();

    // Act
    const actual_results = quickSort([]const u8, unsorted.items, &compareStrings);

    // Assert
    try testing.expectEqualSlices([]const u8, expected_results.items, actual_results);
}
