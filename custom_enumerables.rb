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
  def my_select()
    return enum_for(:my_select) unless block_given?

    result = []
    my_each do |x|
      result << x if yield(x)
    end
    result
  end

  def my_all?(args = nil)
    res = true

    if args.nil?
      my_each do |elem|
        if block_given?
          if yield(elem) == false
            res = false
            break
          end
        elsif elem == false || elem.nil?
          res = false
        end
      end
    elsif args.is_a?(Regexp)
      my_each { |value| return false unless value.match(args) }
    elsif args.is_a?(Class)
      my_each { |value| return false unless value.is_a?(args) }
    else
      my_each { |value| return false if value != args }
    end
    res
  end

  # custom enumerable method that resembles built-in none enumerable
  def my_none?(args = nil)
    res = true
    if args.nil?
      my_each do |elem|
        if block_given?
          if yield(elem) == true
            res = false
            break
          end
        elsif elem == true
          res = false
        end
      end
    elsif args.is_a?(Regexp)
      my_each { |value| return false if value.match?(args) }
    elsif args.is_a?(Class)
      my_each { |value| return false if value.is_a?(args) }
    else
      my_each { |value| return false if value == args }
    end
    res
  end

  # custom enumerable method that resembles built-in any enumerable
  def my_any?(args = nil)
    res = false

    if args.nil?
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
    elsif args.is_a?(Regexp)
      my_each { |value| return true if value.match?(args) }
    elsif args.is_a?(Class)
      my_each { |value| return true if value.is_a?(args) }
    else
      my_each { |value| return true if value == args }
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

  # custom enumerable method that resembles built-in map enumerable that accepts block and proc
  def my_map(proc = nil)
    return enum_for(:my_map) unless block_given?

    result = []
    arr = is_a?(Range) || Hash ? to_a : self
    if proc.nil?
      arr.my_each { |value| result << yield(value) }
    else
      arr.my_each { |k, v| result << proc.call(k, v) }
    end
    result
  end

  # custom enumerable method that resembles built-in inject enumerable
  def my_inject(initial = nil, second = nil)
    arr = is_a?(Array) ? self : to_a
    sym = initial if initial.is_a?(Symbol) || initial.is_a?(String)
    acc = initial if initial.is_a? Integer

    sym = second if initial.is_a?(Integer) && (second.is_a?(Symbol) || second.is_a?(String))

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
