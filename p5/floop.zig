const std = @import("std");

pub fn main() !void {
    var i = @as(u64, 0);
    while (i < 10) : (i += 2) {
        std.debug.print("{}\n", .{i});
    }
}
