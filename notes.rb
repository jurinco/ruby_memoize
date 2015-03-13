# [0 1 1 2 3 5 8 13 21 ...

# f(i) = 0               if i == 0
#        1               if i == 1
#        f(i-1) + f(i-2) if i > 1

module Memoize
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def memoize(method_name)
      orig_method = 'orig_' + method_name.to_s
      alias_method orig_method, method_name
      results = {}
      define_method(method_name) do |*args|
        return results[args] if results.has_key?(args)
        results[args] = self.send orig_method, *args
      end
    end
  end
end

class Fib
  include Memoize

  def compute(i)
    return i if i < 2
    compute(i-1) + compute(i-2)
  end
  memoize :compute

  def slow(a, b, c)
    # does something stupid and slow with a, b, and c
    nil
  end
  memoize :slow

  #   def iter_compute(i)
#     results = [0,1]
#     return results[i] if i <= 1
#     a = 1
#     b = 1
#     (i-2).times do
#       new = a + b
#       a = b
#       b = new
#     end
#     b
#   end

#   def compute(i, results=[0, 1])
#     results[i] ||= compute(i-1, results) + compute(i-2, results)
#   end
end

p Fib.new.compute(256)

#                 10             1
#           9            8       2
#         8   7        7   6     4
#       7  6 6 5      6 5 5 4    8
#      6 ........   ...........  16
#               O(2^n)

p [Fib.new.compute(0), Fib.new.compute(0) == 0]
p [Fib.new.compute(1), Fib.new.compute(1) == 1]
p [Fib.new.compute(2), Fib.new.compute(2) == 1]
p [Fib.new.compute(3), Fib.new.compute(3) == 2]
p [Fib.new.compute(10), Fib.new.compute(10) == 55]

