
for (let ii = 0; ii < 10; ii++)
    sieve(100_000);
sieve(100_000, true);

function sieve(limit, emit) {

    const start = Date.now();

    const prime = [];
    prime[0] = false;
    prime[1] = false;
    let i = 0;
    while (i * i < limit) {

        if (prime[i] !== false) {
            let j = i * i;
            while (j < limit) {

                prime[j] = false;
                j += i;
            }
        }
        i++;
    }

    const primes = [];
    for (let i = 0; i < prime.length; i++)
        if (prime[i] !== false)
            primes.push(i);

    const end = Date.now();

    //console.log(primes.join(" "));

    if (emit) {
        console.log("\n");
        console.log(`Node elapsed: ${end - start}ms\n`);
    }
}
