require_relative 'prime'
require 'stringio'
require 'colorize'

module MultiplicationTable
  def self.capture_stdout(&blk)
    old = $stdout
    $stdout = fake = StringIO.new
    blk.call
    fake.string
  ensure
    $stdout = old
  end

  def self.initialize
    self.print_header(create_multiplication_table(10), true)
    self.print_table(create_multiplication_table(10))
    self.instructions
  end

  def self.instructions
    print "Enter a number, N, to generate another multiplication table of the first N prime numbers, or type 'q' or quit program: "
    input = $stdin.gets.chomp
    exit if input.downcase == 'q'
    table = create_multiplication_table(input.to_i)
    self.print_header(table)
    self.print_table(table)
    self.instructions
  end

  def self.print_header(table=[], default=nil)
    default = default
    table = table
    header = ''
    max_digits = table[-1][-1].to_s.length
    line_break = ("-"*((max_digits+6)*table[0].length))
    if default != true
      puts "Type custom header or hit enter to use default header 'Prime Multiplication Table'"
      header = gets.chomp
    end
    if header.empty? || default == true
      puts "Prime Multiplication Table\nFirst #{table[0].length-1} Prime Numbers"
      puts line_break
    else
      puts header
    end
  end
  # create multiplication table if given an array of factors or an integer N
  def self.create_multiplication_table(n_or_arr)
    if n_or_arr.is_a?(Array) && n_or_arr.all? {|i| i.is_a?(Fixnum) }
      factors = n_or_arr
    elsif n_or_arr.is_a?(Integer) && n_or_arr > 0
      # if passed an integer N, defaults to create Prime Multiplication Table
      factors = Prime.first_primes(n_or_arr)
    else
      return false # can only pass in integer or an array of factors
    end
    factors.unshift(1)

    # create multiplication table storing numbers as array of array
    table = Array.new(factors.length,factors) # add extra row/col for headers

    # multiply all cells in a row by factors[index] with index corresponding to row's index
    col=0
    factors.each_with_index do |num, index|
      factor = table[0][col]
      table[index] = factors.map {|n| n*factor}
      col+=1
    end

    table[0][0]=nil # create blank top-left corner in table
    return table
  end # end of create_multiplication_table(n_or_arr)

  def self.print_table(table)
    # quick check to see if table is generally valid format (w/o looping through entire table)
    return false if !table.is_a?(Array) || !table[0].is_a?(Array) || !table[-1].is_a?(Array) || !table[-1][-1].is_a?(Integer)
    max_digits = table[-1][-1].to_s.length # max_digits *should* be last number in last array element
    line_break = ("-"*((max_digits+6)*table[0].length))

    # print each row on a single line
    table.each_with_index do |row, row_index|
      return false if row.length != table[0].length
      print "| " # start of each row
      # print each number in a cell
      row.each_with_index do |num, col_index|
        i = (max_digits+1) - num.to_s.length
        lines = " "*i + " | "
        if row_index == 0 || col_index == 0 # format headers to blue color
          formatted_num = num.to_s.light_blue
        else
          formatted_num = num.to_s
        end
        line = ("  " + formatted_num + lines)
        print line
      end
      puts "\n#{line_break}" # end of each row
    end
  end # end of print_table(table) method

end