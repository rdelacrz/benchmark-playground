// Contains file utility functions

const std = @import("std");

pub const StringArray = @import("std").json.Parsed([][]u8);

fn readFileData(input_file_path: []const u8) ![]const u8 {
    const allocator = std.heap.page_allocator;

    // Open the file
    const file = try std.fs.cwd().openFile(input_file_path, .{});
    defer file.close();

    // Reads file data into buffer
    const file_size = try file.getEndPos();
    const buffer: []u8 = try allocator.alloc(u8, file_size);
    _ = try file.readAll(buffer);

    return buffer;
}

pub fn readJsonStringArrayFromFile(input_file_path: []const u8) !StringArray {
    const allocator = std.heap.page_allocator;

    const buffer = try readFileData(input_file_path);
    defer allocator.free(buffer);

    return try std.json.parseFromSlice([][]u8, allocator, buffer, .{});
}
