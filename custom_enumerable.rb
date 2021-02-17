module Enumerable
  # custom enumerable method that resembles buit-in my_each enumerable
  def my_each
    if block_given?
      i = 0
      while i < size
        yield self[i]
        i += 1
      end
    else
      yield self
    end
  end

# custom enumerable method that resembles buit-in each_with_index enumerable
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
end
num = [1, 2, 3, 4, 5]
str = %w[a b c d]

# calling my_each enumerable
num.my_each { |x| puts "x=#{x}" }
str.my_each { |y| puts "y=#{y}" }