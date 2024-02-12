const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var i: usize = 0;
    while (i < 10) : (i += 1)
        try sieve(100000, false);
    try sieve(100000, true);
}

// using a comptime limit ensures that there's no need for dynamic memory.
fn sieve(comptime limit: usize, emit: bool) !void {
    const start = std.time.microTimestamp();

    var prime = comptime [_]bool{true} ** limit;
    prime[0] = false;
    prime[1] = false;
    var i: usize = 2;
    while (i * i < limit) : (i += 1) {
        if (prime[i]) {
            var j = i * i;
            while (j < limit) : (j += i)
                prime[j] = false;
        }
    }

    const primes: []usize = blk: {
        var primes: [limit]usize = undefined;
        var num: usize = 0;
        for (prime, 0..) |yes, p| {
            if (yes) {
                primes[num] = p;
                num += 1;
            }
        }
        break :blk primes[0..num];
    };
    const end = std.time.microTimestamp();

    std.mem.doNotOptimizeAway(primes);
    // for (primes) |p| {
    //      try stdout.print("{} ", .{p});
    // }

    if (emit) {
        try stdout.print("\n\n", .{});
        try stdout.print("Zig elapsed: {}ms\n\n", .{end - start});
    }
}
