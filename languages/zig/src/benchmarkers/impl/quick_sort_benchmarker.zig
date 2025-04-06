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

fn getOperationExecutionTime(self: QuickSortBenchmarker) u64 {
    const allocator = std.heap.page_allocator;

    // Clones the array of strings
    var cloned_arr = std.ArrayList([]u8).init(allocator);
    defer cloned_arr.deinit();
    for (self.context.parsed_arr.value) |item| {
        _ = cloned_arr.append(item) catch unreachable;
    }

    // Gets the execution time
    const start_time = std.time.Instant.now() catch unreachable;
    _ = quickSort(u8, cloned_arr.items);
    const end_time = std.time.Instant.now() catch unreachable;

    return end_time.since(start_time);
}

fn cleanUp(self: QuickSortBenchmarker) void {
    self.context.parsed_arr.deinit();
}
