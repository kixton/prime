module Prime
  @primes = [2] # array of prime integers in sequence
  @latest_checked = 2 # latest number checked for is_prime
  def self.current_primes
    @primes
  end
  def self.latest_checked
    @latest_checked
  end
  def self.reset
    @primes = [2]
    @latest_checked = 2
  end
  def self.first_primes(n)
    return false if !n.is_a?(Integer) || n < 1
    if n > @primes.length # @primes array does not have 'n' prime
      until n == @primes.length # until @prime array has first 'n' prime numbers
        is_prime(@latest_checked+=1) # check if next number is prime
      end
    end
    return @primes[0...n]
  end
  def self.is_prime(n)
    return false if !n.is_a?(Integer) || n <= 1
    return true if n == 2
    # n is_prime if not evenly divisible by prime integers from 2..sqrt(n)
    sqrt = Math.sqrt(n).ceil
    # puts "checking if #{n} is prime based on @primes=#{@primes} up to sqrt(#{n})=#{sqrt}; @latest_checked=#{@latest_checked}"
    i=0 # index counter for @primes array
    until @primes[i] >= sqrt # until reached last prime number to check (i.e. sqrt(n))
      return false if n % @primes[i] == 0 # evenly divisible, so cannot be prime
      i += 1 # increment index counter for @primes array
      if i > @primes.length-1 # @primes array does not have enough numbers to check
        until i == @primes.length-1 # until @primes array has enough elements to check for index i
          is_prime(@latest_checked+=1) # check if next number is prime
          adj = -1
        end
      end
    end
    if n == @latest_checked || n == @latest_checked+1
      @latest_checked = n 
    end
    if n % @primes[i] != 0 # is_prime b/c not evenly divisible by any prime btwn 2..sqrt(n)
      if n == @latest_checked
        @primes.push(n) # add number to prime
      end
      return true
    end
    return false
  end
end