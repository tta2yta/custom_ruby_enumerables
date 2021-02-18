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

  def my_all?(*args, &block)
    res = true
    return res if empty?

    if args.empty?
      my_each do |elem|
        if block_given?
          if block.call(elem) == false
            res = false
            break
          end
        elsif elem == false || elem.nil?
          res = false
        end
      end
    elsif args[0].is_a?(Regexp)
      my_each { |value| return false unless value.match?(args[0]) }
    elsif args[0].is_a?(Module)
      my_each { |value| return false unless value.is_a?(args[0]) }
    end
    res
  end

    # custom enumerable method that resembles built-in none enumerable
  def my_none?(*args, &block)
    res = true
    return true if empty?

    if args.empty?
      my_each do |elem|
        if block_given?
          if block.call(elem) == true
            res = false
            break
          end
        elsif elem == false || elem.nil?
          res = false
        end
      end
    elsif args[0].is_a?(Regexp)
      my_each { |value| return false if value.match?(args[0]) }
    elsif args[0].is_a?(Module)
      my_each { |value| return false if value.is_a?(args[0]) }

    end
    res
  end
      # custom enumerable method that resembles built-in any enumerable
      def my_any?(*args, &block)
        res = false
        return false if empty?
    
        if args.empty?
          my_each do |elem|
              if block.call(elem) == true
                res = true
                break
              end
          end
        elsif args[0].is_a?(Regexp)
          my_each { |value| return true if value.match?(args[0]) }
        elsif args[0].is_a?(Module)
          my_each { |value| return true if value.is_a?(args[0]) }
        end
        res
      end
      # custom enumerable method that resembles built-in count enumerable
      def my_count()
        ctr=0
        my_each {|value| ctr += 1 if yield(value)}
        return ctr
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
p(%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
p(%w[ant bear cat].my_all?(/t/)) #=> false
p([1, 2i, 3.14].my_all?(Numeric)) #=> true
p([nil, true, 99].my_all?) #=> false
p([].my_all?) #=> true

# calling my_none enumerable
puts "\n my_none"
p(%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
p(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
p(%w[ant bear cat].my_none?(/d/)) #=> true
p([1, 3.14, 42].my_none?(Float)) #=> false
p([].none?) #=> true
p([nil].none?) #=> true
p([nil, false].none?) #=> true
p([nil, false, true].none?) #=> false

# calling my_any enumerable
puts "\n my_any"
p(%w[ant bear cat].any? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].any? { |word| word.length >= 4 })#=> true
p(%w[ant bear cat].any?(/d/))                        #=> false
p([nil, true, 99].any?(Integer))                     #=> true
p([nil, true, 99].any?)                              #=> true
p([].any?)                                           #=> false