module Enumerable
  # custom enumerable method that resembles built-in my_each enumerable
  def my_each
    if block_given?
      i = 0
      while i < size
        break if i == size

        yield self[i]
        i += 1
      end
    else
      yield self
    end
  end

  # custom enumerable method that resembles built-in each_with_index enumerable
  def my_each_with_index
    if block_given?
      i = 0
      while i < size
        yield i, self[i]
        i += 1
      end
    else
      yield self
    end
  end

  # custom enumerable method that resembles built-in select enumerable
  def my_select(&block)
    result = []
    my_each do |x|
      result << x if block.call(x)
    end
    result
  end

  def my_all(&block)
    res = true
    return res if self.empty?

    my_each do |_elem|
    if block_given?
      if block.call(_elem) == false
        res = false
        break
      end
      else
      if _elem==false || _elem==nil
      res=false
    end
    res
  end
end
num = [5, 7, 3, 4, 5]
str = %w[a b c d]

# calling my_each enumerable
num.my_each { |x| puts "x=#{x}" }
str.my_each { |y| puts "y=#{y}" }

# calling my_each_with_index enumerable
num.my_each_with_index { |index, item| puts "index=#{index}, item=#{item}" }
str.my_each_with_index { |index, item| puts "index=#{index}, item=#{item}" }

# calling my_select enumerable
p(num.my_select { |x| x > 3 })

# calling my_all enumerable
num_1=[]
p(num_1.my_all { |x| x >= 3 })
