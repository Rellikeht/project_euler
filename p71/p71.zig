const std = @import("std");
const ftype = f64;
// const itype = u64;
const itype = u32;

pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const first = if (args.len > 1) args[1] else "1_000_000";
    var d = (std.fmt.parseUnsigned(itype, first, 10) catch 1_000_000) + 1;

    const bnum: ftype = 3;
    const bden: ftype = 7;
    const frac: ftype = bnum/bden;

    var maxfrac: ftype = 0;
    var maxnum: itype = 0;
    var maxden: itype = 0;

    while (d > 1) : (d -= 1) {
        if (d == bden) {continue;}

        const floatd = @as(ftype, @floatFromInt(d));
        const curnum = std.math.floor(frac*floatd);
        var num = @as(itype, @intFromFloat(curnum));

        while ((num > 0) and (std.math.gcd(num, d) != 1)) : (num -= 1) {}
        var curfrac = @as(ftype, @floatFromInt(num))/floatd;

        if (curfrac > maxfrac) {
            maxfrac = curfrac;
            maxnum = num;
            maxden = d;
        }
    }

    std.debug.print("{}/{}\n", .{maxnum, maxden});
}
