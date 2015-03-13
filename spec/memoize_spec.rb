require_relative '../memoize'

describe Memoize do
  let(:fib) do
    Class.new do
      extend Memoize

      def compute(i)
        return i if i < 2
        compute(i-1) + compute(i-2)
      end
      memoize :compute

      def slow_compute(i)
        return i if i < 2
        slow_compute(i-1) + slow_compute(i-2)
      end
    end
  end


  describe "#memoize" do
    it "should ..." do
      # expect(Myclass.say_hello(@name)).to eq "hello Radu"
    end
    it "caches multiple methods" do
    end
  end
end
