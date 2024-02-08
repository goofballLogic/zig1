const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    try sieve(100000);
}

// using a comptime limit ensures that there's no need for dynamic memory.
fn sieve(comptime limit: usize) !void {

    var start = std.time.microTimestamp();

    var prime = [_]bool{true} ** limit;
    prime[0] = false;
    prime[1] = false;
    var i: usize = 2;
    while (i*i < limit) : (i += 1) {
        if (prime[i]) {
            var j = i*i;
            while (j < limit) : (j += i)
                prime[j] = false;
        }
    }
    var primes = std.ArrayList(usize).init(std.heap.page_allocator);
    for (prime, 0..) |yes, p|
        try if (yes)
            primes.append(p);
    var end = std.time.microTimestamp();

    for (primes.items) | p |
        try stdout.print("{} ", .{p});

    try stdout.print("\n\n", .{});
    try stdout.print("Elapsed: {}ms\n\n", .{end - start});
}
