//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");

const quick_sort = @import("operations/quick_sort.zig").quick_sort;
const file_utils = @import("utils/file_utils.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var total: f64 = 0;

    const str_array = try file_utils.read_json_string_array_from_file("../../inputs/random.json");
    defer str_array.deinit();

    for (0..1000) |_| {
        // Clones the array of strings
        var cloned_arr = std.ArrayList([]u8).init(allocator);
        defer cloned_arr.deinit();
        for (str_array.value) |item| {
            try cloned_arr.append(item);
        }

        const start_time = try std.time.Instant.now();
        _ = quick_sort(u8, cloned_arr.items);
        const end_time = try std.time.Instant.now();
        total += @floatFromInt(end_time.since(start_time));
    }

    std.debug.print("Zig's QuickSort execution time (over 1000 loops): {d:.4}\n", .{total / 1000000});
}

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("zig_lib");
