module Enumerable
  # custom enumerable method that resembles built-in my_each enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    index = 0
    while index < size
      if is_a?(Array)
        yield(self[index])
      elsif is_a?(Range)
        yield(to_a[index])
      elsif is_a?(Hash)
        yield([keys[index], self[keys[index]]])
      end
      index += 1
    end

    self
  end

  # custom enumerable method that resembles built-in each_with_index enumerable
  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    index = 0
    while index < size
      if is_a?(Array)
        yield(self[index], index)
      elsif is_a?(Range)
        yield(to_a[index], index)
      elsif is_a?(Hash)
        yield([keys[index], self[keys[index]]], index)
      end
      index += 1
    end

    self
  end

  # custom enumerable method that resembles built-in select enumerable
  def my_select(&block)
    return enum_for(:my_select) unless block_given?

    result = []
    my_each do |x|
      result << x if block.call(x)
    end
    result
  end

  def my_all?(*args, &block)
    res = true

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
    else
      my_each { |value| return false unless value.is_a?(args[0]) }
    end
    res
  end

  # custom enumerable method that resembles built-in none enumerable
  def my_none?(*args, &block)
    res = true
    if args.empty?
      my_each do |elem|
        if block_given?
          if block.call(elem) == true
            res = false
            break
          end
        elsif elem == true
          res = false
        end
      end
    elsif args[0].is_a?(Regexp)
      my_each { |value| return false if value.match?(args[0]) }
    elsif args[0].is_a?(Module)
      my_each { |value| return false if value.is_a?(args[0]) }
    else
      my_each { |value| return false if value.is_a?(args[0]) }
    end
    res
  end

  # custom enumerable method that resembles built-in any enumerable
  def my_any?(*args)
    res = false

    if args.empty?
      my_each do |elem|
        if block_given?
          if yield(elem) == true
            res = true
            break
          end
        elsif elem == true
          res = true
          break
        end
      end
    elsif args[0].is_a?(Regexp)
      my_each { |value| return true if value.match?(args[0]) }
    elsif args[0].is_a?(Module)
      my_each { |value| return true if value.is_a?(args[0]) }
    else
      my_each { |value| return true if value.is_a?(args[0]) }
    end
    res
  end

  # custom enumerable method that resembles built-in count enumerable
  def my_count(num = nil)
    count = 0
    if num.nil?
      if block_given?
        my_each { |value| count += 1 if yield(value) }
      else
        count = size
      end
    else
      my_each do |value|
        count += 1 if num == value
      end
    end
    count
  end

  # custom enumerable method that resembles built-in map enumerable that accepts block
  def my_map
    result = []
    return enum_for(:my_map) unless block_given?

    if is_a?(Array) || is_a?(Range)
      my_each { |value| result << yield(value) }
    elsif is_a?(Hash)
      my_each { |k, v| result << yield(k, v) }
    end
    result
  end

  # custom enumerable method that resembles built-in map that accepts proc
  def my_map2(&proc)
    result = []
    return enum_for(:my_map2) unless block_given?

    if is_a?(Array) || is_a?(Range)
      my_each { |value| result << proc.call(value) }
    elsif is_a?(Hash)
      my_each { |k, v| result << proc.call(k, v) }
    end
    result
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
    else
      raise LocalJumpError
    end
    acc
  end

  # method that tests my_inject enumerable method
  def multiply_els()
    arr.my_inject
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
