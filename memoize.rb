module Memoize

  def memoize(method_name)
    orig_method = 'orig_' + method_name.to_s
    alias_method orig_method, method_name

    cache = {}

    define_method(method_name) do |*args|
      return cache[args] if cache.has_key?(args)
      cache[args] = self.send orig_method, *args
    end
  end

end
