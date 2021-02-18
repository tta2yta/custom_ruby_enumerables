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
    ctr = 0
    my_each { |value| ctr += 1 if yield(value) }
    ctr
  end

  # custom enumerable method that resembles built-in map enumerable
  def my_map()
    res = []
    return self unless block_given?

    my_each { |value| res << yield(value) }
    res
  end
 # custom enumerable method that resembles built-in inject enumerable
  def my_inject(initial = nil, second = nil)
    arr = is_a?(Array) ? self : to_a
    sym = initial if initial.is_a?(Symbol) || initial.is_a?(String)
    acc = initial if initial.is_a? Integer

    if initial.is_a?(Integer)
      sym = second if second.is_a?(Symbol) || second.is_a?(String)
    end

    if sym
      arr.my_each { |x| acc = acc ? acc.send(sym, x) : x }
    elsif block_given?
      arr.my_each { |x| acc = acc ? yield(acc, x) : x }
    end
    acc
  end

  # method that tests my_inject enumerable method
  def multiply_els()
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
p(%w[ant bear cat].any? { |word| word.length >= 4 }) #=> true
p(%w[ant bear cat].any?(/d/)) #=> false
p([nil, true, 99].any?(Integer)) #=> true
p([nil, true, 99].any?) #=> true
p([].any?) #=> false

# calling my_count enumerable
puts "\n my_count"
ary = [1, 2, 4, 2]
p(ary.count) #=> 4
p(ary.count(2)) #=> 2
p(ary.count(&:even?)) #=> 3

# calling my_map enumerable
puts "\n my_map"
str1 = %w[aa dd gg]
p(str1.my_map)
p(num.my_map { |i| i * i }) #=> [25, 49, 9, 16, 25]
p((1..4).map { |i| i * i }) #=> [1, 4, 9, 16]

# calling my_inject enumerable
puts "\n my_inject"
p((5..10).my_inject(:+)) #=> 45
p((5..10).inject { |sum, n| sum + n }) #=> 45
p((5..10).reduce(1, :*)) #=> 151200
p((5..10).inject(1) { |product, n| product * n }) #=> 151200
longest = %w[cat sheep bear].inject do |memo, word|
  memo.length > word.length ? memo : word
end
p(longest) #=> "sheep"
