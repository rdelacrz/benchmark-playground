// The following is an implementation of the Benchmarker that benchmarks QuickSort operations
const std = @import("std");

const Benchmarker = @import("../benchmarker.zig").Benchmarker;
const quickSort = @import("../../operations//quick_sort.zig").quickSort;
const readJsonStringArrayFromFile = @import("../../utils/file_utils.zig").readJsonStringArrayFromFile;
const StringArray = @import("../../utils/file_utils.zig").StringArray;

const QuickSortBenchmarkerContext = struct {
    parsed_arr: StringArray,
};

const QuickSortBenchmarker = Benchmarker(QuickSortBenchmarkerContext);

pub fn getQuickSortBenchmarker(input_file_path: []const u8) !QuickSortBenchmarker {
    const operation_name = "QuickSort".*;
    const context = QuickSortBenchmarkerContext{ .parsed_arr = try readJsonStringArrayFromFile(input_file_path) };
    return QuickSortBenchmarker{
        .operation_name = &operation_name,
        .context = context,
        .getOperationExecutionTime = &getOperationExecutionTime,
        .cleanUp = &cleanUp,
    };
}

fn getOperationExecutionTime(self: QuickSortBenchmarker) anyerror!u64 {
    const allocator = std.heap.page_allocator;

    // Sort a copy of the descriptors; the parsed array owns the string bytes.
    const target_sort = try allocator.dupe([]u8, self.context.parsed_arr.value);
    defer allocator.free(target_sort);

    // Gets the execution time
    const start_time = try std.time.Instant.now();
    _ = quickSort([]u8, target_sort, &compareStrings);
    const end_time = try std.time.Instant.now();

    return end_time.since(start_time);
}

fn cleanUp(self: QuickSortBenchmarker) void {
    self.context.parsed_arr.deinit();
}

fn compareStrings(a: []u8, b: []u8) std.math.Order {
    return std.mem.order(u8, a, b);
}
