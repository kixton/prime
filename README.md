## Instructions

```git clone https://github.com/kixton/prime_table.git```
```gem install rspec```
```gem install colorize```

To run program
```ruby run_prpgram.rb```

To see tests
```ruby run_tests.rb -fd```

## Coding Challenge

Print multiplication table of first 10 prime numbers
Consider cases when you want N primes

## Breakdown of Problem To Solve

 1) Write method to determine if n is a Prime Number:
 * Integer
 * Greater than 1
 * Not even (e.g. n%2 != 0), EXCEPT 2
 * Divisible only by 1 and itself
 * i.e. NOT a Composite Number:
  * Evenly divisible by positive integer other than 1 or itself
  * Product is a pair of two factors. Only need to check 1 factor of product pairs
  * sqrt(n) is the ceiling of the first factor in product pairs
  * Check if integer between 2..sqrt(n) is a factor of n
  * Composite number is product of 2+ primes so no need to check composites
  * ...i.e. only check if PRIME integers between 2..sqrt(n) is a factor of n
 
 2) Write method to determine first N prime numbers
 
 3) Write method that returns prime multiplication table as array of arrays (e.g. [[nil,2,3],[2,4,6],[3,6,8]])
  * First row (i.e. first array element) and first columns (i.e. first index of each subarray) include the prime number factor
 
 4) Method to PRINT multiplication table 
  * Consider table header and cell borders

