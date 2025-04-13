// Contains generic benchmarking logic

const std = @import("std");

pub fn Benchmarker(comptime T: type) type {
    return struct {
        operation_name: []const u8,

        context: T,

        getOperationExecutionTime: *const fn (self: Self) anyerror!u64,

        cleanUp: *const fn (self: Self) void,

        const Self = @This();

        fn getOperationExecutionResults(self: Self, execution_count: usize) anyerror!std.ArrayList(u64) {
            const allocator = std.heap.page_allocator;
            var result_arr = std.ArrayList(u64).init(allocator);
            errdefer result_arr.deinit();

            for (0..execution_count) |_| {
                const execution_time = try self.getOperationExecutionTime(self);
                try result_arr.append(execution_time);
            }

            return result_arr;
        }

        pub fn printBenchmarkAnalysis(self: Self, execution_count: usize) void {
            const results = self.getOperationExecutionResults(execution_count) catch |err| {
                std.debug.panic("An error occurred while attempting to get execution results: {}", .{err});
            };
            defer results.deinit();

            // TODO: Print other values besides total execution time
            var total_nano_time: f64 = 0;
            for (0..execution_count) |i| {
                total_nano_time += @floatFromInt(results.items[i]);
            }

            const stdout = std.io.getStdOut().writer();
            stdout.print("Zig's {s} execution time (over {d} loops): {d:.6} ms\n", .{ self.operation_name, execution_count, total_nano_time / 1000000 }) catch unreachable;
        }
    };
}
