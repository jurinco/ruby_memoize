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
end
