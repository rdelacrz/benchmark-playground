// Contains generic benchmarking logic

const std = @import("std");

const max_execution_count = 10000;
const ExecutionResultsArray = std.BoundedArray(u64, max_execution_count);

pub fn Benchmarker(comptime T: type) type {
    return struct {
        operation_name: []const u8,

        context: T,

        getOperationExecutionTime: *const fn (self: Self) u64,

        cleanUp: *const fn (self: Self) void,

        const Self = @This();

        fn getOperationExecutionResults(self: Self, execution_count: usize) ExecutionResultsArray {
            var result_arr = ExecutionResultsArray.init(execution_count) catch unreachable;

            for (0..execution_count) |i| {
                const execution_time = self.getOperationExecutionTime(self);
                result_arr.insert(i, execution_time) catch unreachable;
            }

            return result_arr;
        }

        pub fn printBenchmarkAnalysis(self: Self, execution_count: usize) void {
            const results = self.getOperationExecutionResults(execution_count).slice();

            // TODO: Print other values besides total execution time
            var total_nano_time: f64 = 0;
            for (0..execution_count) |i| {
                total_nano_time += @floatFromInt(results[i]);
            }

            std.debug.print("Zig's {s} execution time (over {d} loops): {d:.6} ms\n", .{ self.operation_name, execution_count, total_nano_time / 1000000 });
        }
    };
}
