

sieve(100000);

function sieve(limit) {

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

    console.log(primes.join(" "));

    console.log("\n");
    console.log(`Elapsed: ${end - start}ms\n`);
}
