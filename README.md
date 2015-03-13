````
class Fib
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
````

````
f = Fib.new
f.slow_compute(35)
f.compute(35)
f.compute(2000)
````