require_relative('custom_enumerables')

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
p(%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
p(%w[ant bear cat].my_any?(/d/)) #=> false
p([nil, true, 99].my_any?(Integer)) #=> true
p([nil, true, 99].my_any?) #=> true
p([].my_any?) #=> false

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
p((1..4).my_map { |i| i * i }) #=> [1, 4, 9, 16]

# calling my_map_proc enumerable
puts "\n my_map_proc"
str1 = %w[aa dd gg]
p(str1.my_map)
p(num.my_map { |i| i * i }) #=> [25, 49, 9, 16, 25]
p((1..4).my_map { |i| i * i }) #=> [1, 4, 9, 16]

# calling my_inject enumerable
puts "\n my_inject"
p((5..10).my_inject(:+)) #=> 45
p((5..10).my_inject { |sum, n| sum + n }) #=> 45
p((5..10).my_inject(1, :*)) #=> 151200
p((5..10).my_inject(1) { |product, n| product * n }) #=> 151200
longest = %w[cat sheep bear].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
p(longest) #=> "sheep"

# testing my_injcet method
puts "\n Testing my_injcet method "
p multiply_els([2, 4, 5])
