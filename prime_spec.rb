require "./prime"
require "rspec/autorun"

RSpec.describe "module Prime" do
  before :each do
    @prime = Prime
    @prime.reset
  end
  describe "Prime module" do
    it "is a kind of Module" do
      expect(@prime).to be_a(Module)
    end
    it "has array of @primes" do
      expect(@prime.current_primes).to be_a(Array)
    end
    it "@primes initially includes first prime: @primes=[2]" do
      expect(@prime.current_primes).to eq([2])
    end
    it "has a variable @latest_checked, representing the last integer in sequence checked for is_prime" do
      expect(@prime.latest_checked).to be_a(Integer)
    end
    it "initially @latest_checked=2" do
      expect(@prime.latest_checked).to eq(2)
    end
  end

  describe "#is_prime(n)" do
    it "takes an integer > 1 as input" do
      expect(@prime.is_prime(-1)).to eq(false)
      expect(@prime.is_prime(0)).to eq(false)
      expect(@prime.is_prime(1)).to eq(false)
      expect(@prime.is_prime(2)).to eq(true)
      expect(@prime.is_prime(2.0)).to eq(false)
      expect(@prime.is_prime('a')).to eq(false)
      expect(@prime.is_prime([])).to eq(false)
      expect(@prime.is_prime(100)).to eq(false)
      expect(@prime.is_prime(47)).to eq(true)
    end
    it "rpsec resets @latest_checked and @current_primes after each test" do
      expect(@prime.latest_checked).to eq(2)
      expect(@prime.current_primes).to eq([2])
    end
    context "if n=3" do
      before do
        @x = @prime.is_prime(3)
      end
      it "return true" do
        expect(@x).to eq(true)
      end
      it "insert 3 into @primes array" do
        expect(@prime.current_primes).to eq([2,3])
      end
      it "@latest_checked=3 : Updated because last number checked in sequence was checked from 2 to 3" do
        expect(@prime.latest_checked).to eq(3)
      end
    end
    context "is_prime(4) after checking is_prime(3)" do
      before do
        @prime.is_prime(3)
        @x = @prime.is_prime(4)
      end
      it "return false" do
        expect(@x).to eq(false)
      end
      it "@primes=[2,3] : Running is_prime(3) resulted in insertion of 3 into @primes array" do
        expect(@prime.current_primes).to eq([2,3])
      end
      it "@latest_checked=4 : Updated because 2,3,4 were checked in sequence" do
        expect(@prime.latest_checked).to eq(4)
      end
    end
    context "n=4 is_prime(4)" do
      before do
        @x = @prime.is_prime(4)
      end
      it "return false" do
        expect(@x).to eq(false)
      end
      it "@primes array=[2] : No change because 4%2==0 returned true" do
        expect(@prime.current_primes).to eq([2])
      end
      it "@latest_checked=2 : No change because 2,3,4 were not checked in sequence (skipped 3)" do
        expect(@prime.latest_checked).to eq(2)
      end
    end
    context "n=8 is_prime(8)" do
      before do
        @x = @prime.is_prime(8)
      end
      it "return false" do
        expect(@x).to eq(false)
      end
      it "@primes array=[2] : Because 8%2==0 returned true; No need to find next prime integers up to sqrt(8)=3" do
        expect(@prime.current_primes).to eq([2])
      end
      it "@latest_checked=2 : No change because 8 was not checked in sequence (skipped 3,4,5,6,7)" do
        expect(@prime.latest_checked).to eq(2)
      end
    end
    context "n=13 is_prime(13)" do
      before do
        @x = @prime.is_prime(13)
      end
      it "return true" do
        expect(@x).to eq(true)
      end
      it "@primes=[2,3,5] : Updated primes integers from 2 to sqrt(13)=4" do
        expect(@prime.current_primes).to eq([2,3,5])
      end
      it "@latest_checked=5 : Updated because 2,3,4,5 checked in sequence.
        Once reached 5 which is >= sqrt(13)=4, no need to check subsequent integers" do
        expect(@prime.latest_checked).to eq(5)
      end
    end
    context "n=47 is_prime(47)" do
      before do
        @x = @prime.is_prime(47)
      end
      it "return true" do
        expect(@x).to eq(true)
      end
      it "@primes=[2,3,5,7] : Updated primes integers from 2 to sqrt(47)=7" do
        expect(@prime.current_primes).to eq([2,3,5,7])
      end
      it "@latest_checked=5 : Updated because 2,3,4,5,6,7 checked in sequence. Reached last integer to check which is sqrt(47)=7" do
        expect(@prime.latest_checked).to eq(7)
      end
    end
  end

  describe "#first_primes(n)" do
    it "takes an integer > 0 as input" do
      expect(@prime.first_primes(-1)).to eq(false)
      expect(@prime.first_primes(0)).to eq(false)
      expect(@prime.first_primes('a')).to eq(false)
      expect(@prime.first_primes([])).to eq(false)
      expect(@prime.first_primes(1.5)).to eq(false)
      expect(@prime.first_primes(1)).not_to eq(false)
      expect(@prime.first_primes(2)).not_to eq(false)
    end
    it "returns an array with N integers" do
      expect(@prime.first_primes(1)).to be_a(Array)
      expect(@prime.first_primes(2).length).to eq(2)
    end
    context "n=1 first_primes(1)" do
      it "returns an array of first prime [2]" do
        expect(@prime.first_primes(1)).to eq([2])
      end
    end
    context "n=2 first_primes(2)" do
      before do
        @x = @prime.first_primes(2)
      end
      it "returns an array of first 2 primes: [2,3]" do
        expect(@x).to eq([2,3])
      end
      it "@primes=[2,3] : Updated to contain first 2 primes" do
        expect(@prime.current_primes).to eq([2,3])
      end
      it "@latest_checked=3 : 3 is the last number checked to return first 2 primes" do
        expect(@prime.latest_checked).to eq(3)
      end
    end
    context "n=10 first_primes(10)" do
      before do
        @x = @prime.first_primes(10)
      end
      it "returns an array of first 10 primes: [2,3,5,7,11,13,17,19,23,29]" do
        expect(@x).to eq([2,3,5,7,11,13,17,19,23,29])
      end
      it "@primes=[2,3,5,7,11,13,17,19,23,29] : Updated to contain first 10 primes" do
        expect(@prime.current_primes).to eq([2,3,5,7,11,13,17,19,23,29])
      end
      it "@latest_checked=29 : 29 is the last number checked to return first 10 primes" do
        expect(@prime.latest_checked).to eq(29)
      end
    end
  end
  describe "is_prime(n1) && is_prime(n2)" do
    context "is_prime(3) then is_prime(4)" do
      it "is_prime(5) : true, @primes=[2,3], @latest_checked=3" do
        expect(@prime.is_prime(3)).to eq(true)
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
      it "is_prime(4) : false, @primes=[2,3], @latest_checked=4" do
        @prime.is_prime(5)
        expect(@prime.is_prime(4)).to eq(false)
        expect(@prime.latest_checked).to eq(4)
      end
    end
    context "is_prime(3) then is_prime(5)" do
      it "n2=1 is_prime(5) : true, @primes=[2,3], @latest_checked=3" do
        @prime.is_prime(3)
        expect(@prime.is_prime(5)).to eq(true)
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
    end
    context "is_prime(3) then is_prime(6)" do
      it "n2=6 is_prime(6) : false, @primes=[2,3], @latest_checked=3" do
        @prime.is_prime(3)
        expect(@prime.is_prime(6)).to eq(false)
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
    end
    context "is_prime(3) then is_prime(17)" do
      it "n2=17 is_prime(17) : false, @primes=[2,3,5], @latest_checked=3" do
        @prime.is_prime(3)
        expect(@prime.is_prime(17)).to eq(true)
        expect(@prime.current_primes).to eq([2,3,5])
        expect(@prime.latest_checked).to eq(5)
      end
    end
  end
  describe "first_primes(n1) && first_primes(n2)" do
    context "first_primes(2) then first_primes(3)" do
      it "n1=2 first_primes(2) : returns [2,3], @primes=[2,3], latest_checked=3" do
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
      it "n2=3 first_primes(3) : returns [2,3,5], @primes=[2,3,5], latest_checked=5" do
        @prime.first_primes(2)
        expect(@prime.first_primes(3)).to eq([2,3,5])
        expect(@prime.current_primes).to eq([2,3,5])
        expect(@prime.latest_checked).to eq(5)
      end
    end
    context "first_primes(2) then first_primes(4)" do
      it "n2=4 first_primes(4) : returns [2,3,5], @primes=[2,3,5,7], latest_checked=7" do
        @prime.first_primes(2)
        expect(@prime.first_primes(4)).to eq([2,3,5,7])
        expect(@prime.current_primes).to eq([2,3,5,7])
        expect(@prime.latest_checked).to eq(7)
      end
    end
    context "first_primes(4) then first_primes(2)" do
      it "n1=4 first_primes(4) : returns [2,3,5,7], @primes=[2,3,5,7], latest_checked=7" do
        expect(@prime.first_primes(4)).to eq([2,3,5,7])
        expect(@prime.current_primes).to eq([2,3,5,7])
        expect(@prime.latest_checked).to eq(7)
      end
      it "n1=2 first_primes(2) : returns [2,3], @primes=[2,3,5,7], latest_checked=7" do
        @prime.first_primes(4)
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3,5,7])
        expect(@prime.latest_checked).to eq(7)
      end
    end
  end
  describe "first_primes(n) THEN is_prime(n)" do
    context "first_primes(2) then is_prime(4)" do
      it "n1=2 first_primes(2) : returns [2,3], @primes=[2,3], @latest_checked=3" do
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
      it "n2=4 is_prime(4) : false, @primes=[2,3], @latest_checked=4" do
        @prime.first_primes(2)
        expect(@prime.is_prime(4)).to eq(false)
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(4)
      end
    end
    context "first_primes(6) then is_prime(6)" do
      it "n1=6 first_primes(6) : returns [2,3,5,7,11,13], @primes=[2,3,5,7,11,13], @latest_checked=13" do
        expect(@prime.first_primes(6)).to eq([2,3,5,7,11,13])
        expect(@prime.current_primes).to eq([2,3,5,7,11,13])
        expect(@prime.latest_checked).to eq(13)
      end
      it "n2=6 is_prime(6) : true, @primes=[2,3,5,7,11,13], @latest_checked=13" do
        @prime.first_primes(6)
        expect(@prime.is_prime(6)).to eq(false)
        expect(@prime.current_primes).to eq([2,3,5,7,11,13])
        expect(@prime.latest_checked).to eq(13)
      end
    end
    context "first_primes(3) then is_prime(23)" do
      it "n1=6 first_primes(3) : returns [2,3,5], @primes=[2,3,5], @latest_checked=5" do
        expect(@prime.first_primes(3)).to eq([2,3,5])
        expect(@prime.current_primes).to eq([2,3,5])
        expect(@prime.latest_checked).to eq(5)
      end
      it "n2=23 is_prime(23) : true, @primes=[2,3,5], @latest_checked=5" do
        @prime.first_primes(3)
        expect(@prime.is_prime(23)).to eq(true)
        expect(@prime.current_primes).to eq([2,3,5])
        expect(@prime.latest_checked).to eq(5)
      end
    end
    context "first_primes(3) then is_prime(29)" do
      it "n2=29 is_prime(29) : true, @primes=[2,3,5,6], @latest_checked=7" do
        @prime.first_primes(3)
        expect(@prime.is_prime(29)).to eq(true)
        expect(@prime.current_primes).to eq([2,3,5,7])
        expect(@prime.latest_checked).to eq(7)
      end
    end
  end
  describe "is_prime(n) THEN first_primes(n)" do
    context "is_prime(3) then first_primes(2)" do
      it "n1=3 is_prime(3) : true, @primes=[2,3], @latest_checked=3" do
        expect(@prime.is_prime(3)).to eq(true)
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
      it "n2=2 first_primes(2) : returns [2,3], @primes=[2,3], @latest_checked=3" do
        @prime.is_prime(3)
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
    end
    context "is_prime(4) then first_primes(2)" do
      it "n1=4 is_prime(4) : true, @primes=[2], @latest_checked=4" do
        expect(@prime.is_prime(4)).to eq(false)
        expect(@prime.current_primes).to eq([2])
        expect(@prime.latest_checked).to eq(2)
      end
      it "n2=2 first_primes(2) : returns [2,3], @primes=[2,3], @latest_checked=3" do
        @prime.is_prime(4)
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
    end
    context "is_prime(5) then first_primes(2)" do
      it "n1=5 is_prime(5) : true, @primes=[2,3], @latest_checked=3" do
        expect(@prime.is_prime(5)).to eq(true)
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
      it "n2=2 first_primes(2) : returns [2,3], @primes=[2,3], @latest_checked=3" do
        @prime.is_prime(5)
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
    end
  end
  describe "other combinations of is_prime(n) and first_primes(n)" do
    context "first_primes(2), is_prime(17), first_primes(5)" do
      it "n1=2 first_primes(2) : returns [2,3], @primes=[2,3], @latest_checked=3" do
        expect(@prime.first_primes(2)).to eq([2,3])
        expect(@prime.current_primes).to eq([2,3])
        expect(@prime.latest_checked).to eq(3)
      end
      it "n2=17 is_prime(17) : true, @primes=[2,3,5], @latest_checked=5" do
        @prime.first_primes(3)
        expect(@prime.is_prime(17)).to eq(true)
        expect(@prime.current_primes).to eq([2,3,5])
        expect(@prime.latest_checked).to eq(5)
      end
      it "n3=5 first_primes(5) : returns [2,3,5,7,11], @primes=[2,3,5,7,11], @latest_checked=11" do
        @prime.first_primes(2)
        @prime.is_prime(17)
        expect(@prime.first_primes(5)).to eq([2,3,5,7,11])
        expect(@prime.current_primes).to eq([2,3,5,7,11])
        expect(@prime.latest_checked).to eq(11)
      end
    end
    context "first_primes(4), is_prime(5), first_primes(6) is_prime(6) is_prime(307)" do
      it "n1=4 first_primes(4) : returns [2,3,5,7], @primes=[2,3,5,7], @latest_checked=7" do
        expect(@prime.first_primes(4)).to eq([2,3,5,7])
        expect(@prime.current_primes).to eq([2,3,5,7])
        expect(@prime.latest_checked).to eq(7)
      end
      it "n2=5 is_prime(5) : true, @primes=[2,3,5,7], @latest_checked=7" do
        @prime.first_primes(4)
        expect(@prime.is_prime(5)).to eq(true)
        expect(@prime.current_primes).to eq([2,3,5,7])
        expect(@prime.latest_checked).to eq(7)
      end
      it "n3=6 first_primes(6) : returns [2,3,5,7,11,13], @primes=[2,3,5,7,11,13], @latest_checked=13" do
        @prime.first_primes(4)
        @prime.is_prime(5)
        expect(@prime.first_primes(6)).to eq([2,3,5,7,11,13])
        expect(@prime.current_primes).to eq([2,3,5,7,11,13])
        expect(@prime.latest_checked).to eq(13)
      end
      it "n4=6 is_prime(6) : false, @primes=[2,3,5,7,11,13], @latest_checked=13" do
        @prime.first_primes(4)
        @prime.is_prime(5)
        @prime.first_primes(6)
        expect(@prime.is_prime(6)).to eq(false)
        expect(@prime.current_primes).to eq([2,3,5,7,11,13])
        expect(@prime.latest_checked).to eq(13)
      end
      it "n4=6 is_prime(307) : true, @primes=[2,3,5,7,11,13,17,19], @latest_checked=19" do
        @prime.first_primes(4)
        @prime.is_prime(5)
        @prime.first_primes(6)
        @prime.is_prime(6)
        expect(@prime.is_prime(311)).to eq(true)
        expect(@prime.current_primes).to eq([2,3,5,7,11,13,17,19])
        expect(@prime.latest_checked).to eq(19)
      end
    end
  end
end
