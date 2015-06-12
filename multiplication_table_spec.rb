require "./prime"
require "./multiplication_table"
require "rspec/autorun"

RSpec.describe "module MultiplicationTable" do
  before :each do
    @table = MultiplicationTable
  end
  describe "MultiplicationTable module" do
    it "is a kind of Module" do
      expect(@table).to be_a(Module)
    end
  end
  describe "#create_multiplication_table(n_or_arr)" do
    context "accepts integer>0 or array of integers as input" do
      it "does not accept non-integer numbers" do
        expect(@table.create_multiplication_table(1.0)).to eq(false)
        expect(@table.create_multiplication_table('a')).to eq(false)
        expect(@table.create_multiplication_table(true)).to eq(false)
        expect(@table.create_multiplication_table({:kim => "pham"})).to eq(false)
      end
      it "does not accept numbers < 1" do
        expect(@table.create_multiplication_table(-1)).to eq(false)
        expect(@table.create_multiplication_table(0)).to eq(false)
      end
      it "accepts integers > 0 " do
        expect(@table.create_multiplication_table(1)).not_to eq(false)
        expect(@table.create_multiplication_table(2)).not_to eq(false)
      end
      it "accepts array with 1 or more elements" do
        expect(@table.create_multiplication_table([1])).not_to eq(false)
        expect(@table.create_multiplication_table([2,3,5])).not_to eq(false)
        expect(@table.create_multiplication_table([1,2,3])).not_to eq(false)
      end
      it "does not accept arrays of non-integers" do
        expect(@table.create_multiplication_table(["a","b","c"])).to eq(false)
      end
    end
    context "returns an array" do
      before do
        @table = @table.create_multiplication_table(1)
      end
      it "returned array contains subarrays" do
        expect(@table).to be_a(Array)
        expect(@table[0]).to be_a(Array)
        expect(@table[1]).to be_a(Array)
      end
      it "arrays.size == n+1" do
        expect(@table.length).to eq(2)
      end
      it "subarray.size == n+1" do
        expect(@table[0].length).to eq(2)
        expect(@table[1].length).to eq(2)
      end
    end
    context "n_or_arr=1" do
      it "returns [[nil,2],[2,4]]" do
        expect(@table.create_multiplication_table(1)).to eq([[nil,2],[2,4]])
      end
    end
    context "n_or_arr=2" do
      it "returns [[nil,2,3],[2,4,6],[3,6,9]]" do
        expect(@table.create_multiplication_table(2)).to eq([[nil,2,3],[2,4,6],[3,6,9]])
      end
    end
    context "n_or_arr=10" do
      it "returns 
        [[nil,2,3,5,7,11,13,17,19,23,29],
          [2,4,6,10,14,22,26,34,38,46,58],
          [3,6,9,15,21,33,39,51,57,69,87],
          [5,10,15,25,35,55,65,85,95,115,145],
          [7,14,21,35,49,77,91,119,133,161,203],
          [11,22,33,55,77,121,143,187,209,253,319],
          [13,26,39,65,91,143,169,221,247,299,377],
          [17,34,51,85,119,187,221,289,323,391,493],
          [19,38,57,95,133,209,247,323,361,437,551],
          [23,46,69,115,161,253,299,391,437,529,667],
          [29,58,87,145,203,319,377,493,551,667,841]]" do
        expect(@table.create_multiplication_table(10)).to eq([[nil,2,3,5,7,11,13,17,19,23,29],[2,4,6,10,14,22,26,34,38,46,58],[3,6,9,15,21,33,39,51,57,69,87],[5,10,15,25,35,55,65,85,95,115,145],[7,14,21,35,49,77,91,119,133,161,203],[11,22,33,55,77,121,143,187,209,253,319],[13,26,39,65,91,143,169,221,247,299,377],[17,34,51,85,119,187,221,289,323,391,493],[19,38,57,95,133,209,247,323,361,437,551],[23,46,69,115,161,253,299,391,437,529,667],[29,58,87,145,203,319,377,493,551,667,841]])
      end
    end
    context "n_or_arr=[2,3,5]" do
      it "returns [[nil,2,3,5],[2,4,6,10],[3,6,9,15],[5,10,15,25]]" do
        expect(@table.create_multiplication_table([2,3,5])).to eq([[nil,2,3,5],[2,4,6,10],[3,6,9,15],[5,10,15,25]])
      end
    end
    context "n_or_arr=[1,2,3] #=> Accepts arrays of any integers, regardless if prime or not" do
      it "returns [[nil,1,2,3],[1,1,2,3],[2,2,4,6],[3,3,6,9]]" do
        expect(@table.create_multiplication_table([1,2,3])).to eq([[nil,1,2,3],[1,1,2,3],[2,2,4,6],[3,3,6,9]])
      end
    end
    
  end

  describe "#print_table(table)" do
    context "accepts an array of arrays" do
      it "does ...." do
      end
    end
    context "table=[1,2,3], print_table([1,2,3])" do
      it "prints a multiplication table:
       |      |   1  |   2  |   3  |
       ----------------------------
       |   1  |   1  |   2  |   3  |
       ----------------------------
       |   2  |   2  |   4  |   6  |
       ----------------------------
       |   3  |   3  |   6  |   9  |
       ----------------------------" do
        expected_output = "|      |   \e[0;94;49m1\e[0m  |   \e[0;94;49m2\e[0m  |   \e[0;94;49m3\e[0m  | \n----------------------------\n|   \e[0;94;49m1\e[0m  |   1  |   2  |   3  | \n----------------------------\n|   \e[0;94;49m2\e[0m  |   2  |   4  |   6  | \n----------------------------\n|   \e[0;94;49m3\e[0m  |   3  |   6  |   9  | \n----------------------------\n"
        
        output = @table.capture_stdout do
          table_to_print = @table.create_multiplication_table([1,2,3])
          @table.print_table(table_to_print)
        end

        expect(output).to eq(expected_output)
      end
    end
    context "table=create_multiplication_table(10); print_table(table)" do
      it "print multiplication table of first 10 primes:
       |        |   2    |   3    |   5    |   7    |   11   |   13   |   17   |   19   |   23   |   29   |
       ---------------------------------------------------------------------------------------------------
       |   2    |   4    |   6    |   10   |   14   |   22   |   26   |   34   |   38   |   46   |   58   |
       ---------------------------------------------------------------------------------------------------
       |   3    |   6    |   9    |   15   |   21   |   33   |   39   |   51   |   57   |   69   |   87   |
       ---------------------------------------------------------------------------------------------------
       |   5    |   10   |   15   |   25   |   35   |   55   |   65   |   85   |   95   |   115  |   145  |
       ---------------------------------------------------------------------------------------------------
       |   7    |   14   |   21   |   35   |   49   |   77   |   91   |   119  |   133  |   161  |   203  |
       ---------------------------------------------------------------------------------------------------
       |   11   |   22   |   33   |   55   |   77   |   121  |   143  |   187  |   209  |   253  |   319  |
       ---------------------------------------------------------------------------------------------------
       |   13   |   26   |   39   |   65   |   91   |   143  |   169  |   221  |   247  |   299  |   377  |
       ---------------------------------------------------------------------------------------------------
       |   17   |   34   |   51   |   85   |   119  |   187  |   221  |   289  |   323  |   391  |   493  |
       ---------------------------------------------------------------------------------------------------
       |   19   |   38   |   57   |   95   |   133  |   209  |   247  |   323  |   361  |   437  |   551  |
       ---------------------------------------------------------------------------------------------------
       |   23   |   46   |   69   |   115  |   161  |   253  |   299  |   391  |   437  |   529  |   667  |
       ---------------------------------------------------------------------------------------------------
       |   29   |   58   |   87   |   145  |   203  |   319  |   377  |   493  |   551  |   667  |   841  |
       ---------------------------------------------------------------------------------------------------" do
        expected_output = "|        |   \e[0;94;49m2\e[0m    |   \e[0;94;49m3\e[0m    |   \e[0;94;49m5\e[0m    |   \e[0;94;49m7\e[0m    |   \e[0;94;49m11\e[0m   |   \e[0;94;49m13\e[0m   |   \e[0;94;49m17\e[0m   |   \e[0;94;49m19\e[0m   |   \e[0;94;49m23\e[0m   |   \e[0;94;49m29\e[0m   | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m2\e[0m    |   4    |   6    |   10   |   14   |   22   |   26   |   34   |   38   |   46   |   58   | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m3\e[0m    |   6    |   9    |   15   |   21   |   33   |   39   |   51   |   57   |   69   |   87   | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m5\e[0m    |   10   |   15   |   25   |   35   |   55   |   65   |   85   |   95   |   115  |   145  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m7\e[0m    |   14   |   21   |   35   |   49   |   77   |   91   |   119  |   133  |   161  |   203  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m11\e[0m   |   22   |   33   |   55   |   77   |   121  |   143  |   187  |   209  |   253  |   319  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m13\e[0m   |   26   |   39   |   65   |   91   |   143  |   169  |   221  |   247  |   299  |   377  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m17\e[0m   |   34   |   51   |   85   |   119  |   187  |   221  |   289  |   323  |   391  |   493  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m19\e[0m   |   38   |   57   |   95   |   133  |   209  |   247  |   323  |   361  |   437  |   551  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m23\e[0m   |   46   |   69   |   115  |   161  |   253  |   299  |   391  |   437  |   529  |   667  | \n---------------------------------------------------------------------------------------------------\n|   \e[0;94;49m29\e[0m   |   58   |   87   |   145  |   203  |   319  |   377  |   493  |   551  |   667  |   841  | \n---------------------------------------------------------------------------------------------------\n"

        output = @table.capture_stdout do
          table_to_print = @table.create_multiplication_table(10)
          @table.print_table(table_to_print)
        end
        expect(output).to eq(expected_output)
      end
    end
  end
end