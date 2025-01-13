const std = @import("std");

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(general_purpose_allocator.deinit() == .ok);
    const gpa = general_purpose_allocator.allocator();

    var args = try std.process.ArgIterator.initWithAllocator(gpa);
    defer args.deinit();

    // Skip the first argument (the program path)
    _ = args.next();

    while (args.next()) |arg| {
        const stdout = std.io.getStdOut().writer();
        try stdout.print("Hello {s}!\n", .{arg});
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit();
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
