## Instructions

```git clone https://github.com/kixton/prime.git```

```gem install rspec```

```gem install colorize```


To run program

```ruby run_prpgram.rb```

To run tests

```ruby run_tests.rb -fd```

## Coding Challenge

Print multiplication table of first 10 prime numbers
Consider cases when you want N primes

## Breakdown of Problem To Solve

 1) Write method, is_prime(n) to determine if n is a **Prime Number**:
 * Integer
 * Greater than 1
 * Not even (e.g. n%2 != 0), EXCEPT 2
 * Divisible only by 1 and itself
 * Is NOT a *Composite Number*, defined as
  * Evenly divisible by positive integer other than 1 or itself
  * Since product of a number is comprised of a pair of two factors, we only need to check 1 factor of product pairs. Let's call it small_factor (vs larg_factor)
  * Math.sqrt(n) is the largest small_factor of a number's potential product pairs
  * Thus, we must check n is evenly divisible by any integer between 2..sqrt(n)
  * Since composite numbers are a product 2+ primes, we do not need to divide n by any composite numbers
  * **That is, we only need to check n is evenly divisible by *prime integers* between 2..sqrt(n)**
 
 2) Write method, first_primes(n) to determine first N prime numbers
  * Make use of is_prime(n) method above
 
 3) Write method, create_multiplication_table(factors) that creates multiplication table based on a list of factors
  * Make use of first_prime(n) method above to create factors
  * Return an array of arrays (e.g. multiplication_table=[[nil,2,3,5],[2,4,6,10],[3,6,9,15],[5,10,15,25]] )
  * Each array element will be a table row
  * multiplication_table[0] will represent the header of factors
  * First index of each subarray will include factor pair
 
 4) Method to print multiplication table 
  * Consider table header and cell borders

