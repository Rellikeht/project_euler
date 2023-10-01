const std = @import("std");

pub fn divs(start: u64, lim: u64, n: u64) bool {
    for (start..lim) |i| {
        if (n % i != 0) {
            return false;
        }
    }
    return true;
}

pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const first = if (args.len > 1) args[1] else "20";
    const lim = (std.fmt.parseUnsigned(u64, first, 10) catch 20) + 1;
    const start = std.math.log2_int(u64, lim);
    var n = lim;

    while (!divs(start, lim, n)) : (n += 1) {}
    std.debug.print("{}\n", .{n});

}
