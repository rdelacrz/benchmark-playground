// Contains the logic that generates the benchmarker that will be used

const std = @import("std");

const getQuickSortBenchmarker = @import("./impl/quick_sort_benchmarker.zig").getQuickSortBenchmarker;

pub fn runBenchmarker(operation: []u8, input_file: []u8, count: usize) !void {
    const Operation = enum { QuickSort };

    if (std.meta.stringToEnum(Operation, operation)) |o| {
        const benchmarker = switch (o) {
            .QuickSort => try getQuickSortBenchmarker(input_file),
        };
        benchmarker.printBenchmarkAnalysis(count);
        benchmarker.cleanUp(benchmarker);
    } else {
        std.log.err("The following operation is invalid: {s}\n", .{operation});
    }
}
