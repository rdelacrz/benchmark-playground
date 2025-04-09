//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const clap = @import("clap");
const std = @import("std");

const Benchmarker = @import("../benchmarker.zig").Benchmarker;
const runBenchmarker = @import("benchmarkers/benchmarker_runner.zig").runBenchmarker;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    // First we specify what parameters our program can take.
    // We can use `parseParamsComptime` to parse a string into an array of `Param(Help)`.
    const params = comptime clap.parseParamsComptime(
        \\-h, --help                  Display this help and exit.
        \\-o, --operation <str>       The operation to be benchmarked.
        \\-i, --inputfile <str>       The path to a file containing the input data.
        \\-c, --count <usize>         The number of times an operation will be executed.
    );

    // Initialize our diagnostics, which can be used for reporting useful errors.
    // This is optional. You can also pass `.{}` to `clap.parse` if you don't
    // care about the extra information `Diagnostics` provides.
    var diag = clap.Diagnostic{};
    const res = clap.parse(clap.Help, &params, clap.parsers.default, .{
        .diagnostic = &diag,
        .allocator = gpa.allocator(),
    }) catch |err| {
        // Report useful error and exit.
        diag.report(std.io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    // Initializes variables that will store CLI arguments
    var operation: []u8 = undefined;
    var input_file: []u8 = undefined;
    var count: usize = undefined;

    // Retrieves CLI arguments and stores them into local variables
    if (res.args.help != 0)
        std.debug.print("--help\n", .{});
    if (res.args.operation) |o|
        operation = @constCast(o); // Won't be modified after being set, but satisfies compiler
    if (res.args.inputfile) |i|
        input_file = @constCast(i); // Won't be modified after being set, but satisfies compiler
    if (res.args.count) |c|
        count = c;

    // Runs benchmarker
    runBenchmarker(operation, input_file, count) catch |err| {
        std.debug.print("An error occurred while running the benchmarker: {}", .{err});
    };
}

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("zig_lib");
