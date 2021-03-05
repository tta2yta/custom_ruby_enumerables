require_relative('custom_enumerables')

num = [5, 7, 3, 4, 5]
str = %w[a b c]
hsh = { name: 'ted', age: 30, sex: 'male' }

# calling my_each enumerable
puts "\n my_each"
num.my_each { |x| puts "x=#{x}" }
str.my_each { |y| puts "item=#{y}" }
hsh.my_each { |x, y| puts "index x=#{x}, item=#{y}" }
p(1..10).my_each
p(str.my_each)

# calling my_each_with_index enumerable
puts "\n my_each_with_index"
num.my_each_with_index { |index, item| puts "index=#{index}, item=#{item}" }
str.my_each_with_index { |index, item| puts "index=#{index}, item=#{item}" }
p(1..10).my_each_with_index
p(str.my_each_with_index)
str.my_each_with_index { |y| puts "item=#{y}" }
hsh.my_each_with_index { |x, y| puts "index x=#{x}, item=#{y}" }

# calling my_select enumerable
puts "\n my_select"
p(num.my_select { |x| x > 3 })
p([1, 2, 3, 4, 5].my_select(&:even?)) #=> [2, 4]
p(%i[foo bar].my_select { |x| x == :foo }) #=> [:foo]

# calling my_all enumerable
puts "\n my_all"
p(%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
p(%w[ant bear cat].my_all?(/t/)) #=> false
p([1, 2i, 3.14].my_all?(Numeric)) #=> true
p([nil, true, 99].my_all?) #=> false
p([].my_all?) #=> true
p(1..10).my_all?(Numeric)
array = []
5.times { array << 3 }
p array.my_all?(3)

# calling my_none enumerable
puts "\n my_none"
p(%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
p(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
p(%w[ant bear cat].my_none?(/d/)) #=> true
p([1, 3.14, 42].my_none?(Float)) #=> false
p([].my_none?) #=> true
p([nil].my_none?) #=> true
p([nil, false].my_none?) #=> true
p([nil, false, true].my_none?) #=> false
p(1..10).my_none?(Numeric)
array = []
5.times { array << 3 }
p array.my_none?(3)
p array

# calling my_any enumerable
puts "\n my_any"
p(%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
p(%w[ant bear cat].my_any?(/d/)) #=> false
p([nil, true, 99].my_any?(Integer)) #=> true
p([nil, true, 99].my_any?) #=> true
p([].my_any?) #=> false
p(1..10).my_any?(Numeric)
array = []
5.times { array << 3 }
p array.my_any?(3)
p array

# calling my_count enumerable
puts "\n my_count"
ary = [1, 2, 4, 2]
p(ary.my_count) #=> 4
p(ary.my_count(2)) #=> 2
p(ary.my_count(&:even?)) #=> 3

# calling my_map enumerable
puts "\n my_map"
str1 = %w[aa dd gg]
p(str1.my_map)
p(num.my_map { |i| i * i }) #=> [25, 49, 9, 16, 25]
p((1..4).my_map { |i| i * i }) #=> [1, 4, 9, 16]
factor = proc { |n| print n * 2 }
# using the proc value
[3, 2, 1].my_map(&factor)

# calling my_map_proc enumerable
# puts "\n my_map_proc"
# str1 = %w[aa dd gg]
# p(str1.my_map2)
# p(num.my_map2 { |i| i * i }) #=> [25, 49, 9, 16, 25]
# p((1..4).my_map2 { |i| i * i }) #=> [1, 4, 9, 16]

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
# p((5..10).my_inject)

# testing my_injcet method
puts "\n Testing my_injcet method "
p(multiply_els([2, 4, 5]))
